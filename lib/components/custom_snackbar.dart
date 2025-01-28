import 'package:flutter/material.dart';

class CustomSnackbar {
  //関連するコンテンツを全て別に記載
  static void show(
    BuildContext context,
    String message, {
    IconData? icon,
    Color backgroundColor = Colors.redAccent,
    Color textColor = Colors.white,
    int durationSeconds = 3,
    String? actionLabel,
    VoidCallback? onAction,
    bool dismissible = true,
  }) {
    final snackBar = SnackBar(
      behavior:
          dismissible ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      content: Row(
        children: [
          if (icon != null) Icon(icon, color: textColor, size: 24),
          if (icon != null) const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: durationSeconds),
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              onPressed: onAction ?? () {},
              textColor: textColor,
            )
          : null,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
