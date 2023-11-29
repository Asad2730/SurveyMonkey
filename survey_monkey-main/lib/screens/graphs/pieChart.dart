import 'package:flutter/material.dart';
import 'package:survey_monkey/widgets/appbars.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  const PieChart({super.key});

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  final List<_PieData> pieData = [
    _PieData('Excellent', 30, 'Excellent: 30%'),
    _PieData('Good', 20, 'Good: 20%'),
    _PieData('Avg', 25, 'Avg: 25%'),
    _PieData('Poor', 25, 'Poor: 25%'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(),
      body: Center(
          child:SfCircularChart(
              title: ChartTitle(text: 'Responses from Students'),
              legend: Legend(isVisible: true),
              series: <PieSeries<_PieData, String>>[
                PieSeries<_PieData, String>(
                    explode: true,
                    explodeIndex: 0,
                    dataSource: pieData,
                    xValueMapper: (_PieData data, _) => data.xData,
                    yValueMapper: (_PieData data, _) => data.yData,
                    dataLabelMapper: (_PieData data, _) => data.text,
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
              ]
          )
      ),
    );
  }
}
class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  final String? text;
}