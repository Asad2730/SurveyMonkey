import 'package:flutter/material.dart';
import 'package:survey_monkey/widgets/appbars.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Helper/Graph.dart';
import '../../http/db.dart';

class BarChart extends StatefulWidget {
  final int id;
  final Map data;
  const BarChart({super.key, required this.id,required this.data});

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {


  late List<SalesData> dt;
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Db().calculateGraph(sid: widget.id);

    String op3Value = widget.data['responses'][0]['op3'] ?? '0';
    String op4Value = widget.data['responses'][0]['op4'] ?? '0';

     dt = [
       SalesData(widget.data['responses'][0]['op1'].toString(), Graph.v1.truncate() ),
       SalesData(widget.data['responses'][0]['op2'].toString(), Graph.v2.truncate()),
       SalesData(op3Value, Graph.v3.truncate()),
       SalesData(op4Value, Graph.v4.truncate()),
    ];

    setState(() {
      _dataLoaded = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(),
      body:_dataLoaded? SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(title: AxisTitle(text: 'Students')),
        series: <BarSeries<SalesData, String>>[
          BarSeries<SalesData, String>(
            dataSource: dt,
            xValueMapper: (SalesData sales, _) => sales.month,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ) : const Center(child: CircularProgressIndicator()),
    );
  }
}

class SalesData {
  final String month;
  final int sales;

  SalesData(this.month, this.sales);
}