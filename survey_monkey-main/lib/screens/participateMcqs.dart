import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/Helper/Answers.dart';
import 'package:survey_monkey/constants.dart';
import 'package:survey_monkey/widgets/appbars.dart';
import 'package:survey_monkey/widgets/spacers.dart';

import '../Helper/User.dart';
import '../http/db.dart';

class ParticipateMCQs extends StatefulWidget {
  const ParticipateMCQs({super.key});

  @override
  State<ParticipateMCQs> createState() => _ParticipateMCQsState();
}

class _ParticipateMCQsState extends State<ParticipateMCQs> {

  late Future _future;

  @override
  void initState() {
    super.initState();
    _future = Db().surveyQuestion(id: User.tempSurveyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(20),
        child:_futureBuild(),
      ),
    );
  }

  Widget _futureBuild(){
    return Expanded(
      child: FutureBuilder(
          future: _future,
          builder:(context,AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return _list(snapshot);
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }
          }),
    );
  }

  Widget _list(AsyncSnapshot snapshot){

    return ListView.builder(
        shrinkWrap: true,
        itemCount:snapshot.data.length,
        itemBuilder: (context,i){
          Map data = snapshot.data[i];
          List<Answers> selectedAnswers = [];
          List<bool?> isChecked = List.generate(snapshot.data.length, (_) => false);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Question ${i+1}:",
                style: TextStyle(
                    fontSize: 16, color: ck.x, fontWeight: FontWeight.w800),
              ),
              Text( data['title'] ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isChecked[i],
                    onChanged: (value) {

                      isChecked[i] = value!;
                      setState(() {
                        isChecked[i] = value!;
                      });
                    },
                  ),
                  Text(data['option1']),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isChecked[i],
                    onChanged: (value) {
                      setState(() {
                        isChecked[i] = value!;
                      });
                    },
                  ),
                  Text(data['option2']),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isChecked[i],
                    onChanged: (value) {
                      setState(() {
                        isChecked[i] = value!;
                      });
                    },
                  ),
                  Text(data['option3']),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isChecked[i],
                    onChanged: (value) {
                      setState(() {
                        isChecked[i] = value!;
                      });
                    },
                  ),
                  Text(data['option4']),
                ],
              ),
              gap20(),
            ],
          );
        }) ;
  }




}
