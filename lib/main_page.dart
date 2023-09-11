import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:expense_tracker/pages/history_page.dart';
import 'package:expense_tracker/pages/home_page.dart';
import 'package:expense_tracker/pages/new_expense.dart';
import 'package:expense_tracker/pages/settings_page.dart';
import 'package:expense_tracker/pages/categories_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _bottomBarController = BottomBarWithSheetController(initialIndex: 0);

  List<Widget> pages = [
    const HomePage(),
    const HistoryPage(),
    const CategoriesPage(),
    const SettingsPage(),
  ];

  int currentIndex = 0;

  void changePage(int newPage) {
    setState(() {
      currentIndex = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomBarWithSheet(
          controller: _bottomBarController,
          mainActionButtonTheme: MainActionButtonTheme(
            color: Theme.of(context).primaryColor,
          ),
          bottomBarTheme: BottomBarTheme(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            itemIconColor: Colors.grey,
            itemTextStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 10.0,
            ),
            selectedItemTextStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 10.0,
            ),
            selectedItemIconColor: Theme.of(context).primaryColor,
          ),
          onSelectItem: (index) => changePage(index),
          items: const [
            BottomBarWithSheetItem(
              icon: Icons.home,
              label: "Home page",
            ),
            BottomBarWithSheetItem(
              icon: Icons.history,
              label: "History",
            ),
            BottomBarWithSheetItem(
              icon: Icons.category,
              label: "Categories",
            ),
            BottomBarWithSheetItem(
              icon: Icons.settings,
              label: "Settings",
            ),
          ],
          sheetChild: const NewExpensePage(),
        ),
        body: pages[currentIndex],
      ),
    );
  }
}
