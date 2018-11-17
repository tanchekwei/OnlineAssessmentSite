using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineAssessmentSite.Lecturer
{
    public partial class MaintainCollaboration : System.Web.UI.Page
    {
        protected string asmID = "";
        protected string asmName = "";

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
                    asmID = gv.SelectedRow.Cells[1].Text;
                    asmName = gv.SelectedRow.Cells[2].Text;
                }
                lblAID.Text = asmID;
                lblAName.Text = asmName;
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            lblErrorMsg.Text = "";

            OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db
                = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();

            string username = txtUserName.Text.ToString();
            username = username.ToLower();

            if (Roles.IsUserInRole(username, "lecturer"))
            {
                //Do nothing
            }
            else
            {
                lblErrorMsg.Text = "This user are not lecturer. Hence he/she is unable to collaborate in order to edit assessment.";
                return;
            }

            var query1 = from u in _db.aspnet_Users
                             where u.LoweredUserName == username
                             select u.UserId;

            if (query1.Any())
            {
            
                Guid userId = query1.First();

                SqlConnection con;
                SqlCommand cmd = new SqlCommand();
                SqlDataReader reader;
                string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                con = new SqlConnection(connStr);
                cmd.CommandText = "SELECT * " +
                    "FROM COLLABORATIONS " +
                    "WHERE assessmentID = @assessmentID " +
                    "AND userId = @userID";
                cmd.Parameters.AddWithValue("@assessmentID", lblAID.Text);
                cmd.Parameters.AddWithValue("@userID", userId.ToString());
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection = con;

                con.Open();
                reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    lblErrorMsg.Text = "Selected lecturer has already collaborate with this assessment.";
                }
                else
                {
                    int aID;
                    Int32.TryParse(lblAID.Text.ToString(), out aID);
                    Models.Assessment asmObj = new Models.Assessment { assessmentID = aID };
                    _db.Assessments.Add(asmObj);
                    _db.Assessments.Attach(asmObj);

                    Models.aspnet_Users userObj = new Models.aspnet_Users { UserId = userId };
                    _db.aspnet_Users.Add(userObj);
                    _db.aspnet_Users.Attach(userObj);

                    asmObj.aspnet_Users = new List<Models.aspnet_Users>();
                    asmObj.aspnet_Users.Add(userObj);

                    try
                    {
                        _db.SaveChanges();
                    }
                    catch (System.Data.Entity.Infrastructure.DbUpdateException ex)
                    {
                        lblErrorMsg.Text = "Save changes failed.";
                    }
                }
                con.Close();
            } else
            {
                lblErrorMsg.Text = "User doesn't existed.";
                return;
            }

            gvCollaborators.DataBind();
        }


        
    }
}