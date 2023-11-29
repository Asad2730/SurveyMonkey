import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/screens/userHome.dart';

import '../../widgets/appbars.dart';
import '../../widgets/spacers.dart';

class AddQuestionMcqs extends StatefulWidget {
  const AddQuestionMcqs({super.key});

  @override
  State<AddQuestionMcqs> createState() => _AddQuestionMcqsState();
}

class _AddQuestionMcqsState extends State<AddQuestionMcqs> {

  TextEditingController q = TextEditingController();
  TextEditingController o1 = TextEditingController();
  TextEditingController o2 = TextEditingController();
  TextEditingController o3 = TextEditingController();
  TextEditingController o4 = TextEditingController();


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
              TextField(
                controller: o1,
                decoration: const InputDecoration(hintText: "Option 1",),
              ),
              gap20(),
              TextField(
                controller: o2,
                decoration: const InputDecoration(hintText: "Option 2"),
              ),
              gap20(),
              TextField(
                controller: o3,
                decoration: const InputDecoration(hintText: "Option 3"),
              ),
              gap20(),
              TextField(
                controller: o4,
                decoration: const InputDecoration(hintText: "Option 4"),
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
