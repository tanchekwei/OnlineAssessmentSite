using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity;

namespace OnlineAssessmentSite.Lecturer
{
    public partial class MaintainClass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Debug.WriteLine("Roles.IsUserInRole(lecturer) = " + Roles.IsUserInRole("lecturer"));
            //Debug.WriteLine("Roles.IsUserInRole(student) = " + Roles.IsUserInRole("student"));
            //Debug.WriteLine("Roles.IsUserInRole(admin) = " + Roles.IsUserInRole("admin"));

            if (Roles.IsUserInRole("lecturer") || Roles.IsUserInRole("admin"))
            {
                MembershipUser user = Membership.GetUser(User.Identity.Name);
                Guid guid = (Guid)user.ProviderUserKey;
                SqlDataSource1.SelectParameters["UserId"].DefaultValue = guid.ToString();
            }
            else
            {
                Response.Write("<script language=javascript>alert('Don\\'t force yourself to fit in where you don\\'t belong.');" +
                    "window.location.href = \"../Login.aspx\";</script>");
            }
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteStud")
            {
                OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db
                    = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();

                Guid UserId = new Guid(e.CommandArgument.ToString());
                int classID = int.Parse(GridView1.SelectedRow.Cells[1].Text);
                //Response.Write("<script language=javascript>alert('classID: [" + classID + "]\\nUserID: [" + UserId + "]');</script>");

                Models.Class @class = _db.Classes.Include(x => x.aspnet_Users1).Single(x => x.classID == classID);
                _db.Classes.Attach(@class);
                Models.aspnet_Users classToDelete = @class.aspnet_Users1.First(x => x.UserId == UserId);
                if (classToDelete != null)
                {
                    @class.aspnet_Users1.Remove(classToDelete);
                    _db.SaveChanges();
                    GridView2.DataBind();
                    Response.Write("<script language=javascript>alert('Remove student successfully.');</script>");
                }
                else
                {
                    Response.Write("<script language=javascript>alert('Failed to remove student.');</script>");
                }

                //Models.aspnet_Users aspnet_Users = _db.aspnet_Users.Include(x => x.Classes).Single(x => x.UserId == UserId);
                //_db.aspnet_Users.Attach(aspnet_Users);
                //Models.Class classToDelete = aspnet_Users.Classes.First(x => x.classID == classID);
                //if (classToDelete != null)
                //{
                //    aspnet_Users.Classes.Remove(classToDelete);
                //    _db.SaveChanges();
                //    GridView2.DataBind();
                //    Response.Write("<script language=javascript>alert('Remove student successfully.');</script>");
                //}
                //else
                //{
                //    Response.Write("<script language=javascript>alert('Failed to remove student.');</script>");
                //}

                //Response.Write("<script language=javascript>alert('" + test + "');</script>");


            }

        }


        //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    if (e.CommandName == "Add Student")
        //    {
        //        HttpCookie cookie = new HttpCookie("AddStudent");

        //        // Convert the row index stored in the CommandArgument
        //        // property to an Integer.
        //        int index = Convert.ToInt32(e.CommandArgument);
        //        GridViewRow selectedRow = GridView1.Rows[index];

        //        cookie["classID"] = selectedRow.Cells[2].Text;
        //        cookie["className"] = selectedRow.Cells[4].Text;
        //        Response.Write(selectedRow.Cells[2].Text);
        //        // Add it to the current web response.
        //        Response.Cookies.Add(cookie);
        //        Response.Redirect("/Lecturer/AddStudentToClass.aspx");
        //    }
        //}
    }
}