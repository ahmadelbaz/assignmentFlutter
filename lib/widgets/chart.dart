import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/transfers.dart';
import 'package:flutter_assignment/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transfers> currentList;

  Chart(this.currentList);

  List<Map<String, Object>> get groupTransersValues {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));

      var totalCost = 0.0;

      for (int n = 0; n < currentList.length; n++) {
        if (currentList[n].dateTime.day == weekDay.day &&
            currentList[n].dateTime.month == weekDay.month &&
            currentList[n].dateTime.year == weekDay.year) {
          totalCost += currentList[n].cost;          
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'cost': totalCost
      };
    }).reversed.toList();
  }

  double get _totalSpending {
    return groupTransersValues.fold(0.0, (sum, item) {
      return sum + item['cost'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupTransersValues.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              data['day'],
              data['cost'],
              _totalSpending == 0
                  ? 0.0
                  : (data['cost'] as double) / _totalSpending,
            ),
          );
        }).toList(),
      ),
      elevation: 6,
      margin: EdgeInsets.all(20),
    );
  }
}
