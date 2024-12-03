import 'package:flutter/material.dart';

class DialogUtils {
  static void showInfoDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Info'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showConfirmationDialog(
      BuildContext context,
      String message,
      VoidCallback onConfirm,
      ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmation'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onConfirm();
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
