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
                int noQuestionCorrect = Convert.ToInt32(cookie["noQuestionCorrect"]);
                int noQuestion = Convert.ToInt32(cookie["noQuestion"]);

                double score = (double)Convert.ToInt32(attempt.attemptScore);
                double total = (double)Convert.ToInt32(assessment.assessmentTotalMark);

                double percentage = score / total * 100;
                lblMsg1.Text = "Your Score is: " + percentage.ToString("0.00") + "%";
                lblMsg2.Text = "You corrected " + noQuestionCorrect + " out of " + noQuestion + " questions.<br /><br />";
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