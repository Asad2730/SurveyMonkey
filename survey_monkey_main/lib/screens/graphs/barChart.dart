import 'package:flutter/material.dart';
import 'package:survey_monkey/widgets/appbars.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Helper/Graph.dart';
import '../../http/db.dart';

class BarChart extends StatefulWidget {
  final int id;
  final Map data;
  const BarChart({super.key, required this.id, required this.data});

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Db().calculateGraph(sid: widget.id);
    setState(() {
      _dataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _dataLoaded ? _list() : const CircularProgressIndicator(),
      ),
    );
  }

  Widget _list() {
    return ListView.builder(
      itemCount: widget.data['responses'].length,
      itemBuilder: (context, i) {
        return SfCartesianChart(
          primaryXAxis: const CategoryAxis(),
          title: ChartTitle(
            text: widget.data['responses'][i]['title'],
          ),
          series: <ColumnSeries<SalesData, String>>[
            ColumnSeries<SalesData, String>(
              dataSource: <SalesData>[
                SalesData(widget.data['responses'][i]['op1'], Graph.v1),
                SalesData(widget.data['responses'][i]['op2'], Graph.v2),
                SalesData(
                  widget.data['responses'][i]['op3'] ?? '',
                  Graph.v3,
                ),
                SalesData(
                  widget.data['responses'][i]['op4'] ?? '',
                  Graph.v4,
                ),
              ],
              xValueMapper: (SalesData sales, _) => sales.question,
              yValueMapper: (SalesData sales, _) => sales.ans,
            ),
          ],
        );
      },
    );
  }
}

class SalesData {
  SalesData(this.question, this.ans);
  final String question;
  final double ans;
}
