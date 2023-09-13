import 'package:flutter/material.dart';

import '../classes/objectbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {
            setState(() {});
          },
          child: const Text("Refresh"),
        ),
        ListView(
          shrinkWrap: true,
          children: ObjectBox()
              .getExpensesForThisMonth()
              .map(
                (e) =>
                    Text("${e.value} + ${e.category.target!.name} + ${e.date}"),
              )
              .toList(),
        )
      ],
    );
  }
}
