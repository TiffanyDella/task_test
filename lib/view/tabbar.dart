import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget implements PreferredSizeWidget {
  final TabController controller;
  
  const CustomTabBar({super.key, required this.controller});

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 43, 62, 88),
        borderRadius: BorderRadius.circular(25.0), 
      ),
      margin: EdgeInsets.all(10.0),
      child: TabBar(
        controller: widget.controller,
        tabs: const [
          Tab(text: 'Все'),
          Tab(text: 'Мои'),
          Tab(text: 'Избранное'),
        ],
        labelColor: Colors.white,
        unselectedLabelColor: const Color.fromARGB(255, 255, 255, 255),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: const Color.fromARGB(255, 29, 88, 229),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        padding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        dividerColor: Colors.transparent,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
      ),
    );
  }
}