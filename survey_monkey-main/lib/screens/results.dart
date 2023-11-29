import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/constants.dart';
import 'package:survey_monkey/screens/graphs/barChart.dart';
import 'package:survey_monkey/screens/graphs/pieChart.dart';

import '../widgets/appbars.dart';
import '../widgets/spacers.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Results",
              style: TextStyle(fontSize: 20, color: ck.x),
            ),
            gap20(),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Survey ${index + 1}"),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.to(const BarChart());
                                },
                                color: ck.x,
                                icon: const Icon(Icons.bar_chart),
                              ),
                              IconButton(
                                onPressed: () {
                                  Get.to(const PieChart());
                                },
                                color: ck.x,
                                icon: const Icon(Icons.pie_chart),
                              ),
                            ],
                          )
                        ],
                      ),
                      gap20(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
