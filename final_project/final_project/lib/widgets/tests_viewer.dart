import 'package:final_project/main.dart';
import 'package:flutter/material.dart';

class TestsViewer extends StatefulWidget {
  const TestsViewer({
    super.key,
    required this.tests,
  });

  final List<List<String>> tests;

  @override
  State<TestsViewer> createState() => _TestsViewerState();
}

class _TestsViewerState extends State<TestsViewer> {
  int _index = 0;
  int _score = 0;
  String? _selectedAnswer;
  late List<String> _suffledTests;

  @override
  initState() {
    super.initState();
    _suffledTests = _getSuffledTests();
  }

  List<String> _getSuffledTests() {
    final suffledTests = List.of(widget.tests[_index].sublist(1));
    suffledTests.shuffle();

    return suffledTests;
  }

  void _chose(String answer) {
    if (answer == widget.tests[_index][1]) _score++;

    setState(() => _selectedAnswer = answer);
  }

  void _nextQuestion() {
    setState(() {
      _index++;
      _selectedAnswer = null;
      _suffledTests = _getSuffledTests();
    });
  }

  void _getResults() {
    setState(() {
      _index++;
      _selectedAnswer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final answers = _selectedAnswer != null
        ? [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 300,
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(minHeight: 60),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        _selectedAnswer == widget.tests[_index][1]
                            ? Colors.green
                            : Colors.red,
                        _selectedAnswer == widget.tests[_index][1]
                            ? Colors.green.withAlpha(150)
                            : Colors.red.withAlpha(150),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      _selectedAnswer!,
                      style: kText,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ]
        : [
            for (final answer in _suffledTests)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: _selectedAnswer != null
                            ? null
                            : () => _chose(answer),
                        child: Container(
                          width: 300,
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(minHeight: 60),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Text(
                              answer,
                              style: kText,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              )
          ];

    return widget.tests.isEmpty
        ? const Text('Nothing here')
        : AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            layoutBuilder: (currentChild, previousChildren) => Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            ),
            child: _index < widget.tests.length
                ? Column(
                    key: const ValueKey(1),
                    children: [
                      if (_selectedAnswer != null)
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder: (child, animation) =>
                              FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                          child: _index + 1 < widget.tests.length
                              ? ElevatedButton(
                                  onPressed: _nextQuestion,
                                  child: Text(
                                    'Наступне питання',
                                    style: kText,
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: _getResults,
                                  child: Text(
                                    'Переглянути результат',
                                    style: kText,
                                  ),
                                ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.tests[_index][0],
                            style: kText,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (child, animation) => FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                        layoutBuilder: (currentChild, previousChildren) =>
                            Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            ...previousChildren,
                            if (currentChild != null) currentChild,
                          ],
                        ),
                        child: Column(
                          key: ValueKey(_selectedAnswer),
                          children: answers,
                        ),
                      ),
                    ],
                  )
                : Column(
                    key: const ValueKey(2),
                    children: [
                      Text(
                        'Правильно $_score з ${widget.tests.length}',
                        style: kText,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => setState(() {
                          _index = 0;
                          _score = 0;
                          _suffledTests = _getSuffledTests();
                        }),
                        child: Text(
                          'Ще раз',
                          style: kText,
                        ),
                      ),
                    ],
                  ),
          );
  }
}
