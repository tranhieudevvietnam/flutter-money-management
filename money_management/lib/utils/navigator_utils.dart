import 'package:flutter/material.dart';

class NavigatorUtil {
  static push({
    required String routeName,
    required BuildContext context,
    dynamic arguments,
  }) {
    return Navigator.of(context).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  static pop({
    required BuildContext context,
    dynamic result,
  }) {
    return Navigator.pop(context, result);
  }

  static pushNamedAndRemoveUntil({
    required String routeName,
    required BuildContext context,
    bool Function(Route<dynamic>)? predicate,
    dynamic arguments,
  }) {
    if (predicate != null) {
      return Navigator.of(context).pushNamedAndRemoveUntil(
        routeName,
        predicate,
        arguments: arguments,
      );
    } else {
      return Navigator.of(context).pushNamedAndRemoveUntil(
        routeName,
        (route) => false,
        arguments: arguments,
      );
    }
  }

  static popUntil({
    required String routeName,
    required BuildContext context,
  }) {
    return Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  static popAndPush({
    required String routeName,
    required BuildContext context,
    dynamic arguments,
    dynamic result,
  }) {
    return Navigator.of(context)
        .popAndPushNamed(routeName, arguments: arguments, result: result);
  }
}
