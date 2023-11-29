import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/constants.dart';
import 'package:survey_monkey/screens/participateMcqs.dart';
import 'package:survey_monkey/screens/participateYesNo.dart';

import '../widgets/appbars.dart';
import '../widgets/spacers.dart';

class Participate extends StatefulWidget {
  const Participate({super.key});

  @override
  State<Participate> createState() => _ParticipateState();
}

class _ParticipateState extends State<Participate> {
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
              "Participate",
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
                            ElevatedButton(
                              onPressed: () {
                                Get.to(const ParticipateYesNo());
                              },
                              child: const Text("Attempt"),
                            )
                          ],
                        ),
                        gap20(),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
