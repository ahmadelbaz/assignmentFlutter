import 'package:flutter/material.dart';
import 'package:flutter_assignment/widgets/transfer_item.dart';
import '../models/transfers.dart';

class TransfersList extends StatelessWidget {
  final List<Transfers> transfers;
  final Function deleteItem;

  TransfersList(this.transfers, this.deleteItem);

  @override
  Widget build(BuildContext context) {
    return transfers.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constrains) {
              return Column(
                children: <Widget>[
                  Text(
                    'No Transfers Added',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: constrains.maxHeight * 0.6,
                    child: Image.asset(
                      'images/empty.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView(
            children: transfers.map((trn) {
            return TransferItem(
              key: ValueKey(trn.id),
              tranfer: trn,
              deleteItem: deleteItem,
              id: trn.id,
            );
          }).toList());
  }
}
