import 'package:flutter/material.dart';

class NewExpensePage extends StatefulWidget {
  const NewExpensePage({super.key});

  @override
  State<NewExpensePage> createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "New Expense",
      ),
    );
  }
}
