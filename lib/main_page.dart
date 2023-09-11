import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:expense_tracker/pages/history_page.dart';
import 'package:expense_tracker/pages/landing_page.dart';
import 'package:expense_tracker/pages/new_expense.dart';
import 'package:expense_tracker/pages/settings_page.dart';
import 'package:expense_tracker/pages/this_month_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  final _bottomBarController = BottomBarWithSheetController(initialIndex: 0);

  List<Widget> pages = [
    const LandingPage(),
    const ThisMonthPage(),
    const HistoryPage(),
    const SettingsPage(),
  ];

  int currentIndex = 0;

  @override
  void initState() {
    _bottomBarController.stream.listen((opened) {
      debugPrint('Bottom bar ${opened ? 'opened' : 'closed'}');
    });
    super.initState();
  }

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
              icon: Icons.calendar_month,
              label: "This month",
            ),
            BottomBarWithSheetItem(
              icon: Icons.history,
              label: "History",
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
