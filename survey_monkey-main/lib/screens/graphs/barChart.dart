import 'package:flutter/material.dart';
import 'package:survey_monkey/widgets/appbars.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatefulWidget {
  const BarChart({super.key});

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(),
      body: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(title: AxisTitle(text: 'Students')),
        series: <BarSeries<SalesData, String>>[
          BarSeries<SalesData, String>(
            dataSource: <SalesData>[
              SalesData('Poor', 50),
              SalesData('Average', 25),
              SalesData('Good', 40),
              SalesData('Excellent', 30),
            ],
            xValueMapper: (SalesData sales, _) => sales.month,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

class SalesData {
  final String month;
  final int sales;

  SalesData(this.month, this.sales);
}