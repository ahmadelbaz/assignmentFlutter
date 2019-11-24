import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/widgets/chart.dart';
import 'package:flutter_assignment/widgets/new_transfers.dart';
import 'models/transfers.dart';
import 'widgets/transfers_list.dart';

class App extends StatefulWidget {
  int g = 5;
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool isChart = false;
  final List<Transfers> transfersList = [];

  void _addNewTransfer(String trName, double trCost, DateTime chosenDay) {
    var newTr = Transfers(3, 'Arsenal', trName, trCost, 8.20, chosenDay);

    setState(() {
      transfersList.add(newTr);
    });
  }

  void _startAddingTransfer(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransfers(
              _addNewTransfer,
            ),
          );
        });
  }

  List<Transfers> get _recentTransfers {
    return transfersList.where((ts) {
      return ts.dateTime.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteItem(int index) {
    setState(() {
      transfersList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isRotated = mediaQuery.orientation == Orientation.landscape;

    final PreferredSize appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Flutter Assignment'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                    child: Icon(CupertinoIcons.add),
                    onTap: () => _startAddingTransfer(context)),
              ],
            ),
          )
        : AppBar(
            title: Text('Flutter Assignment'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddingTransfer(context),
              ),
            ],
          );
    var trList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          .6,
      child: TransfersList(
        transfersList,
        _deleteItem,
      ),
    );

    final pageBody = SafeArea(
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isRotated)
                Row(
                  children: <Widget>[
                    Text('Change View : '),
                    Switch.adaptive(
                      value: isChart,
                      onChanged: (val) {
                        setState(() {
                          isChart = val;
                        });
                      },
                    )
                  ],
                ),
              if (isRotated)
                isChart
                    ? Container(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            .7,
                        child: Chart(
                          _recentTransfers,
                        ),
                      )
                    : trList,
              if (!isRotated)
                Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      .3,
                  child: Chart(
                    _recentTransfers,
                  ),
                ),
              if (!isRotated) trList,
            ],
          ),
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation: Platform.isIOS
                ? Container()
                : FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddingTransfer(context),
            ),
          );
  }
}
