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

            if (cookie["Quitted"] != null)
            {
                lblMsg3.Text = "Status: Quitted.";
            }

            // Can finally destroy this cookie
            cookie.Expires = DateTime.Now.AddDays(-1);

            if (assessment.assessmentType == "MCQ")
            {
                int noQuestionCorrect = int.Parse(cookie["noQuestionCorrect"]);
                int noQuestion = int.Parse(cookie["noQuestion"]);
                //double percentage = attempt.attemptScore / //total score * 100
                // TODO: save total score of assessment in takeassessment calculate percentage.
                lblMsg1.Text = "Your Score is:<br />";
                lblMsg2.Text = "You corrected " + noQuestionCorrect + " out of " + noQuestion + " questions.<br />";
            }
            else
            {
                lblMsg1.Text = "Your result will appear after assessed by your lecturer.";
            }
            lblMsg2.Text += "Thank you for taking " + assessment.assessmentName + "!";

            //Response.Write("<script language=javascript>alert('" + attemptID + "/" + assessmentID + "');</script>");

        }
    }
}