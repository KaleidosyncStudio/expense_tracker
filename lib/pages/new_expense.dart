import 'package:expense_tracker/classes/objectbox.dart';
import 'package:expense_tracker/entities/category.dart';
import 'package:flutter/material.dart';

class NewExpensePage extends StatefulWidget {
  const NewExpensePage({super.key});

  @override
  State<NewExpensePage> createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  final TextEditingController _valueController = TextEditingController();
  late Category selectedCategory;

  late List<Category> categories = ObjectBox().getCategories();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextField(
            controller: _valueController,
          ),
          DropdownMenu<Category>(
            initialSelection: categories.first,
            onSelected: (Category? value) {
              // This is called when the user selects an item.
              setState(() {
                selectedCategory = value!;
              });
            },
            dropdownMenuEntries: categories
                .map(
                  (e) => DropdownMenuEntry(
                    value: e,
                    label: e.name,
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }
}
