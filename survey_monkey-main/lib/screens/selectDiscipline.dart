import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/screens/selectSection.dart';
import '../widgets/appbars.dart';
import '../widgets/spacers.dart';

class SelectDiscipline extends StatefulWidget {
  const SelectDiscipline({Key? key}) : super(key: key);

  @override
  State<SelectDiscipline> createState() => _SelectDisciplineState();
}

class _SelectDisciplineState extends State<SelectDiscipline> {
  var isChecked = false;
  var checkList = [];
  var disciplineList=[];


  var disciplineAll=[];

  var snap=["BSCS","BSIT","BSSE","BSAI"];




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: simpleAppBar(),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const Text(
              "Select Discipline",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            gap20(),
            CheckboxListTile(
              title: const Text("Select All"),
              value: isChecked,
              onChanged: (newValue) {

              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            gap20(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snap.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(snap[index].toString()),
                          value: false,
                          onChanged: (newValue) {

                          },
                          controlAffinity:
                          ListTileControlAffinity.leading,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            gap20(),
            ElevatedButton(onPressed: (){
              Get.to(SelectSection());
            }, child: Text("Next")),

          ],
        ),
      ),
    );
  }
}
