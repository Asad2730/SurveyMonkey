﻿using API.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;




namespace API.Controllers
{
    public class SurveyController : ApiController
    {

        public survey_monkey_databaseEntities3 db = new survey_monkey_databaseEntities3();


        [HttpGet]
        public HttpResponseMessage login(string id, string password)
        {
            try
            {
                var student = db.STMTRs.FirstOrDefault(i => i.Reg_No == id && i.Password == password);
                if (student != null)
                {
                    var response = new
                    {
                        Success = true,
                        UserType = "Student",
                        Data = student,
                        Message = "Login successful."
                    };
                    return Request.CreateResponse(HttpStatusCode.OK, response);
                }

                var employee = db.EMPMTRs.FirstOrDefault(i => i.Emp_no == id && i.Password == password);
                if (employee != null)
                {
                    var response = new
                    {
                        Success = true,
                        UserType = "Employee",
                        Data = employee,
                        Message = "Login successful."
                    };
                    return Request.CreateResponse(HttpStatusCode.OK, response);
                }

                var errorResponse = new
                {
                    Success = false,
                    Message = "Invalid credentials."
                };
                return Request.CreateResponse(HttpStatusCode.Unauthorized, errorResponse);
            }
            catch (Exception ex)
            {

                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex);
            }
        }



