using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity;

namespace OnlineAssessmentSite.Lecturer
{
    public partial class MaintainPermission : System.Web.UI.Page
    {
        protected string assessmentID = "";
        protected string assessmentName = "";
        protected string assessmentDuration = "";
        protected string assessmentType = "";
        protected string assessmentVisibility = "";
        protected string assessmentDates = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Roles.IsUserInRole("lecturer") && !Roles.IsUserInRole("admin"))
            {
                return;
            }

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

                MembershipUser user = Membership.GetUser(User.Identity.Name);
                Guid guid = (Guid)user.ProviderUserKey;
                SqlDataSource1.SelectParameters["UserId"].DefaultValue = guid.ToString();
                SqlDataSource1.SelectParameters["assessmentID"].DefaultValue = assessmentID;

                SqlDataSource2.SelectParameters["UserId"].DefaultValue = guid.ToString();
            }
        }

        protected void btnAuthorise_Click(object sender, EventArgs e)
        {
            int classID = int.Parse(ddlClass.SelectedValue);
            int assessmentID = int.Parse(lblAID.Text);

            OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db
                = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();

            Models.Class classObj = new Models.Class { classID = classID };
            _db.Classes.Add(classObj);
            _db.Classes.Attach(classObj);

            Models.Assessment userObj = new Models.Assessment { assessmentID = assessmentID };
            _db.Assessments.Add(userObj);
            _db.Assessments.Attach(userObj);

            classObj.Assessments = new List<Models.Assessment>();
            classObj.Assessments.Add(userObj);

            try
            {
                _db.SaveChanges();
                DataList1.DataBind();
                Response.Write("<script language=javascript>alert('Authorized successfully.');" +
                    //"window.location.href = \"MaintainPermission.aspx\";" +
                    "</script>");
            }
            catch (System.Data.Entity.Infrastructure.DbUpdateException ex)
            {
                Response.Write("<script language=javascript>alert('Unable to authorized class. Maybe the class already authorized?');" +
                    //"window.location.href = \"maintainpermission.aspx\";" +
                    "</script>");
            }

            DataList1.DataBind();
        }

        protected void btnRemove_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db
                    = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();

                int classID = int.Parse(e.CommandArgument.ToString());
                int assessmentID = int.Parse(lblAID.Text);

                Models.Assessment assessment = _db.Assessments.Include(x => x.Classes).Single(x => x.assessmentID == assessmentID);

                _db.Assessments.Attach(assessment);
                Models.Class classToDelete = assessment.Classes.Single(x => x.classID == classID);
                if (classToDelete != null)
                {
                    assessment.Classes.Remove(classToDelete);
                    _db.SaveChanges();
                    DataList1.DataBind();
                    Response.Write("<script language=javascript>alert('Remove permission successfully.');</script>");
                }
                else
                {
                    Response.Write("<script language=javascript>alert('Failed to remove permission.');</script>");
                }


            }

        }
    }
}