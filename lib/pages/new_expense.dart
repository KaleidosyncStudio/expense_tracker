import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:expense_tracker/classes/objectbox.dart';
import 'package:expense_tracker/entities/category.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpensePage extends StatefulWidget {
  NewExpensePage({super.key, required this.bottomBarController});

  BottomBarWithSheetController bottomBarController;

  @override
  State<NewExpensePage> createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  final TextEditingController _valueController = TextEditingController();
  late Category selectedCategory;

  late List<Category> categories = ObjectBox().getCategories();

  DateTime date = DateTime.now();
  DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              "Date of expense: ",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            OutlinedButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                setState(() {
                  date = pickedDate ?? DateTime.now();
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dateFormat.format(
                      date,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.edit_calendar,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              "Select category: ",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              width: 10,
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
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: _valueController,
            decoration: const InputDecoration(
              hintText: "Enter value spend (- for income)",
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            if (ObjectBox().addExpense(
                  date,
                  double.parse(_valueController.text),
                  selectedCategory,
                ) !=
                0) {
              widget.bottomBarController.closeSheet();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Failed adding the expense!"),
              ));
            }
          },
          child: const Text(
            "Add Expense",
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }
}
