import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String currentDay;
  final double costAmount;
  final double totalAmountPercentage;

  ChartBar(this.currentDay, this.costAmount, this.totalAmountPercentage);

  @override
  Widget build(BuildContext context) {
    print('build() ChartBar.dart');
    return Column(
      children: <Widget>[
        FittedBox(child: Text(costAmount.toStringAsFixed(0))),
        SizedBox(height: 4),
        Container(
          width: 30,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: Theme.of(context).accentColor,
            ),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.bottomCenter,
                heightFactor: totalAmountPercentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
        ),
        SizedBox(height: 4),
        Text(currentDay),
      ],
    );
  }
}
