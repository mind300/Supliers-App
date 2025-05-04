import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushWithAnimation(Widget screen, {Object? arguments}) {
    return Navigator.of(this).push(SlideRightTransition(page: screen));
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveAll(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName, {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this).pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  /// ModalRoute.withName('/routeName') <<  this is predicate
  void popAndRemoveUntil({required RoutePredicate predicate}) {
    return Navigator.of(this).popUntil(
      predicate,
    );
  }

  void popUntil({required RoutePredicate predicate}) {
    return Navigator.of(this).popUntil(
      predicate,
    );
  }

  //remove all routes
  void popUntilAll() {
    return Navigator.of(this).popUntil(
      (route) => route.isFirst,
    );
  }

  void pop() => Navigator.of(this).pop();
}

class SlideRightTransition extends PageRouteBuilder {
  final Widget page;
  //final Object? arguments;

  SlideRightTransition({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(
                  CurveTween(curve: Curves.ease),
                ),
              ),
              child: child,
            );
          },
        );
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
  bool isValidEmail() {
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return regex.hasMatch(this!);
  }

  bool isValidPassword() {
    final RegExp regex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
    );
    return regex.hasMatch(this!);
  }
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension numberExtension on num {
  bool get isInteger => (this % 1) == 0;
  bool get isDecimal => (this % 1) != 0;
}
