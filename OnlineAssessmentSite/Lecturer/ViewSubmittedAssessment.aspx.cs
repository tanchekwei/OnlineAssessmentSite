using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineAssessmentSite.Lecturer
{
    public partial class MarkAssessment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblAssessmentName.Text = DropDownList1.SelectedItem.ToString();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Mark")
            {
                // items in args[]
                //  [0] = assessmentID
                //  [1] = attemptID
                //  [2] = UserId

                HttpCookie httpCookie = new HttpCookie("markAssessment");
                httpCookie["args"] = e.CommandArgument.ToString();
                //string[] args = e.CommandArgument.ToString().Split(',');
                Response.Cookies.Add(httpCookie);
                Response.Redirect("MarkAssessment.aspx");
                //Response.Write("<script>alert('" + args[0] + ", " + args[1] + ", " + args[2] + "');</script>");


            }
        }
    }
}