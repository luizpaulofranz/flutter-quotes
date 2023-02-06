import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  CustomAppBar({super.key})
      : super(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            centerTitle: true,
            leading: const Icon(Icons.quora_outlined),
            title: const TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        );
}
