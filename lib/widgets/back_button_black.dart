import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlackIconButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color backgroundColor;

  const BlackIconButton({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34,
        width: 34,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const SquareButton({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlackIconButton(
      onTap: onTap,
      child: child,
    );
  }
}

class MyBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const MyBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlackIconButton(
      onTap: onTap,
      child: Icon(
        CupertinoIcons.chevron_back,
        color: Colors.white,
      ),
    );
  }
}
