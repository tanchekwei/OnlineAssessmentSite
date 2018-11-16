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

        protected void Page_Load(object sender, EventArgs e)
        {
            ContentPlaceHolder Cph;
            if (PreviousPage != null && PreviousPage.IsCrossPagePostBack)
            {
                if ((ContentPlaceHolder)PreviousPage.Master.FindControl("ContentPlaceHolder1") != null)
                {
                    Cph = (ContentPlaceHolder)PreviousPage.Master.FindControl("ContentPlaceHolder1");
                    // Display Assessment Info.
                    GridView gv = Cph.FindControl("GridViewAsm") as GridView;
                    assessmentID = gv.SelectedRow.Cells[1].Text;
                    assessmentName = gv.SelectedRow.Cells[2].Text;
                    assessmentDuration = gv.SelectedRow.Cells[3].Text;
                    assessmentType = gv.SelectedRow.Cells[4].Text;
                    assessmentVisibility = gv.SelectedRow.Cells[5].Text;
                    assessmentDates = gv.SelectedRow.Cells[6].Text + " - " + gv.SelectedRow.Cells[7].Text;
                }

                lblAID.Text = assessmentID;
                lblAName.Text = assessmentName;
                lblADuration.Text = assessmentDuration;
                lblAType.Text = assessmentType;
                lblAVisibility.Text = assessmentVisibility;
                lblADates.Text = assessmentDates;
            }
            if (lblAType.Text == "WRT")
            {
                (fvInsertQuestion.FindControl("txtQAnswer") as TextBox).Visible = false;
            }
            else
            {
                (fvInsertQuestion.FindControl("txtQAnswer") as TextBox).Visible = true;
            }
        }

        protected void InsertClearButton_Click(object sender, EventArgs e)
        {

        }

        public void fvInsertQuestion_InsertItem()
        {
            // Reference the FileUpload controls
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
                    (Page.FindControl("UploadWarning") as Label).Text = "Only JPG/JPEG documents allowed.";
                    (Page.FindControl("UploadWarning") as Label).Visible = true;
                    return;
                }
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

            string assessmentID = lblAID.Text;
            string questionName = (fvInsertQuestion.FindControl("txtQName") as TextBox).Text;
            string questionDesc = (fvInsertQuestion.FindControl("txtQDesc") as TextBox).Text;
            string questionAnswer = (fvInsertQuestion.FindControl("txtQAnswer") as TextBox).Text;
            SqlConnection con;
            SqlCommand cmd;
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            con = new SqlConnection(connStr);
            con.Open();
            cmd = new SqlCommand("INSERT INTO QUESTIONS VALUES (@assessmentID, @questionName, @questionDesc, @questionAnswer, @questionImage)", con);
            cmd.Parameters.AddWithValue("@assessmentID", assessmentID);
            cmd.Parameters.AddWithValue("@questionName", questionName);
            cmd.Parameters.AddWithValue("@questionDesc", questionDesc);
            cmd.Parameters.AddWithValue("@questionAnswer", questionAnswer);
            cmd.Parameters.AddWithValue("@questionImage", picturePath);
            cmd.ExecuteNonQuery();
        }

        protected void InsertButton_Click(object sender, EventArgs e)
        {

        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {

        }
    }
}