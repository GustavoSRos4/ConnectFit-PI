import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;
  final double height;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.actions,
    this.height = kToolbarHeight,
    this.automaticallyImplyLeading = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      toolbarHeight: height,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      title: Column(
        children: [
          title,
        ],
      ),
      actions: actions,
      elevation: 10,
    );
  }
}
