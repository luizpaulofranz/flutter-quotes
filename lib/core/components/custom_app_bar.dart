import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  CustomAppBar({
    super.key,
    String? title,
  }) : super(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            centerTitle: true,
            title: Text(title ?? "Quotes App"),
          ),
        );
}
