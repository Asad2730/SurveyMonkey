import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:survey_monkey/Helper/ActiveSurvey.dart';
import 'package:survey_monkey/Helper/Graph.dart';
import 'package:survey_monkey/Helper/User.dart';
import 'package:survey_monkey/screens/adminHome.dart';
import 'package:survey_monkey/screens/previousSurvey.dart';
import 'package:survey_monkey/screens/userHome.dart';
import '../Helper/Answers.dart';
import '../screens/survey/addQuestionMcqs.dart';
import '../screens/survey/addQuestionYesNo.dart';

class Db {
  final _dio = Dio();
  final _ip = '192.168.10.12';

  Db() {
    _dio.options.baseUrl = 'http://$_ip/API/api/Survey/';
  }

  Future login({required id, required password}) async {
    try {
      var res = await _dio.get('login?id=$id&password=$password');
      if (res.data['UserType'] == 'Student') {
        User.id = res.data['Data']['Reg_No'];
        User.name = res.data['Data']['St_firstname'];
        User.discipline = res.data['Data']['Discipline'];
        User.semesterNo = res.data['Data']['Semester_no'];
        User.section = res.data['Data']['Section'];
        Get.to(() => const UserHome());
      } else {
        User.id = res.data['Data']['Emp_no'];
        User.name = res.data['Data']['Emp_firstname'];
        User.discipline = '';
        User.semesterNo = '';
        User.section = '';
        Get.to(() => const AdminHome());
      }
    } catch (ex) {
      print('error:$ex');
    }
  }

  Future createSurvey({required name, required type}) async {
    try {
      var res = await _dio.post('createSurvey', data: {
        'name': name,
        'type': type,
        'createdby': User.id,
        'approved': 0,
        'status': 'private',
      });

      if (type == 'MCQS') {
        Get.to(() => AddQuestionMcqs(
              id: res.data,
            ));
      } else {
        Get.to(() => AddQuestionYesNo(id: res.data));
      }
    } catch (ex) {
      print('error:$ex');
    }
  }

  Future addQuestion({required q, required id, required bool isMore}) async {
    try {
      await _dio.post('addQuestion', data: {
        'title': q,
        'option1': 'yes',
        'option2': 'no',
        'surveyid': id,
      });

      if (!isMore) {
        if (User.discipline == '') {
          Get.to(() => const AdminHome());
        } else {
          Get.to(() => const UserHome());
        }
      }
    } catch (ex) {
      print('error:$ex');
    }
  }

  Future addMcq(
      {required title,
      required id,
      required op1,
      required op2,
      required op3,
      required op4,
      required bool isMore}) async {
    try {
      await _dio.post('addQuestion', data: {
        'title': title,
        'option1': op1,
        'option2': op2,
        'option3': op3,
        'option4': op4,
        'surveyid': id,
      });

      if (!isMore) {
        if (User.discipline == '') {
          Get.to(() => const AdminHome());
        } else {
          Get.to(() => const UserHome());
        }
      }
    } catch (ex) {
      print('error:$ex');
    }
  }

  Future surveyByApproved({required ap, required status}) async {
    try {
      var rs = await _dio.get('surveyByApproved', queryParameters: {
        'ap': ap,
        'Discipline': User.discipline,
        'Section': User.section,
        'Semester_no': User.semesterNo,
        'status': status
      });
      return rs.data as List;
    } catch (ex) {
      print('error:$ex');
    }
  }

  //these are conducted surves
  Future surveyNotApproved() async {
    try {
      var rs = await _dio.get('surveyNotApproved');
      return rs.data as List;
    } catch (ex) {
      print('error:$ex');
    }
  }

  Future getAllSurveys() async {
    try {
      var rs = await _dio.get('getAllSurveys');
      return rs.data as List;
    } catch (ex) {
      print('error:$ex');
    }
  }

  Future results() async {
    try {
      var rs = await _dio.get('results');
      return rs.data as List;
    } catch (ex) {
      print('error:$ex');
    }
  }

  Future acceptRejectSurvey({required id, required approved}) async {
    try {
      await _dio.post('acceptRejectSurvey?id=$id&approved=$approved');
    } catch (ex) {
      print('error:$ex');
    }
  }

  Future surveyQuestion({required id}) async {
    try {
      var rs = await _dio.get('surveyQuestion?id=$id');
      return rs.data as List;
    } catch (ex) {
      print('error:$ex');
    }
  }

  Future submitSurveyAnswers({required List<Answers> ans}) async {
    try {
      DateTime today = DateTime.now();
      DateTime todayDate = DateTime(today.year, today.month, today.day);
      for (var i in ans) {
        await _dio.post('submitSurveyAnswers', data: {
          'surveyid': User.tempSurveyId,
          'questionid': i.qid,
          'response': i.response,
          'userid': User.id,
          'date': todayDate.toString(),
        });
      }

      Get.back();
    } catch (ex) {
      print('error:$ex');
    }
  }

  Future calculateGraph({required sid}) async {
    try {
      var rs = await _dio.get('calculateGraph?sid=$sid');
      Graph.v1 = rs.data[0];
      Graph.v2 = rs.data[1];
      Graph.v3 = rs.data[2];
      Graph.v4 = rs.data[3];
    } catch (ex) {
      print('error:$ex');
    }
  }

  Future<List<String>> getDiscipline() async {
    try {
      var rs = await _dio.get('getDiscipline');
      return (rs.data as List).cast<String>();
    } catch (ex) {
      print('error:$ex');
      return [];
    }
  }

  Future getSection() async {
    try {
      var rs = await _dio.get('getSection?discipline=${User.tempDiscipline}');
      return rs.data as List;
    } catch (ex) {
      print('error:$ex');
      return [];
    }
  }

  Future addActiveSurvey({required List<ActiveSurvey> survey}) async {
    try {
      for (var i in survey) {
        var q = await _dio.post('addActiveSurvey', data: {
          'sid': User.tempSurveyId,
          'startDate': User.tempStartDate.toString(),
          'endDate': User.tempEndDate.toString(),
          'section': i.section.toString(),
          'semester': i.semester.toString(),
          'discipline': User.tempDiscipline.toString()
        });
        print('Done-->${q.data}');
      }
      Get.to(() => const PreviousSurvey());
    } catch (ex) {
      print('error:$ex');
    }
  }

  Future getSurveyHistory() async {
    try {
      var res = await _dio.get('getSurveyHistory');
      return res.data as List;
    } catch (ex) {
      print('error:$ex');
      return [];
    }
  }
}
