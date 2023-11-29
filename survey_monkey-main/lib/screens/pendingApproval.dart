import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/constants.dart';

import '../widgets/appbars.dart';
import '../widgets/spacers.dart';

class PendingApproval extends StatefulWidget {
  const PendingApproval({super.key});

  @override
  State<PendingApproval> createState() => _PendingApprovalState();
}

class _PendingApprovalState extends State<PendingApproval> {
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
              "Pending Approval",
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
                                  onPressed: () {},
                                  color: ck.x,
                                  icon: const Icon(Icons.check),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  color: Colors.red,
                                  icon: const Icon(Icons.close),
                                ),
                              ],
                            ),
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
