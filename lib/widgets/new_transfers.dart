import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransfers extends StatefulWidget {
  final Function newTr;

  NewTransfers(this.newTr);

  @override
  _NewTransfersState createState() => _NewTransfersState();
}

class _NewTransfersState extends State<NewTransfers> {
  final nameController = TextEditingController();
  final costController = TextEditingController();
  DateTime chosenDate = DateTime.now();

  void submitData() {
    final String nController = nameController.text;
    final double cController = double.parse(costController.text);
    if (nController.isEmpty || cController <= 0) {
      return;
    }
    widget.newTr(
        nameController.text, double.parse(costController.text), chosenDate);

    Navigator.of(context).pop();
  }

  void _addingDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract((Duration(days: 7))),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if (datePicked == null) {
        return;
      }
      setState(() {
        chosenDate = datePicked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Player Name'),
                controller: nameController,
                onSubmitted: (_) => submitData,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Cost'),
                controller: costController,
                onSubmitted: (_) => submitData,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(chosenDate == null
                        ? 'No Date Chosen'
                        : 'Picked Date : ${DateFormat.yMd().format(chosenDate)}'),
                    FlatButton(
                      child: Text(
                        'Choose Day',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: _addingDatePicker,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                elevation: 5,
                child: Text(
                  'Add Transfer',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: submitData,
                color: Theme.of(context).accentColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
