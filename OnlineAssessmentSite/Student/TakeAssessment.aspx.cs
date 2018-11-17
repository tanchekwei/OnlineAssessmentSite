using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace OnlineAssessmentSite.Student
{
    public partial class TakeAssessment : System.Web.UI.Page
    {
        Models.Assessment assessment;
        Guid guid;
        protected void Page_Load(object sender, EventArgs e)
        {
            // TODO: Add timer, assessmentDuration


            //int assessmentID = int.Parse(Request.QueryString["assessmentid"]);
            int assessmentID = 1011;


            //Response.Write("<script language=javascript>alert('" + assessmentID + "');</script>");
            OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db
                = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();
            assessment = _db.Assessments.Where(a => a.assessmentID == assessmentID).Single();
            if (assessment.assessmentType == "MCQ")
            {
                displayMCQQuestion(assessment);
            }
            else
            {
                displayTextQuestion(assessment);
            }

            MembershipUser user = Membership.GetUser(User.Identity.Name);
            guid = (Guid)user.ProviderUserKey;


            Models.Attempt attempt = new Models.Attempt();
            attempt.UserId = guid;
            attempt.assessmentID = assessment.assessmentID;
            // TODO: start and end

        }

        protected void displayTextQuestion(Models.Assessment assessment)
        {
            OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db
                = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();

            //var assessment = _db.Assessments.Where(a => a.assessmentID == assessmentID).Single();
            var questions = _db.Questions.Where(q => q.assessmentID == assessment.assessmentID).ToList();
            int noOfQuestion = questions.Count();
            var pageCounter = 1;


            lblName.Text = assessment.assessmentName + " (Duration: " + assessment.assessmentDuration + " minutes)";

            pageCounter = 1;
            HtmlGenericControl myDiv = new HtmlGenericControl("div");
            Table table = new Table();

            myDiv.ID = "page" + pageCounter;
            myDiv.Attributes["class"] = "tabcontent";
            table.ID = "tablePage" + pageCounter;

            for (var i = 0; i < questions.Count(); i++)
            {
                if (i % 5 == 0 && i != 0) // every 5 questions seperate to different div
                {
                    plh.Controls.Add(myDiv);
                    pageCounter++;

                    myDiv = new HtmlGenericControl("div");
                    table = new Table();
                    table.ID = "tablePage" + pageCounter;
                    myDiv.ID = "page" + pageCounter;
                    myDiv.Attributes["class"] = "tabcontent";
                }


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
                        Text = questions[i].questionDesc
                    });

                NewRow2.Cells.Add(NewCell21);
                NewRow2.Cells.Add(NewCell22);
                table.Rows.Add(NewRow2);


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
                table.Rows.Add(NewRow3);

                myDiv.Controls.Add(table);
            }
            if (noOfQuestion % 5 != 0)
            {
                plh.Controls.Add(myDiv);
            }


            Button btnSubmit = new Button();
            btnSubmit.ID = "btnSubmit";
            btnSubmit.OnClientClick = "";
            btnSubmit.Text = "Submit";
            btnSubmit.Attributes["class"] = "button button1";
            btnSubmit.Click += new EventHandler(btnSubmit_Click);

            HtmlGenericControl wrapperDiv = new HtmlGenericControl("div");
            wrapperDiv.Attributes["class"] = "container";

            wrapperDiv.Controls.Add(btnSubmit);
            myDiv.Controls.Add(wrapperDiv);
            plh.Controls.Add(myDiv);


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

            plh.Controls.Add(myDiv);

            // generate button for pages
            pageCounter = 1;
            for (var i = 0; i < noOfQuestion; i++)
            {
                if (i % 5 == 0)
                {
                    HtmlGenericControl myBtn = new HtmlGenericControl("button");
                    myBtn.InnerText = "Page " + pageCounter;
                    myBtn.Attributes["class"] = "tablink";

                    //var onclicktext = HttpUtility.JavaScriptStringEncode("openPage('ContentPlaceHolder1_page" + pageCounter + "', this)", false);
                    var onclicktext = "openPage(\'ContentPlaceHolder1_page" + pageCounter + "');return false;";

                    myBtn.Attributes["onclick"] = onclicktext;
                    plhBtn.Controls.Add(myBtn);
                    pageCounter++;
                }
            }
        }

        protected void displayMCQQuestion(Models.Assessment assessment)
        {
            OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db
                = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();

            var questions = _db.Questions.Where(q => q.assessmentID == assessment.assessmentID).ToList();
            int noOfQuestion = questions.Count();
            var pageCounter = 1;


            lblName.Text = assessment.assessmentName + " (Duration: " + assessment.assessmentDuration + " minutes)";

            pageCounter = 1;
            HtmlGenericControl myDiv = new HtmlGenericControl("div");
            Table table = new Table();
            table.CellPadding = 10;
            myDiv.ID = "page" + pageCounter;
            myDiv.Attributes["class"] = "tabcontent";
            table.ID = "tablePage" + pageCounter;

            for (var i = 0; i < questions.Count(); i++)
            {
                if (assessment.assessmentType == "MCQ")
                {

                }

                if (i % 10 == 0 && i != 0) // every 5 questions seperate to different div
                {
                    plh.Controls.Add(myDiv);
                    pageCounter++;

                    myDiv = new HtmlGenericControl("div");
                    table = new Table();
                    table.CellPadding = 10;
                    table.ID = "tablePage" + pageCounter;
                    myDiv.ID = "page" + pageCounter;
                    myDiv.Attributes["class"] = "tabcontent";
                }


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


                //////////////////////////////////////
                // EXAMPLE: Your answer: <RADIO BUTTION>
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

                string[] choice = questions[i].questionDesc.Split('|');
                char value = 'A';
                RadioButtonList radioButtonList = new RadioButtonList();
                radioButtonList.ID = "ansQ" + (i + 1);
                radioButtonList.RepeatDirection = RepeatDirection.Vertical;
                radioButtonList.AutoPostBack = false;
                for (var c = 0; c < choice.Length; c++)
                {
                    //RadioButton button = new RadioButton();
                    //button.Text = choice[c];
                    //button.GroupName = "q" + (i + 1);
                    //button.AutoPostBack = false;

                    radioButtonList.Items.Add(new ListItem(choice[c], value.ToString()));

                    value = (char)((int)value + 1);
                }
                NewCell32.Controls.Add(radioButtonList);

                // hidden field for adding answer to database
                NewCell32.Controls.Add(new HiddenField()
                {
                    ID = "q" + (i + 1) + "Id",
                    Value = questions[i].questionID.ToString()
                });

                NewRow3.Cells.Add(NewCell31);
                NewRow3.Cells.Add(NewCell32);
                table.Rows.Add(NewRow3);
                myDiv.Controls.Add(table);
            }
            if (noOfQuestion % 10 != 0)
            {
                plh.Controls.Add(myDiv);
            }

            Button btnSubmit = new Button();
            btnSubmit.ID = "btnSubmit";
            btnSubmit.OnClientClick = "";
            btnSubmit.Text = "Submit";
            btnSubmit.Attributes["class"] = "button button1";
            btnSubmit.Click += new EventHandler(btnSubmit_Click);


            HtmlGenericControl wrapperDiv = new HtmlGenericControl("div");
            wrapperDiv.Attributes["class"] = "container";

            wrapperDiv.Controls.Add(btnSubmit);
            myDiv.Controls.Add(wrapperDiv);
            plh.Controls.Add(myDiv);


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

            //plh.Controls.Add(myDiv);

            // generate button for pages
            pageCounter = 1;
            for (var i = 0; i < noOfQuestion; i++)
            {
                if (i % 10 == 0)
                {
                    HtmlGenericControl myBtn = new HtmlGenericControl("button");
                    myBtn.InnerText = "Page " + pageCounter;
                    myBtn.Attributes["class"] = "tablink";

                    //var onclicktext = HttpUtility.JavaScriptStringEncode("openPage('ContentPlaceHolder1_page" + pageCounter + "', this)", false);
                    var onclicktext = "openPage(\'ContentPlaceHolder1_page" + pageCounter + "');return false;";

                    myBtn.Attributes["onclick"] = onclicktext;
                    plhBtn.Controls.Add(myBtn);
                    pageCounter++;
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db
                = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();
            int noOfQuestion = _db.Questions.Where(q => q.assessmentID == assessment.assessmentID).Count();


            //// UserId
            //MembershipUser user = Membership.GetUser(User.Identity.Name);
            //Guid guid = (Guid)user.ProviderUserKey;



            //string selectedKey2 = Request.Form["ctl00$ContentPlaceHolder1$q1Id"];

            //// radio button list
            //string selectedKey3 = Request.Form["ctl00$ContentPlaceHolder1$ansQ1"];



            //Response.Write("<script language=javascript>alert('" + selectedKey3 + "');</script>");



            if (assessment.assessmentType == "MCQ")
            {
                int questionNo = 1;
                // try to obtain questionID
                for (var i = 0; i < noOfQuestion; i++)
                {

                    Models.Answer answer = new Models.Answer();

                    // Question ID (format = ctl00$ContentPlaceHolder1$q1Id)
                    string strQuestionID = Request.Form["ctl00$ContentPlaceHolder1$q" + questionNo + "Id"];
                    answer.questionID = int.Parse(strQuestionID);

                    // User ID
                    answer.UserId = guid;

                    // Answer (format = ctl00$ContentPlaceHolder1$ansQ1)
                    answer.answer1 = Request.Form["ctl00$ContentPlaceHolder1$ansQ" + questionNo];

                    // Attempt ID

                    questionNo++;
                }

            }
            else
            {

            }
        }
    }
}