import 'package:flutter/material.dart';

class FloatingTopbar extends StatefulWidget implements PreferredSizeWidget {
  const FloatingTopbar({super.key});

  @override
  State<FloatingTopbar> createState() => _FloatingTopbarState();

  @override
  Size get preferredSize => const Size.fromHeight(53 + 64);
}

class _FloatingTopbarState extends State<FloatingTopbar> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Card(
        child: Center(
            child: Text(
          "Floating topbar",
        )),
      ),
    );
    // return AppBar(
    //   title: const Text("Floating Topbar"),
    //   actions: [
    //     IconButton(
    //       icon: const Icon(Icons.search),
    //       onPressed: () {},
    //     ),
    //     IconButton(
    //       icon: const Icon(Icons.more_vert),
    //       onPressed: () {},
    //     ),
    //   ],
    // );
  }
}
