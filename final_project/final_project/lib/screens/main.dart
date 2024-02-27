import 'package:final_project/data/history.dart';
import 'package:final_project/data/user_cards.dart';
import 'package:final_project/main.dart';
import 'package:final_project/widgets/card_viewer.dart';
import 'package:final_project/widgets/history/history_viewer.dart';
import 'package:flutter/material.dart';
import 'package:final_project/widgets/bottom_navigation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isLoading = true;

  Future<void> _showLoading() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _showLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _isLoading
              ? Center(
                  child: Image.asset(
                    'assets/images/loading_pic.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                      child: CardViewer(cardList: userCards),
                    ),
                    Text(
                      'Баланс: 1 000 грн.\n\nЗалишок: 500 грн.\nНакопичення: 500 грн.',
                      style: kText,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Історія',
                        style: kText2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: HistoryViewer(history: history),
                    ),
                    const SizedBox(height: 10),
                    const BottomNavigation(),
                  ],
                ),
        ),
      ),
    );
  }
}
