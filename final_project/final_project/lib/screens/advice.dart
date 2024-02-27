import 'package:final_project/data/categories.dart';
import 'package:final_project/main.dart';
import 'package:final_project/widgets/category/category_viewer.dart';
import 'package:final_project/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class AdviceScreen extends StatefulWidget {
  const AdviceScreen({super.key});

  @override
  State<AdviceScreen> createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const TopBar(title: 'Поради'),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Text(
                      'Для кращого розподілення коштів сьогодні краще вже не здійснювати транзакції.\n\nДля збільшення накопичень краще в межах двох днів мінімалізувати витрати.',
                      style: kText,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Категорії',
                style: kText2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Expanded(child: CategoryViewer(categories: categories)),
            ],
          ),
        ),
      ),
    );
  }
}
