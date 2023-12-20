import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/widgets/appbars.dart';

import '../widgets/spacers.dart';

class SelectSection extends StatefulWidget {
  SelectSection({Key? key}) : super(key: key);

  @override
  State<SelectSection> createState() => _SelectSectionState();
}

class _SelectSectionState extends State<SelectSection> {
  var isChecked = false;

  var disciplineList = ["BSCS", "BSIT", "BSSE", "BSAI"];
  var sectionList = ['A', 'B', 'C'];
  var semesterList = [1, 2, 3, 4, 5, 6, 7, 8];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Select Sections",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              gap20(),
              CheckboxListTile(
                title: const Text("Select All"),
                value: isChecked,
                onChanged: (newValue) {},
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
              gap20(),
              SizedBox(
                width: Get.width,
                height: Get.height - 350,
                child: ListView.builder(
                  itemCount: disciplineList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: CheckboxListTile(
                        title: Text(disciplineList[index].toString()),
                        value: false,
                        onChanged: (newValue) {},
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: semesterList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index2) {
                              var index3 = 0;
                              if (index3 < 2) {
                                index3++;
                              } else {
                                index3 = 0;
                              }
                              return CheckboxListTile(
                                title: Text(
                                    "${semesterList[index2]}-${sectionList[index3]}"),
                                value: false,
                                onChanged: (newValue) {},
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              gap20(),
              ElevatedButton(onPressed: () {}, child:const Text("Next")),
            ],
          ),
        ),
      ),
    );
  }
}
