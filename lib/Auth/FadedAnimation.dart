import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'dart:math';

class FadeAnimationSimple extends StatefulWidget {
  final double delay;
  final Widget child;

  const FadeAnimationSimple(this.delay, this.child, {Key? key}) : super(key: key);

  @override
  State<FadeAnimationSimple> createState() => _FadeAnimationSimpleState();
}

class _FadeAnimationSimpleState extends State<FadeAnimationSimple> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(milliseconds: (500 * widget.delay).round()),
          () {
        if (mounted) {
          setState(() {
            _isVisible = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _isVisible ? 0 : -130, 0),
        child: widget.child,
      ),
    );
  }
}