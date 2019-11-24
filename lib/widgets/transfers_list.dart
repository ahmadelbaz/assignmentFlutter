import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transfers.dart';

class TransfersList extends StatelessWidget {
  final List<Transfers> tranfers;
  final Function deleteItem;

  TransfersList(this.tranfers, this.deleteItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: FittedBox(
                  child: Text(
                    '\$${tranfers[index].cost.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              title: Text(
                tranfers[index].playerName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(tranfers[index].dateTime),
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
                  deleteItem(index);
                },
              ),
            ),
          );
        },
        itemCount: tranfers.length,
      ),
    );
  }
}
