using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity;
// TODO: test MCQ question, if no answer, the mark is null or zero same with WRT

namespace OnlineAssessmentSite.Lecturer
{
    public partial class MarkAssessment1 : System.Web.UI.Page
    {
        OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db
            = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // items in args[]
                //  [0] = assessmentID
                //  [1] = attemptID
                //  [2] = UserId
                HttpCookie httpCookie = Request.Cookies["markAssessment"];
                string[] args = httpCookie["args"].Split(',');

                // Display assessment name, duration, student name
                int assessmentID = int.Parse(args[0]);
                var assessment = _db.Assessments.Where(a => a.assessmentID == assessmentID).Single();
                lblAssessmentName.Text = assessment.assessmentName + 
                    " (" + assessment.assessmentDuration + " minutes)";

                Guid guid = new Guid(args[2]);
                var userProfile = _db.UserProfiles.Where(u => u.UserId == guid).Single();
                lblStudName.Text = userProfile.Name;
                ///////////////////////////////////////////////////

                // Display question, question desc, question mark, student answer, comment text box
                // Get question using assessmentID
                var questions = _db.Questions.Where(q => q.assessmentID == assessmentID).ToList();
                int noOfQuestion = questions.Count();

                // Get answer using attemptID
                int attemptID = int.Parse(args[1]);
                var answer = _db.Answers.Where(a => a.attemptID == attemptID).ToList();

                // Create table to put them inside
                Table table = new Table();

                // Loop through question
                for (int i = 0; i < noOfQuestion; i++)
                {   
                    //////////////////////////////////
                    // Display question //////////////
                    TableRow NewRow1 = new TableRow();
                    TableCell NewCell11 = new TableCell() { HorizontalAlign = HorizontalAlign.Right };
                    TableCell NewCell12 = new TableCell();

                    NewCell11.Controls.Add
                        (
                        new Label
                        {
                            Text = "Question " + (i + 1) + ": "
                        });

                    NewCell12.Controls.Add(
                        new Label
                        {
                            Text = questions[i].questionName + " (" + questions[i].questionMark + " marks)"
                        });

                    NewRow1.Cells.Add(NewCell11);
                    NewRow1.Cells.Add(NewCell12);
                    table.Rows.Add(NewRow1);
                    //////////////////////////////////
                    // Display question description //
                    TableRow NewRow2 = new TableRow();
                    TableCell NewCell21 = new TableCell() { HorizontalAlign = HorizontalAlign.Right };
                    TableCell NewCell22 = new TableCell();

                    NewCell21.Controls.Add
                        (
                        new Label
                        {
                            Text = "Description:"
                        });

                    NewCell22.Controls.Add
                        (
                        new Label
                        {
                            Text = questions[i].questionDesc
                        });

                    NewRow2.Cells.Add(NewCell21);
                    NewRow2.Cells.Add(NewCell22);
                    table.Rows.Add(NewRow2);

                    //////////////////////////////////
                    // Display student answer ////////

                }



                // rbm!!! we might not have all the answer. or the answer is null.

                //TextBox textBox = new TextBox();
                //textBox.Style["resize"] = "none";
                //textBox.TextMode = TextBoxMode.MultiLine;
                //textBox.Width = Unit.Pixel(500);
                //textBox.Height = Unit.Pixel(100);
                //textBox.ID = "comment" + (i + 1);


            }
        }
    }
}