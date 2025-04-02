import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BrddgeTransitionPage<T> extends CustomTransitionPage<T> {
  BrddgeTransitionPage({
    required super.child,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
