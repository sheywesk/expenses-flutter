import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;
    if (title.isEmpty || value <= 0 || _selectedDate == null) return;

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double keyboardSize = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: 10,
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    onSubmitted: (_) => _submitForm(),
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Título'),
                  ),
                  TextField(
                    onSubmitted: (_) => _submitForm(),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    controller: _valueController,
                    decoration: InputDecoration(labelText: 'Valor R\$'),
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(!(_selectedDate == null)
                                ? DateFormat('dd/MM/y').format(_selectedDate)
                                : 'Nenhuma data selecionada')),
                        FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          onPressed: _showDatePicker,
                          child: Text(
                            'Selecionar Data',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: _submitForm,
                          textColor: Colors.white,
                          child: Text('Nova Transação')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
