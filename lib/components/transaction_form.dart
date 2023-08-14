// import 'package:flutter/material.dart';

// class TransactionForm extends StatefulWidget {
//   final void Function(String, double) addTransaction;

//   const TransactionForm(this.addTransaction, {Key? key}) : super(key: key);

//   @override
//   State<TransactionForm> createState() => _TransactionFormState();
// }

// class _TransactionFormState extends State<TransactionForm> {
//   final titleController = TextEditingController();
//   final valueController = TextEditingController();

//   _onSubmitForm() {
//     final title = titleController.text;
//     final value = double.tryParse(valueController.text) ?? 0;

//     if (title.isEmpty || value <= 0) {
//       return;
//     }

//     widget.addTransaction(title, value);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           children: [
//             TextField(
//               controller: titleController,
//               onSubmitted: (_) => _onSubmitForm(),
//               decoration: InputDecoration(
//                 labelText: "Título",
//               ),
//             ),
//             TextField(
//               controller: valueController,
//               onSubmitted: (_) => _onSubmitForm(),
//               decoration: InputDecoration(labelText: "Valor (R\$)"),
//               keyboardType: TextInputType.numberWithOptions(decimal: true),
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ElevatedButton(
//                   onPressed: _onSubmitForm,
//                   child: Text('Nova transação'),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

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

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedDate != null
                      ? "Data selecionada: ${DateFormat("dd MMMM y").format((_selectedDate as DateTime))}"
                      : "Nenhuma data selecionada"),
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: Text("Selecionar data"),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 1),
                  color: Colors.purple,
                  child: TextButton(
                    child: const Text(
                      'Nova Transação',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: _submitForm,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
