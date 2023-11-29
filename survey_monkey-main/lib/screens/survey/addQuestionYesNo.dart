import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/screens/userHome.dart';

import '../../widgets/appbars.dart';
import '../../widgets/spacers.dart';

class AddQuestionYesNo extends StatefulWidget {
  const AddQuestionYesNo({super.key});

  @override
  State<AddQuestionYesNo> createState() => _AddQuestionYesNoState();
}

class _AddQuestionYesNoState extends State<AddQuestionYesNo> {

  TextEditingController q = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              gap20(),
              const Text(
                "Add New Question",
                style: TextStyle(fontSize: 26),
              ),
              gap20(),
              TextField(
                controller: q,
                decoration: const InputDecoration(hintText: "Question",border: OutlineInputBorder()),
                minLines: 4,
                maxLines: 5,
              ),
              gap20(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {

                    },
                    child: const Text("Add More"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAll(()=>const UserHome());
                    },
                    child: const Text("Done"),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
