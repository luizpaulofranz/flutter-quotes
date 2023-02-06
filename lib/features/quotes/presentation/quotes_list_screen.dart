import 'package:flutter/material.dart';
import 'package:quotes/core/components/custom_app_bar.dart';

class QuotesListScreen extends StatelessWidget {
  const QuotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Container(color: Colors.red),
      ),
    );
  }
}
