// ignore_for_file: must_be_immutable

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class CustomAnimator extends StatelessWidget {
  final Map<String, Tween> _tweenMap = {
    "rotate": Tween<double>(begin: 0, end: 120),
    "transform": Tween<Offset>(begin: Offset.zero, end: Offset(0, 1)),
  };
  final Widget child;

  CustomAnimator({
    required this.child,
  });

  final AnimatorKey _animatorKey = AnimatorKey();
  late AnimatorState _animatorState;

  AnimatorState get animatorState => _animatorState;

  @override
  Widget build(BuildContext context) {
    return Animator(
      animatorKey: _animatorKey,
      duration: Duration(seconds: 1),
      curve: Curves.easeOutBack,
      cycles: 1,
      tweenMap: _tweenMap,
      child: child,
      builder: (_, animatorState, child) {
        _animatorState = animatorState;
        // return _rotateAnimation(child!);
        return _transformAnimation(child!);
      },
    );
  }

  _rotateAnimation(Widget child) {
    print("asd");
    return RotationTransition(
      turns: AlwaysStoppedAnimation(
        _animatorState.getValue<double>("rotate") / 360,
      ),
      child: InkWell(
        child: child,
        onTap: () => this._animatorState.triggerAnimation(),
      ),
    );
  }

  _transformAnimation(Widget child) {
    return SlideTransition(
      position: AlwaysStoppedAnimation(
        _animatorState.getValue<Offset>("transform"),
      ),
      child: InkWell(
        child: child,
        onTap: () => this._animatorState.triggerAnimation(),
      ),
    );
  }
}
