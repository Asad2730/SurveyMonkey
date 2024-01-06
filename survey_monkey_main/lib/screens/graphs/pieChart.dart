import 'package:flutter/material.dart';
import 'package:survey_monkey/Helper/Graph.dart';
import 'package:survey_monkey/http/db.dart';
import 'package:survey_monkey/widgets/appbars.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  final int id;
  final Map data;
  const PieChart({super.key, required this.id, required this.data});

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  late List<_PieData> pieData;
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Db().calculateGraph(sid: widget.id);

    String op3Value = widget.data['responses'][0]['op3'] ?? '';
    String op4Value = widget.data['responses'][0]['op4'] ?? '';

    pieData = [
      _PieData(widget.data['responses'][0]['op1'].toString(), Graph.v1, ''),
      _PieData(widget.data['responses'][0]['op2'].toString(), Graph.v2, ''),
      _PieData(op3Value, Graph.v3, ''),
      _PieData(op4Value, Graph.v4, ''),
    ];

    setState(() {
      _dataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(),
      body: _dataLoaded
          ? Center(
              child: SfCircularChart(
                title: ChartTitle(text: 'Responses from Students'),
                legend: const Legend(isVisible: true),
                series: <PieSeries<_PieData, String>>[
                  PieSeries<_PieData, String>(
                    explode: true,
                    explodeIndex: 0,
                    dataSource: pieData,
                    xValueMapper: (_PieData dt, _) => dt.xData,
                    yValueMapper: (_PieData dt, _) => dt.yData,
                    dataLabelMapper: (_PieData dt, _) => dt.text,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  final String? text;
}
