using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineAssessmentSite.Lecturer
{
    public partial class MaintainAssessment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                panelSelectedAssessment.Visible = false;
            }

            MembershipUser user = Membership.GetUser(User.Identity.Name);
            Guid guid = (Guid)user.ProviderUserKey;
            DataSrcAssessmentDetails.SelectParameters["UserId"].DefaultValue = guid.ToString();
        }

        protected void GridViewAssessment_SelectedIndexChanged(object sender, EventArgs e)
        {
            panelSelectedAssessment.Visible = true;
            lblSelectedAssessment.Text = GridViewAsm.SelectedRow.Cells[2].Text;
            string visibility = GridViewAsm.SelectedRow.Cells[5].Text;
            if (visibility.Trim().Equals("Public"))
            {
                btnPermission.Visible = false;
            }
            else
            {
                btnPermission.Visible = true;
            }

            this.Session["asmID"] = GridViewAsm.SelectedRow.Cells[1].Text;
            this.Session["asmName"] = GridViewAsm.SelectedRow.Cells[2].Text;
            this.Session["asmDuration"] = GridViewAsm.SelectedRow.Cells[3].Text;
            this.Session["asmType"] = GridViewAsm.SelectedRow.Cells[4].Text;
            this.Session["asmVisibility"] = GridViewAsm.SelectedRow.Cells[5].Text;
            this.Session["asmDates"] = GridViewAsm.SelectedRow.Cells[6].Text + " - " + GridViewAsm.SelectedRow.Cells[7].Text;
        }
    }
}