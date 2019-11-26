import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/widgets/chart.dart';
import 'package:flutter_assignment/widgets/new_transfers.dart';
import 'models/transfers.dart';
import 'widgets/transfer_list.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool isChart = false;
  final List<Transfers> transfersList = [];

  void _addNewTransfer(String trName, double trCost, DateTime chosenDay) {
    var newTr = Transfers(DateTime.now().toString(), 'Arsenal', trName, trCost, 8.20, chosenDay);

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

  void _deleteItem(String idd) {
    setState(() {
      transfersList.removeWhere((tr) => tr.id == idd);
    });
  }

  List<Widget> _buildLandscapeContent(
    Widget trList,
    MediaQueryData mediaQuery,
    AppBar appBar,
  ) {
    return [
      Row(
        children: <Widget>[
          const Text('Change View : '),
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
          : trList
    ];
  }

  List<Widget> _buildPortraitContent(
    Widget trList,
    MediaQueryData mediaQuery,
    AppBar appBar,
  ) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            .4,
        child: Chart(
          _recentTransfers,
        ),
      ),
      trList,
    ];
  }

  Widget _buildAppBar(){
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Flutter Assignment'),
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
            title: const Text('Flutter Assignment'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _startAddingTransfer(context),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isRotated = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = _buildAppBar();
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
                ..._buildLandscapeContent(trList, mediaQuery, appBar),
              if (!isRotated)
                ..._buildPortraitContent(trList, mediaQuery, appBar),
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
              child: const Icon(Icons.add),
              onPressed: () => _startAddingTransfer(context),
            ),
          );
  }
}
