import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/Helper/User.dart';
import 'package:survey_monkey/constants.dart';

import '../http/db.dart';
import '../widgets/appbars.dart';
import '../widgets/spacers.dart';

class ParticipateYesNo extends StatefulWidget {
  const ParticipateYesNo({super.key});

  @override
  State<ParticipateYesNo> createState() => _ParticipateYesNoState();
}

class _ParticipateYesNoState extends State<ParticipateYesNo> {
  bool isChecked = false;
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
        child: _futureBuild(),
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
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
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
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Text(data['option2']),
                ],
              ),
              gap20(),
            ],
          );
        }) ;
  }

}
