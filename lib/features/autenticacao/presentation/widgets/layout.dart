import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget child;

  const Layout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
     final altura = MediaQuery.of(context).size.height;
    return Expanded(
      flex: 1,
      child: Container(
        height: altura,
        decoration: const BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(40),
          //   bottomLeft: Radius.circular(40),
          // ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: child,
      ),
    );
  }
}
