import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/Helper/User.dart';
import 'package:survey_monkey/constants.dart';

import '../Helper/Answers.dart';
import '../http/db.dart';
import '../widgets/appbars.dart';
import '../widgets/spacers.dart';

class ParticipateYesNo extends StatefulWidget {
  const ParticipateYesNo({super.key});

  @override
  State<ParticipateYesNo> createState() => _ParticipateYesNoState();
}

class _ParticipateYesNoState extends State<ParticipateYesNo> {

  late Future _future;
  List<List<bool?>> isCheckedList = [];
  List<Answers> ans = [];

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
        child: Column(
          children: [
            Expanded(child:  _futureBuild(),),
            _submit(),
          ],
        ),
      ),
    );
  }


  Widget _futureBuild(){
    return FutureBuilder(
        future: _future,
        builder:(context,AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return _list(snapshot);
          }else {
            return const Center(child: CircularProgressIndicator(),);
          }
        });
  }

  Widget _list(AsyncSnapshot snapshot){

    return ListView.builder(
        shrinkWrap: true,
        itemCount:snapshot.data.length,
        itemBuilder: (context,i){
          Map data = snapshot.data[i];
          if (isCheckedList.length <= i) {
            isCheckedList.add(List.generate(2, (_) => false));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Question ${i+1}:",
                style: TextStyle(
                    fontSize: 16, color: ck.x, fontWeight: FontWeight.w800),
              ),
               Text( data['title'] ),
              buildRow(data['option1'], i, 0,data),
              buildRow(data['option2'], i, 1,data),
              gap20(),
            ],
          );
        }) ;
  }


  Widget buildRow(String option, int questionIndex, int checkboxIndex ,Map data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: isCheckedList[questionIndex][checkboxIndex],
          onChanged: (value) {
            setState(() {
              isCheckedList[questionIndex][checkboxIndex] = value;

              var t = Answers();
              t.qid = data['id'];
              t.response = option;


              bool isAlreadyInList = ans.any((element) =>
              element.qid == t.qid && element.response == t.response);

              if (value == true && !isAlreadyInList) {
                ans.add(t);
              }

              else if (value == false && isAlreadyInList) {
                ans.removeWhere((element) =>
                element.qid == t.qid && element.response == t.response);
              }
            });
          },
        ),
        Text(option),
      ],
    );
  }


  Widget _submit(){
    return ElevatedButton(
      onPressed: () async {
        if(ans.isNotEmpty){
          await Db().submitSurveyAnswers(ans: ans);
        }else{
          print('nothing to submit');
        }
      },
      child: const Text("Submit"),
    );

  }

}
