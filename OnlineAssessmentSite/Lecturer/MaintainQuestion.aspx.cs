using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineAssessmentSite.Lecturer
{
    public partial class MaintainQuestion : System.Web.UI.Page
    {
        protected string assessmentID = "";
        protected string assessmentName = "";
        protected string assessmentDuration = "";
        protected string assessmentType = "";
        protected string assessmentVisibility = "";
        protected string assessmentDates = "";

        protected static int tbCount = 2;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cbInsertPanel.Checked = true;
                cbRUDPanel.Checked = true;
            }

            assessmentID = (String)this.Session["asmID"];
            assessmentName = (String)this.Session["asmName"];
            assessmentDuration = (String)this.Session["asmDuration"];
            assessmentType = (String)this.Session["asmType"];
            assessmentVisibility = (String)this.Session["asmVisibility"];
            assessmentDates = (String)this.Session["asmDates"];

            lblAID.Text = assessmentID;
            lblAName.Text = assessmentName;
            lblADuration.Text = assessmentDuration;
            lblAType.Text = assessmentType;
            lblAVisibility.Text = assessmentVisibility;
            lblADates.Text = assessmentDates;

            lblInsertErrorMsg.Text = (String)this.Session["insertWarning"];
            lblUploadWarning.Text = (String)this.Session["uploadWarning"];
            lblSuccessInsert.Text = (String)this.Session["insertSuccessMsg"];

            if (lblAType.Text == "WRT")
            {
                (fvInsertQuestion.FindControl("panelWritten") as Panel).Visible = true;

                (fvInsertQuestion.FindControl("txtQAnswer") as TextBox).Visible = false;
                (fvInsertQuestion.FindControl("panelSelection") as Panel).Visible = false;
                (fvInsertQuestion.FindControl("btnAddTB") as Button).Visible = false;
                (fvInsertQuestion.FindControl("btnRemoveTB") as Button).Visible = false;
            }
            else
            {
                (fvInsertQuestion.FindControl("panelWritten") as Panel).Visible = false;

                (fvInsertQuestion.FindControl("txtQAnswer") as TextBox).Visible = true;
                (fvInsertQuestion.FindControl("panelSelection") as Panel).Visible = true;
                (fvInsertQuestion.FindControl("btnAddTB") as Button).Visible = true;
                (fvInsertQuestion.FindControl("btnRemoveTB") as Button).Visible = true;
            }

            TextBox tb;
            for (int i = 0; i < tbCount; i++)
            {
                tb = new TextBox();
                tb.Height = 35;
                tb.Width = fvInsertQuestion.Width;
                tb.TextMode = TextBoxMode.MultiLine;
                tb.Wrap = true;
                tb.ID = "txtSelection" + i;
                
                (fvInsertQuestion.FindControl("panelSelection") as Panel).Controls.Add(tb);
            }
        }

        public void fvInsertQuestion_InsertItem()
        {

            // Reference the FileUpload controls
            Boolean wrongFormatPicture = true;
            FileUpload PictureUpload = fvInsertQuestion.FindControl("fuQImage") as FileUpload;
            string picturePath = "";
            if (PictureUpload.HasFile)
            {
                // Make sure that a JPG has been uploaded
                if (string.Compare(System.IO.Path.GetExtension(PictureUpload.FileName),
                        ".jpg", true) != 0 &&
                    string.Compare(System.IO.Path.GetExtension(PictureUpload.FileName),
                        ".jpeg", true) != 0)
                {
                    wrongFormatPicture = false;
                } else
                {
                    const string PictureDirectory = "~/Picture/Assessment/";
                    picturePath = PictureDirectory + PictureUpload.FileName;
                    string fileNameWithoutExtension =
                        System.IO.Path.GetFileNameWithoutExtension(PictureUpload.FileName);
                    int iteration = 1;
                    while (System.IO.File.Exists(Server.MapPath(picturePath)))
                    {
                        picturePath = string.Concat(PictureDirectory,
                            fileNameWithoutExtension, "-", iteration, ".jpg");
                        iteration++;
                    }
                    PictureUpload.SaveAs(Server.MapPath(picturePath));
                }
                
            }

            string assessmentID = lblAID.Text;
            string questionName = (fvInsertQuestion.FindControl("txtQName") as TextBox).Text;
            string questionDesc = "";
            string questionAnswer = (fvInsertQuestion.FindControl("txtQAnswer") as TextBox).Text;
            int questionMark = 0;
            Int32.TryParse((fvInsertQuestion.FindControl("txtQMark") as TextBox).Text.ToString(), out questionMark);
            if(lblAType.Text.Equals("WRT"))
            {
                questionDesc = (fvInsertQuestion.FindControl("txtQDesc") as TextBox).Text;
            } else
            {
                Panel panelSelection = fvInsertQuestion.FindControl("panelSelection") as Panel;
                string seperator = "|";
                for(int i = 0; i < tbCount; i++)
                {
                    if ((panelSelection.FindControl("txtSelection" + i.ToString()) as TextBox).Text != "")
                    {
                        questionDesc += (panelSelection.FindControl("txtSelection" + i.ToString()) as TextBox).Text;
                        if (i != tbCount - 1)
                        {
                            questionDesc += seperator;
                        }
                    }
                }
                questionAnswer = (fvInsertQuestion.FindControl("txtQAnswer") as TextBox).Text;
            }

            if (assessmentID == "" || questionName == "" || questionDesc == "" || questionMark == 0 || (questionAnswer == "" && assessmentType == "MCQ") || wrongFormatPicture == false)
            {
                if (assessmentID == "" || questionName == "" || questionDesc == "" || questionMark == 0 || (questionAnswer == "" && assessmentType == "MCQ"))
                {
                    this.Session["insertWarning"] = "These field cannot be empty.";
                }
                
                if (wrongFormatPicture == false)
                {
                    this.Session["uploadWarning"] = "Only JPG/JPEG documents allowed.";
                }
                this.Session["insertSuccessMsg"] = "Insert question operation failed.";
            } else
            {
                this.Session["insertWarning"] = "";
                this.Session["uploadWarning"] = "";
                this.Session["insertSuccessMsg"] = "Inserted question successfully.";
                SqlConnection con;
                SqlCommand cmd;
                string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                con = new SqlConnection(connStr);
                con.Open();
                cmd = new SqlCommand("INSERT INTO QUESTIONS VALUES (@assessmentID, @questionName, @questionDesc, @questionAnswer, @questionImage, @questionMark)", con);
                cmd.Parameters.AddWithValue("@assessmentID", assessmentID);
                cmd.Parameters.AddWithValue("@questionName", questionName);
                cmd.Parameters.AddWithValue("@questionDesc", questionDesc);
                cmd.Parameters.AddWithValue("@questionAnswer", questionAnswer);
                cmd.Parameters.AddWithValue("@questionImage", picturePath);
                cmd.Parameters.AddWithValue("@questionMark", questionMark);
                cmd.ExecuteNonQuery();
                con.Close();
            }

            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void btnAddTB_Click(object sender, EventArgs e)
        {
            tbCount++;
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void btnRemoveTB_Click(object sender, EventArgs e)
        {
            if(tbCount > 2)
            {
                tbCount--;
                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
        }

        protected void dvRUD_DataBound(object sender, EventArgs e)
        {
            if (dvRUD.CurrentMode == DetailsViewMode.ReadOnly && dvRUD.Rows.Count > 2 && assessmentType.Equals("MCQ"))
            {
                string[] qDesc = dvRUD.Rows[3].Cells[1].Text.ToString().Split('|');
                String newQDesc = "";
                char character = 'A';
                for (int i = 0; i < qDesc.Length; i++)
                {
                    newQDesc += character.ToString() + ". " + qDesc[i] + "<br />";
                    character++;
                }
                dvRUD.Rows[3].Cells[1].Text = newQDesc;
            }

            if (assessmentType.Equals("WRT") && dvRUD.Rows.Count > 3)
            {
                dvRUD.Rows[4].Cells[1].Text = "NONE";
            }
        }

        protected void InsertClearButton_Click(object sender, EventArgs e)
        {
            //Refresh
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void cbInsertPanel_CheckedChanged(object sender, EventArgs e)
        {
            if (cbInsertPanel.Checked)
            {
                panelInsert.Visible = true;
            }
            else
            {
                panelInsert.Visible = false;
            }
        }

        protected void cbRUDPanel_CheckedChanged(object sender, EventArgs e)
        {
            if (cbRUDPanel.Checked)
            {
                panelRUD.Visible = true;
            }
            else
            {
                panelRUD.Visible = false;
            }
        }

        protected void dvRUD_PreRender(object sender, EventArgs e)
        {
            if (dvRUD.CurrentMode == DetailsViewMode.Edit)
            {
                TextBox tb1 = (dvRUD.Rows[2].Cells[1].Controls[0] as TextBox);
                tb1.TextMode = TextBoxMode.MultiLine;
                tb1.Width = dvRUD.Width;
                tb1.Height = 50;
                tb1.Wrap = true;

                TextBox tb2 = (dvRUD.Rows[3].Cells[1].Controls[0] as TextBox);
                tb2.TextMode = TextBoxMode.MultiLine;
                tb2.Width = dvRUD.Width;
                tb2.Height = 50;
                tb2.Wrap = true;

                TextBox tb3 = (dvRUD.Rows[4].Cells[1].Controls[0] as TextBox);
                tb3.Width = 20;
                tb3.Height = 20;

                TextBox tb4 = (dvRUD.Rows[5].Cells[1].Controls[0] as TextBox);
                tb4.Width = 50;
                tb4.Height = 20;
            }
        }
    }
}