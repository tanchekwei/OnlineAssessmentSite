using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineAssessmentSite.Student
{
    public partial class TakeAssessment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //int assessmentID = int.Parse(Request.QueryString["assessmentID"]);

            //Response.Write("<script language=javascript>alert('" + assessmentID + "');</script>");
            int assessmentID = 1008;
            OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db
                = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();

            var assessment = _db.Assessments.Where(a => a.assessmentID == assessmentID).Single();
            int noOfQuestion = _db.Assessments.Where(a => a.assessmentID == assessmentID).Count();


            lblName.Text = assessment.assessmentName;

            if (assessment.assessmentType == "MCQ")
            {
                var questions = _db.Questions.Where(q => q.assessmentID == assessmentID).ToList();

                foreach (Models.Question q in questions)
                {
                    PlaceHolder holder = new PlaceHolder();
                    Label label = new Label();
                    label.Text = q.questionName;
                    plh.Controls.Add(label);
                }
            }
            else
            {
                var questions = _db.Questions.Where(q => q.assessmentID == assessmentID).ToList();

                int counter = 1;
                foreach (Models.Question q in questions)
                {
                    //PlaceHolder holder = new PlaceHolder();

                    //Label questionName = new Label
                    //{
                    //    Text = "Question " + counter + ": " + q.questionName + " (" + q.questionMark + " marks)"
                    //};
                    //Label questionDesc = new Label
                    //{
                    //    Text = q.questionDesc
                    //};
                    //Label yourAnsStr = new Label
                    //{
                    //    Text = "Your answer: "
                    //};


                    // TODO: add question image row here

                    //////////////////////////////////////
                    // EXAMPLE: Question 1: test (0 marks)
                    TableRow NewRow1 = new TableRow();
                    TableCell NewCell11 = new TableCell() { HorizontalAlign = HorizontalAlign.Right };
                    TableCell NewCell12 = new TableCell();

                    NewCell11.Controls.Add
                        (
                        new Label
                        {
                            Text = "Question " + counter + ": "
                        });

                    NewCell12.Controls.Add(
                        new Label
                        {
                            Text = q.questionName + " (" + q.questionMark + " marks)"
                        });

                    NewRow1.Cells.Add(NewCell11);
                    NewRow1.Cells.Add(NewCell12);
                    tblQuestion.Rows.Add(NewRow1);

                    //////////////////////////////////////
                    // EXAMPLE: Description: ...
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
                            Text = q.questionDesc
                        });

                    NewRow2.Cells.Add(NewCell21);
                    NewRow2.Cells.Add(NewCell22);
                    tblQuestion.Rows.Add(NewRow2);

                    //////////////////////////////////////
                    // EXAMPLE: Your answer: <TextArea>
                    TableRow NewRow3 = new TableRow();
                    TableCell NewCell31 = new TableCell()
                    {
                        HorizontalAlign = HorizontalAlign.Right,
                        VerticalAlign = VerticalAlign.Top
                    };
                    TableCell NewCell32 = new TableCell();

                    NewCell31.Controls.Add
                        (
                        new Label
                        {
                            Text = "Your answer:"
                        });

                    TextBox textBox = new TextBox();
                    textBox.Style["resize"] = "none";
                    textBox.TextMode = TextBoxMode.MultiLine;
                    textBox.Width = Unit.Pixel(500);
                    textBox.Height = Unit.Pixel(100);


                    NewCell32.Controls.Add(textBox);
                    NewRow3.Cells.Add(NewCell31);
                    NewRow3.Cells.Add(NewCell32);
                    tblQuestion.Rows.Add(NewRow3);

                    counter++;
                }

            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

        }
    }
}