import 'package:despesas_pessoais/components/adaptative_button.dart';
import 'package:despesas_pessoais/components/adaptative_date_picker.dart';
import 'package:despesas_pessoais/components/adaptative_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate as DateTime);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10 + mediaQuery.viewInsets.bottom),
          child: Column(
            children: [
              AdaptativeInput(
                controllerInput: titleController,
                onSubmit: _submitForm,
                label: 'Título',
                typeKeyBoard: TextInputType.text,
              ),
              AdaptativeInput(
                label: "Valor (R\$)",
                controllerInput: valueController,
                onSubmit: _submitForm,
                typeKeyBoard: TextInputType.numberWithOptions(decimal: true),
              ),
              AdaptativeDatePicker(
                  label: "Selecionar data",
                  selectedDate: _selectedDate,
                  onDateChange: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 1),
                    color: Colors.purple,
                    child: AdaptativeButton(
                        label: "Nova Transação", onPressed: _submitForm),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
