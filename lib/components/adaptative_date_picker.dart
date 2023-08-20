import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateChange;
  final String label;

  const AdaptativeDatePicker({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onDateChange,
  });

  @override
  Widget build(BuildContext context) {
    _showDatePicker(BuildContext context) {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }

        onDateChange(pickedDate);
      });
    }

    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2023),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChange,
            ),
          )
        : Row(
            children: [
              Expanded(
                child: Text(selectedDate != null
                    ? "Data selecionada: ${DateFormat("dd MMMM y").format((selectedDate as DateTime))}"
                    : "Nenhuma data selecionada"),
              ),
              TextButton(
                onPressed: () => _showDatePicker(context),
                child: Text(label),
              )
            ],
          );
  }
}
