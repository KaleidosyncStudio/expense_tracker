import 'package:flutter/material.dart';

class ThisMonthPage extends StatefulWidget {
  const ThisMonthPage({super.key});

  @override
  State<ThisMonthPage> createState() => _ThisMonthPageState();
}

class _ThisMonthPageState extends State<ThisMonthPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "This month Page",
      ),
    );
  }
}
