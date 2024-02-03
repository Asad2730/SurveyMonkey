import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/constants.dart';
import 'package:survey_monkey/screens/TeacherEvaluation/teacherGraph.dart';
import 'package:survey_monkey/screens/participateMcqs.dart';

import '../../Helper/User.dart';
import '../../http/db.dart';
import '../../widgets/appbars.dart';
import '../../widgets/spacers.dart';

class ParticipateEV extends StatefulWidget {
  const ParticipateEV({super.key});

  @override
  State<ParticipateEV> createState() => _ParticipateEVState();
}

class _ParticipateEVState extends State<ParticipateEV> {
  late Future _future;

  @override
  void initState() {
    super.initState();
    _future = Db().teachersSurveyList();
  }

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
              "",
              style: TextStyle(fontSize: 20, color: ck.x),
            ),
            gap20(),
            Expanded(
              child: _futureBuild(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _futureBuild() {
    return FutureBuilder(
        future: _future,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return _list(snapshot);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _list(AsyncSnapshot snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: snapshot.data.length,
        itemBuilder: (context, i) {
          Map data = snapshot.data[i];
          return Column(
            children: [
              Row(
                children: [
                  Text("${data['name']}"),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      User.tempSurveyId = data['id'];
                      Get.to(() => const ParticipateMCQs());
                    },
                    child: const Text("Attempt"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      User.tempSurveyId = data['id'];
                      Get.to(() => const PieChartT());
                    },
                    child: const Text("See Results"),
                  )
                ],
              ),
              gap20(),
            ],
          );
        });
  }
}