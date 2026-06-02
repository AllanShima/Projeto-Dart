import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget child;
  final bool isMobile;

  const Layout({super.key, required this.child, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: child,
      );
    } else {
      return Expanded(
        flex: 2,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: child,
        ),
      );
    }
  }
}
