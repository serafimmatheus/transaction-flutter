import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  const AdaptativeButton(
      {super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(child: Text(label), onPressed: onPressed)
        : TextButton(
            onPressed: onPressed,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),
            ));
  }
}
