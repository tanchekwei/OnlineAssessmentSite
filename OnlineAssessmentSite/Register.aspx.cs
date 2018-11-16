using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineAssessmentSite
{
    public partial class Register : System.Web.UI.Page
    {
        public MembershipUserCollection MembershipUserCollection { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
        {
            TextBox Name = (TextBox)CreateUserWizardStep.ContentTemplateContainer.FindControl("txtName");
            Calendar Dob = (Calendar)CreateUserWizardStep.ContentTemplateContainer.FindControl("calDob");
            RadioButtonList Role = (RadioButtonList)CreateUserWizardStep.ContentTemplateContainer.FindControl("rbtnRole");

            MembershipUser user = Membership.GetUser(CreateUserWizard1.UserName.ToString());
            Guid guid = (Guid)user.ProviderUserKey;

            //Response.Write("Name: " + Name.Text +
            //    "</br>Dob: " + Dob.SelectedDate +
            //    "</br>Role: " + Role.Text +
            //    "</br>UserId: " + guid.ToString());

            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            string cmdString = "INSERT INTO UserProfiles (UserId, Name, Dob) VALUES (@UserId, @Name, @Dob)";
            using (SqlConnection conn = new SqlConnection(strCon))
            {
                using (SqlCommand comm = new SqlCommand())
                {
                    comm.Connection = conn;
                    comm.CommandText = cmdString;
                    comm.Parameters.AddWithValue("@UserId", guid.ToString());
                    comm.Parameters.AddWithValue("@Name", Name.Text);
                    comm.Parameters.AddWithValue("@Dob", Dob.SelectedDate);
                    try
                    {
                        conn.Open();
                        comm.ExecuteNonQuery();
                    }
                    catch(SqlException sqlE)
                    {
                        Response.Write("Error when inserting UserProfiles " + sqlE.ToString());
                        // do something with the exception
                        // don't hide it
                    }
                }
            }

            if (Role.Text == "student")
            {
                Roles.AddUserToRole(CreateUserWizard1.UserName.ToString(), "student");
            } else
            {
                Roles.AddUserToRole(CreateUserWizard1.UserName.ToString(), "lecturer");

            }

        }
    }
}