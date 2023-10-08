import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;
  final double height;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.actions,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      primary: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      toolbarHeight: height,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      title: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          title,
        ],
      ),
      actions: actions,
      elevation: 10,
    );
  }
}