        [HttpPost]
        public HttpResponseMessage createSurvey(survey s)
        {
            try
            {
                db.surveys.Add(s);
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, s.id);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex);
            }
        }


        [HttpPost]
        public HttpResponseMessage addQuestion(surveyquestion s)
        {
            try
            {
                db.surveyquestions.Add(s);
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex);
            }
        }


        [HttpGet]
        public HttpResponseMessage surveyByApproved(int ap,string Discipline,string Section,string Semester_no,string status)
        {
            try
            {

                List<survey> list = new List<survey>();

                var rs = db.surveys.Join(db.ActiveSurveys, s => s.id, a => a.sid,
                    (s, a) => new
                    {
                        s,
                        a,
                    }).Where(w=>w.a.discipline == Discipline && w.a.section == Section && w.a.semester == Semester_no && w.s.approved == 3).ToList();

                rs.ForEach(i =>
                {
                    list.Add(i.s);
                });
                var q = db.surveys.Where(i => i.approved == ap && i.status == status).ToList();

                q.ForEach(i =>
                {
                    list.Add(i);
                });
                return Request.CreateResponse(HttpStatusCode.OK, list);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex);
            }
        }


        [HttpGet]
        public HttpResponseMessage surveyNotApproved()
        {
            try
            {   
                var q = db.surveys.Where(i => i.approved == 2 && i.status == "private").ToList();          
                return Request.CreateResponse(HttpStatusCode.OK, q);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex);
            }
        }



        [HttpGet]
        public HttpResponseMessage getAllSurveys()
        {
            try
            {
                var q = db.surveys.Select(i => i).ToList();
                return Request.CreateResponse(HttpStatusCode.OK, q);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex);
            }
        }

        [HttpPost]
        public HttpResponseMessage acceptRejectSurvey(int id, int approved)
        {
            try
            {
                var q = db.surveys.FirstOrDefault(i => i.id == id);
                q.approved = approved;
                db.SaveChanges();

                return Request.CreateResponse(HttpStatusCode.OK, q);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex);
            }
        }

        [HttpGet]
        public HttpResponseMessage surveyQuestion(int id)
        {
            try
            {
                var q = db.surveyquestions.Where(i => i.surveyid == id).ToList();
                return Request.CreateResponse(HttpStatusCode.OK, q);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex);
            }
        }


        [HttpPost]
        public HttpResponseMessage submitSurveyAnswers(surveyresponse s)
        {
            try
            {
                var q = db.surveyresponses.Add(s);
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, q);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex);
            }
        }


        [HttpGet]
        public HttpResponseMessage results()
        {
            try
            {
                var q = db.surveys
                    .GroupJoin(db.surveyquestions, i => i.id, r => r.surveyid,
                        (i, responses) => new
                        {
                            id = i.id,
                            name = i.name,
                            responses = responses.Select(r => new
                            {
                                op1 = r.option1,
                                op2 = r.option2,
                                op3 = r.option3,
                                op4 = r.option4,

                            })
                        })
                    .ToList();

                return Request.CreateResponse(HttpStatusCode.OK, q);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex);
            }
        }



        [HttpGet]
        public HttpResponseMessage calculateGraph(int sid)
        {
            try
            {
                var questions = db.surveyquestions.Where(i => i.surveyid == sid).ToList();
                var responses = db.surveyresponses.Where(i => i.surveyid == sid).ToList();

             
                var optionCounts = new int[4] { 0, 0, 0, 0 };

               
                foreach (var response in responses)
                {
                    
                    foreach (var question in questions)
                    {
                       
                        if (response.response == question.option1)
                            optionCounts[0]++;
                        else if (response.response == question.option2)
                            optionCounts[1]++;
                        else if (response.response == question.option3)
                            optionCounts[2]++;
                        else if (response.response == question.option4)
                            optionCounts[3]++;
                    }
                }

                
                int totalCount = optionCounts.Sum();

              
                var optionPercentages = optionCounts.Select(count => (count * 100.0) / totalCount).ToArray();

                return Request.CreateResponse(HttpStatusCode.OK, optionPercentages);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex);
            }
        }



        [HttpGet]
        public HttpResponseMessage getDiscipline()
        {
            try
            {
                var q = db.Crsdtls.Select(c => c.DISCIPLINE).Distinct().ToList();
                return Request.CreateResponse(HttpStatusCode.OK,q);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex);
            }
        }


        [HttpGet]
        public HttpResponseMessage getSection(string discipline)
        {
            try
            {
                var q = db.Crsdtls
                    .Where(c => c.SEMESTER_NO == "2022SM" && c.DISCIPLINE == discipline)
                    .Select(c => new { c.CrsSemNo, c.SECTION })  
                    .Distinct()
                    .OrderBy(c => c.CrsSemNo)
                    .ToList();

                return Request.CreateResponse(HttpStatusCode.OK, q);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex);
            }
        }

        [HttpPost]
        public HttpResponseMessage addActiveSurvey(ActiveSurvey a)
        {
            try
            {  
                var s = db.surveys.FirstOrDefault(i=>i.id == a.sid);
                if(s != null)
                {

                    s.aid = a.sid;
                    s.status = "public";
                    s.approved = 3;
                    db.SaveChanges();
                }
                var q = db.ActiveSurveys.Add(a);
                db.SaveChanges();
                return Request.CreateResponse(HttpStatusCode.OK, q);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.ToString());
            }
        }


        [HttpGet]
        public HttpResponseMessage getSurveyHistory()
        {
            try
            {
                List<History> list = new List<History>();
                var q1 = db.surveys.Join(db.EMPMTRs, s => s.createdby, e => e.Emp_no,
                    (s, e) => new
                    {
                        s,e
                    }).ToList();

                var q2 = db.surveys.Join(db.STMTRs, s => s.createdby, e => e.Reg_No,
                   (s, e) => new
                   {
                       s,
                       e
                   }).ToList();

                q1.ForEach(i =>
                {
                    History h = new History();
                    h.surveyName = i.s.name;
                    h.type = i.s.type;
                    h.createdBy = i.e.Emp_firstname;
                    list.Add(h);
                });


                q2.ForEach(i =>
                {
                    History h = new History();
                    h.surveyName = i.s.name;
                    h.type = i.s.type;
                    h.createdBy = i.e.St_firstname;
                    list.Add(h);
                });
                return Request.CreateResponse(HttpStatusCode.OK, list);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex);
            }
        }


    }


    class History
    {
        public string surveyName { get; set;}
        public string type { get; set;}
        public string createdBy { get; set;}
    }

}
