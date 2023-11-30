import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/constants.dart';
import 'package:survey_monkey/http/db.dart';
import 'package:survey_monkey/screens/survey/addQuestionMcqs.dart';
import 'package:survey_monkey/screens/survey/addQuestionYesNo.dart';
import 'package:survey_monkey/widgets/spacers.dart';
import 'package:survey_monkey/widgets/textfields.dart';

import '../../widgets/appbars.dart';

class AddName extends StatefulWidget {
  const AddName({super.key});

  @override
  State<AddName> createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  TextEditingController name = TextEditingController();
  int radioValue = 2;

  handleRadioValueChange(int value) {
    setState(() {
      radioValue = value;
    });
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
              "Create New Survey",
              style: TextStyle(
                  fontSize: 20, color: ck.x, fontWeight: FontWeight.w800),
            ),
            textField("Name", name),
            gap20(),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text("Select Template")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 1,
                  groupValue: radioValue,
                  onChanged: (value) {
                    handleRadioValueChange(1);
                  },
                ),
                const Text(
                  'YES/NO',
                  style: TextStyle(fontSize: 16.0),
                ),
                Radio(
                  value: 2,
                  groupValue: radioValue,
                  onChanged: (value) {
                    handleRadioValueChange(2);
                  },
                ),
                const Text(
                  'MCQs',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            gap20(),
            ElevatedButton(
              onPressed: () {

                if (radioValue == 2) {
                  Db().createSurvey(name: name.text,type: 'MCQS');

                } else {
                  Db().createSurvey(name: name.text,type: 'Yes/No');
                }
              },
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
