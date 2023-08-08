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

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0;

    print(title);
    print(value);

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value);
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text(
                    'Nova Transação',
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                  onPressed: _submitForm,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
