import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/Helper/User.dart';
import 'package:survey_monkey/screens/adminHome.dart';
import 'package:survey_monkey/screens/userHome.dart';
import '../Helper/Answers.dart';
import '../screens/survey/addQuestionMcqs.dart';
import '../screens/survey/addQuestionYesNo.dart';

class Db{

    final _dio = Dio();
    final _ip = '192.168.10.11';

    Db(){
      _dio.options.baseUrl = 'http://$_ip/API/api/Survey/';
    }


    Future login({required id,required password}) async {
      try{
        var res = await _dio.get('login?id=$id&password=$password');
        if(res.data['UserType'] == 'Student'){

          User.id = res?.data['Data']['Reg_No'];
          User.name = res?.data['Data']['St_firstname'];
          Get.to(()=>const UserHome());
        }else
        {
          User.id = res?.data['Data']['Emp_no'];
          User.name = res?.data['Data']['Emp_firstname'];
          Get.to(()=>const AdminHome());
        }
      }catch(ex){
        print('error:$ex');
      }

    }


    Future createSurvey({required name,required type})async {
      try{
        var res = await _dio.post('createSurvey',data: {
          'name':name,
          'type':type,
          'createdby':User.id,
           'approved':0,
          'status':'public',
        });

        if(type == 'MCQS'){
          Get.to(()=> AddQuestionMcqs(id: res.data,));
        }else{
          Get.to(()=> AddQuestionYesNo(id:res.data));
        }
      }catch(ex){
        print('error:$ex');
      }
    }

    Future addQuestion({required q,required id,required bool isMore})async {
      try{
        await _dio.post('addQuestion',data: {
          'title':q,
          'option1':'yes',
          'option2':'no',
          'surveyid':id,
        });

        if(!isMore){
          Get.back();
        }
      }catch(ex){
        print('error:$ex');
      }
    }


    Future addMcq({required title,required id,
      required op1,required op2, required op3, required op4,
      required bool isMore
    })async {

      try{
        await _dio.post('addQuestion',data: {
          'title':title,
          'option1':op1,
          'option2':op2,
          'option3':op3,
          'option4':op4,
          'surveyid':id,
        });

        if(!isMore){
          Get.back();
        }
      }catch(ex){
        print('error:$ex');
      }
    }


    Future surveyByApproved({required ap})async {
      try{
        var rs = await _dio.get('surveyByApproved?ap=$ap');
        return rs.data as List;
      }catch(ex){
        print('error:$ex');
      }
    }

    Future getAllSurveys()async {
      try{
        var rs = await _dio.get('getAllSurveys');
        return rs.data as List;
      }catch(ex){
        print('error:$ex');
      }
    }


    Future acceptRejectSurvey({required id,required approved})async {
      try{
        await _dio.post('acceptRejectSurvey?id=$id&approved=$approved');
      }catch(ex){
        print('error:$ex');
      }
    }


    Future surveyQuestion({required id})async {
      try{
        var rs = await _dio.get('surveyQuestion?id=$id');
        return rs.data as List;
      }catch(ex){
        print('error:$ex');
      }
    }


    Future submitSurveyAnswers({ required List<Answers> ans}) async {
      try{
        DateTime today = DateTime.now();
        DateTime todayDate = DateTime(today.year, today.month, today.day);
          for (var i in ans) {
            var res = await _dio.post('submitSurveyAnswers',data: {
              'surveyid':User.tempSurveyId,
              'questionid':i.qid,
               'response':i.response,
               'userid':User.id,
               'date':todayDate.toString(),
            });

            print('submited-->${res.data}');
          }

          Get.back();
      }catch(ex){
        print('error:$ex');
      }
    }

}