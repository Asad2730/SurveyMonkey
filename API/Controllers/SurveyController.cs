using API.Models;
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
       
       public survey_monkey_databaseEntities  db = new survey_monkey_databaseEntities();


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
              return Request.CreateResponse(HttpStatusCode.OK,s.id);

            }catch(Exception ex)
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
        public HttpResponseMessage surveyByApproved(int ap)
        {
            try
            {
                var q = db.surveys.Where(i => i.approved == ap && i.status == "public").ToList();
                return Request.CreateResponse(HttpStatusCode.OK,q);

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
        public HttpResponseMessage acceptRejectSurvey(int id,int approved )
        {
            try
            {
                var q = db.surveys.FirstOrDefault(i => i.id == id);
                 q.approved = approved;
                 db.SaveChanges();
                
                return Request.CreateResponse(HttpStatusCode.OK,q);

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

    }


}
