/*
Kullanilan Kutuphaneler
animator:

Kullanilacak Sayfada Tanimlama
  final FAB fab = FAB();
  return Scaffold(
    appBar: AppBar(),
    body: Body(),
    floatingActionButton: fab,
  );
*/

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  final AnimatorKey _animatorKey = AnimatorKey();
  final Duration _duration = Duration(seconds: 1);
  final Curve _curve = Curves.easeOutBack;
  final int _cycle = 1;
  final Map<String, Tween> _tweenMap = {
    "option2": Tween<Offset>(begin: Offset.zero, end: Offset(0, -2.2)),
    "option1": Tween<Offset>(begin: Offset.zero, end: Offset(0, -1.1)),
    "add": Tween<double>(begin: 0, end: 135),
  };

  late AnimatorState? _animatorState;
  AnimatorState? get animatorState => _animatorState;

  @override
  Widget build(BuildContext context) {
    return Animator(
        animatorKey: _animatorKey,
        duration: _duration,
        curve: _curve,
        cycles: _cycle,
        tweenMap: _tweenMap,
        tween: _tweenMap["add"],
        builder: (context, animatorState, child) {
          _animatorState = animatorState;
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
              print("Option2");
            },
          ),
          _buildButton(
            context: context,
            animatorState: animatorState,
            tag: "option1",
            icon: Icons.add,
            onPressFunction: () {
              print("Option1");
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(
                animatorState.getAnimation<double>("add").value / 360,
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
      heroTag: "add",
      elevation: 4,
      child: RotationTransition(
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
                  style: TextStyle(fontSize: 16),
                )
              : SizedBox(),
          SizedBox(width: 8),
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
