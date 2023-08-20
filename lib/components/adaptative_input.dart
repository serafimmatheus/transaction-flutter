import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeInput extends StatelessWidget {
  final String label;
  final Function() onSubmit;
  final TextInputType typeKeyBoard;
  final TextEditingController controllerInput;

  const AdaptativeInput({
    super.key,
    required this.label,
    required this.onSubmit,
    required this.typeKeyBoard,
    required this.controllerInput,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              controller: controllerInput,
              onSubmitted: (_) => onSubmit(),
              keyboardType: typeKeyBoard,
              placeholder: label,
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          )
        : TextField(
            controller: controllerInput,
            onSubmitted: (_) => onSubmit(),
            keyboardType: typeKeyBoard,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
