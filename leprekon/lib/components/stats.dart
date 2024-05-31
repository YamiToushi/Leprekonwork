import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:leprekon/provider/hive_provider.dart';
import 'package:provider/provider.dart';

class DoughnutChart extends StatelessWidget {
  const DoughnutChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveProvider>(
      builder: (context, hiveProvider, child) {
        double totalIncome = hiveProvider.totalIncome;
        double totalOutcome = hiveProvider.totalOutcome;

        List<ChartData> chartData = [
          ChartData('Income', totalIncome, Colors.green),
          ChartData('Outcome', totalOutcome, Colors.red),
        ];

        return Column(
          children: [
            SizedBox(
              height: 250,
              child: SfCircularChart(
                series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    pointColorMapper: (ChartData data, _) => data.color,
                    innerRadius: '60%',
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
