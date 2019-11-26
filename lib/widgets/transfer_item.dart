import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/transfers.dart';
import 'package:intl/intl.dart';

class TransferItem extends StatefulWidget {
  const TransferItem({
    Key key,
    @required this.tranfer,
    @required this.deleteItem,
    @required this.id,
  }) : super(key: key);

  final Transfers tranfer;
  final Function deleteItem;
  final String id;

  @override
  _TransferItemState createState() => _TransferItemState();
}

class _TransferItemState extends State<TransferItem> {
  Color _bgColors;
  @override
  void initState() {
    const rColors = [
      Colors.blue,
      Colors.black,
      Colors.pink,
      Colors.amber,
      Colors.purple,
    ];
    _bgColors = rColors[Random().nextInt(5)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColors,
          child: FittedBox(
            child: Text(
              '\$${widget.tranfer.cost.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Text(
          widget.tranfer.playerName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.tranfer.dateTime),
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            widget.deleteItem(widget.id);
          },
        ),
      ),
    );
  }
}
