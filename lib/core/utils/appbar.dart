import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black, // background color
      centerTitle: true,
    );
  }
  // Define height of AppBar
  @override
  Size get preferredSize => const Size.fromHeight(60.0); // height = 60
}
