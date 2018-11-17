using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineAssessmentSite.Student
{
    public partial class ViewResult : System.Web.UI.Page
    {
        OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db
            = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();

        protected void Page_Load(object sender, EventArgs e)
        {
            var cookie = Request.Cookies["takeAssessment"];
            int attemptID = int.Parse(cookie["attemptID"]);
            int assessmentID = int.Parse(cookie["assessmentID"]);

            var attempt = _db.Attempts.Where(a => a.attemptID == attemptID).Single();
            var assessment = _db.Assessments.Where(a => a.assessmentID == assessmentID).Single();

            Boolean quitted = false;

            if (cookie["Quitted"] != null)
            {
                quitted = Boolean.Parse(cookie["Quitted"]);
            }

            // Can finally destroy this cookie
            cookie.Expires = DateTime.Now.AddDays(-1);

            if (assessment.assessmentType == "MCQ")
            {
                int noQuestionCorrect = int.Parse(cookie["noQuestionCorrect"]);

                //double percentage = attempt.attemptScore / //total score * 100

                lblMessage.Text = "Your Score is:<br />";

            }
            else
            {

            }

            //Response.Write("<script language=javascript>alert('" + attemptID + "/" + assessmentID + "');</script>");

        }
    }
}