// ignore_for_file: use_key_in_widget_constructors

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  final AnimatorKey _animatorKey = AnimatorKey();
  final Duration _duration = const Duration(seconds: 1);
  final Curve _curve = Curves.easeOutBack;
  final int _cycle = 1;
  final Map<String, Tween> _tweenMap = {
    "option2": Tween<Offset>(begin: Offset.zero, end: const Offset(0, -2.2)),
    "option1": Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1.1)),
    "main": Tween<double>(begin: 0, end: 135),
  };

  final AnimatorState? animatorState = null;

  @override
  Widget build(BuildContext context) {
    return Animator(
        animatorKey: _animatorKey,
        duration: _duration,
        curve: _curve,
        cycles: _cycle,
        tweenMap: _tweenMap,
        tween: _tweenMap["main"],
        builder: (context, animatorState, child) {
          animatorState = animatorState;
          return _buildFAB(context, animatorState);
        });
  }

  _buildFAB(BuildContext context, AnimatorState animatorState) {
    return Container(
      alignment: Alignment.bottomRight,
      height: 180,
      width: 200,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _buildButton(
            context: context,
            animatorState: animatorState,
            tag: "option2",
            icon: Icons.add,
            onPressFunction: () {
              debugPrint("Option2");
            },
          ),
          _buildButton(
            context: context,
            animatorState: animatorState,
            tag: "option1",
            icon: Icons.add,
            onPressFunction: () {
              debugPrint("Option1");
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(
                animatorState.getAnimation<double>("main").value / 360,
              ),
              child: _buildMainButton(animatorState),
            ),
          ),
        ],
      ),
    );
  }

  _buildMainButton(AnimatorState animatorState) {
    return FloatingActionButton(
      heroTag: "main",
      elevation: 4,
      child: const RotationTransition(
        turns: AlwaysStoppedAnimation(180 / 360),
        child: Icon(Icons.add, size: 40),
      ),
      onPressed: () => animatorState.triggerAnimation(),
    );
  }

  _buildButton({
    required BuildContext context,
    required AnimatorState animatorState,
    required String tag,
    required IconData icon,
    required Function() onPressFunction,
  }) {
    return SlideTransition(
      position: animatorState.getAnimation<Offset>(tag),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          animatorState.controller.status == AnimationStatus.completed
              ? Text(
                  tag,
                  style: const TextStyle(fontSize: 16),
                )
              : const SizedBox.shrink(),
          const SizedBox(width: 8),
          FloatingActionButton(
            elevation: 1,
            heroTag: tag,
            tooltip: tag,
            child: Icon(icon),
            onPressed: () => onPressFunction.call(),
          ),
        ],
      ),
    );
  }
}
