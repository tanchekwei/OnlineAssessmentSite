using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Principal;
using System.Security.Claims;
using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.ModelBinding;
using System.Data.Entity;
using OnlineAssessmentSite.Models;
using System.Data;

namespace OnlineAssessmentSite.Student
{
    public partial class ViewAssessment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Roles.IsUserInRole("student"))
            {
                MembershipUser user = Membership.GetUser(User.Identity.Name);
                Guid guid = (Guid)user.ProviderUserKey;
                SqlDataSource1.SelectParameters["UserId"].DefaultValue = guid.ToString();
                SqlDataSource2.SelectParameters["UserId"].DefaultValue = guid.ToString();
                SqlDataSource3.SelectParameters["UserId"].DefaultValue = guid.ToString();
            }

            ////MembershipUser user = Membership.GetUser(User.Identity.Name);
            ////Guid guid = (Guid)user.ProviderUserKey;

            //string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            //SqlConnection con = new SqlConnection(strCon);

            //string strSelectPrivateCmd = "SELECT a.* " +
            //    "FROM Assessments a, Permissions p, Classes c, Enrollments e " +
            //    "WHERE a.assessmentID = p.assessmentID" +
            //    "   AND p.classID = c.classID" +
            //    "   AND c.classID = e.classID" +
            //    "   AND e.UserId = @UserId" +
            //    "   AND a.assessmentVisibility = @assessmentVisibility";

            ////string strSelectPublicCmd = "SELECT * " +
            ////    "FROM Assessments " +
            ////    "WHERE assessmentVisibility = @assessmentVisibility";

            //con.Open();
            //SqlCommand command = new SqlCommand(strSelectPrivateCmd, con);
            ////command.Parameters.Add(new SqlParameter("UserId", guid.ToString()));
            //command.Parameters.Add(new SqlParameter("assessmentVisibility", "Public"));

            //command.ExecuteNonQuery();

            //SqlDataAdapter adp = new SqlDataAdapter(command);
            //DataTable dt = new DataTable();
            //adp.Fill(dt);
            ////MessageBox.Show(dt.ToString());
            //DataList2.DataBind();
        }

        protected void DataList2_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if(e.CommandName == "Take")
            {
                String[] args = e.CommandArgument.ToString().Split(',');
                //Response.Write("<script language=javascript>alert('Assessment ID: [" + assessmentID + "]');</script>");

                if (int.Parse(args[1]) > 0)
                {
                    string url = "TakeAssessment.aspx?assessmentID=" + args[0];
                    Response.Redirect(url);
                }
                else
                {
                    Response.Write("<script language=javascript>alert('Sorry, you have no more attempt left.');</script>");
                }
            }
        }

        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if(e.CommandName == "Take")
            {
                String[] args = e.CommandArgument.ToString().Split(',');
                //Response.Write("<script language=javascript>alert('Assessment ID: [" + assessmentID + "]');</script>");

                if(int.Parse(args[1]) > 0)
                {
                    string url = "TakeAssessment.aspx?assessmentID=" + args[0];
                    Response.Redirect(url);
                } else
                {
                    Response.Write("<script language=javascript>alert('Sorry, you have no more attempt left.');</script>");
                }
            }

        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        //public IQueryable GridView1_GetData()
        //{
        //    MembershipUser user = Membership.GetUser(User.Identity.Name);
        //    Guid guid = (Guid)user.ProviderUserKey;

        //    string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        //    SqlConnection con = new SqlConnection(strCon);

        //    string strSelectCmd = "SELECT a.* " +
        //        "FROM Assessments a, Permissions p, Classes c, Enrollments e " +
        //        "WHERE a.assessmentID = p.assessmentID" +
        //        "   AND p.classID = c.classID" +
        //        "   AND c.classID = e.classID" +
        //        "   AND e.UserId = @UserId" +
        //        "   AND a.assessmentVisibility = @assessmentVisibility";

        //    con.Open();
        //    SqlCommand command = new SqlCommand(strSelectCmd, con);
        //    command.Parameters.Add(new SqlParameter("UserId", guid.ToString()));
        //    command.Parameters.Add(new SqlParameter("assessmentVisibility", "Private"));

        //    command.ExecuteNonQuery();

        //    SqlDataAdapter adp = new SqlDataAdapter(command);
        //    DataTable dt = new DataTable();
        //    adp.Fill(dt);
        //    //MessageBox.Show(dt.ToString());
        //    gvAssessment.DataSource = dt;

        //    return command.asqu;
        //}


    }
}