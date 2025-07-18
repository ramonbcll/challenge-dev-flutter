import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final dateFormatter = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'[0-9]')},
);

final cpfFormatter = MaskTextInputFormatter(
  mask: '###.###.###-##',
  filter: {"#": RegExp(r'[0-9]')},
);

Future<void> showCustomDialog({
  required BuildContext context,
  required String title,
  required String description,
  required String primaryButtonText,
  VoidCallback? onPrimaryPressed,
  String? secondaryButtonText,
  VoidCallback? onSecondaryPressed,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          if (secondaryButtonText != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onSecondaryPressed != null) onSecondaryPressed();
              },
              child: Text(secondaryButtonText),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onPrimaryPressed != null) onPrimaryPressed();
            },
            child: Text(primaryButtonText),
          ),
        ],
      );
    },
  );
}