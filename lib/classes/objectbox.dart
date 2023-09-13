import 'package:expense_tracker/entities/category.dart';
import 'package:expense_tracker/entities/expense.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// created by `flutter pub run build_runner build`
import '../objectbox.g.dart';

class ObjectBox {
  static late ObjectBox _instance;
  late final Store _store;

  late final Box<Expense> _expense;
  late final Box<Category> _category;

  ObjectBox._create(this._store) {
    _expense = Box<Expense>(_store);
    _category = Box<Category>(_store);

    if (_category.isEmpty()) {
      addCategory("Default", Colors.indigo.toString());
    }
  }

  static Future<void> create() async {
    final store = await openStore(
      directory:
          p.join((await getApplicationDocumentsDirectory()).path, "obx-docs"),
    );

    _instance = ObjectBox._create(store);
  }

  factory ObjectBox() {
    return _instance;
  }

  int addExpense(DateTime date, double value, Category category) =>
      _expense.put(
        Expense(
          date: date,
          value: value,
          category: category,
        ),
      );

  int addCategory(String name, String color) => _category.put(
        Category(
          name: name,
          color: color,
        ),
      );

  void removeExpense(int id) => _expense.remove(id);

  void removeCategory(int id) => _category.remove(id);

  List<Expense> getExpensesForThisMonth() {
    final builder = _expense.query().build();

    List<Expense> expenses = builder.find();
    builder.close();

    return expenses;
  }

  List<Category> getCategories() {
    final builder = _category.query().build();

    List<Category> categories = builder.find();
    builder.close();

    return categories;
  }
}
