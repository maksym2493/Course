import 'package:expense_tracker/widgets/new_expense/field.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.onAddExpense, {super.key});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;
  final _titleControler = TextEditingController();
  final _amountControler = TextEditingController();

  void _presentDatePicker() async {
    final now = _selectedDate == null
        ? DateTime.now()
        : DateTime(
            _selectedDate!.year,
            _selectedDate!.month,
            _selectedDate!.day,
          );

    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: _selectedDate == null ? now : DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submitExpenseData() {
    final trimedTitle = _titleControler.text.trim();
    final enteredAmount = double.tryParse(_amountControler.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (trimedTitle.isEmpty || amountIsInvalid || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please, make sure a valid title, amount and date was entered.',
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: trimedTitle,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleControler.dispose();
    _amountControler.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constrains) {
        final width = constrains.maxWidth;

        final titleField = Field(
          'Title',
          _titleControler,
          maxLength: 50,
        );

        final amountField = Field(
          'Amount',
          _amountControler,
          prefix: '\$ ',
        );

        final dropdownButton = DropdownButton(
          value: _selectedCategory,
          items: Category.values
              .map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(
                    category.name[0].toUpperCase() + category.name.substring(1),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) {
              return;
            }

            setState(() {
              _selectedCategory = value;
            });
          },
        );

        final datePicker = Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _selectedDate == null
                    ? 'No date selected'
                    : formatter.format(_selectedDate!),
              ),
              IconButton(
                  onPressed: _presentDatePicker,
                  icon: const Icon(Icons.calendar_month))
            ],
          ),
        );

        final actionButtons = [
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _submitExpenseData,
            child: const Text('Save Expense'),
          ),
        ];

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: titleField,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: amountField,
                        ),
                      ],
                    )
                  else
                    titleField,
                  if (width >= 600)
                    Row(
                      children: [
                        dropdownButton,
                        datePicker,
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: amountField,
                        ),
                        datePicker,
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (width >= 600)
                    Row(
                      children: [
                        ...actionButtons,
                      ],
                    )
                  else
                    Row(
                      children: [
                        dropdownButton,
                        ...actionButtons,
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
