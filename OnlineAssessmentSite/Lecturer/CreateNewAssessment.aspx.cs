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
    public partial class CreateNewAssessment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void fvNewAssessment_InsertItem()
        {
            OnlineAssessmentSite.Models.Assessment item = new OnlineAssessmentSite.Models.Assessment();
            TryUpdateModel(item);
            if (ModelState.IsValid)
            {
                // Save changes here
                OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();
                _db.Assessments.Add(item);
                _db.SaveChanges();
            }

            if (Roles.IsUserInRole("lecturer") || Roles.IsUserInRole("admin"))
            {
                OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();

                var query = from a in _db.Assessments
                            orderby a.assessmentID descending
                            select a.assessmentID;

                int queryResult = 0;

                if (query.Any())
                {
                    queryResult = query.First();

                    MembershipUser user = Membership.GetUser(User.Identity.Name);
                    Guid guid = (Guid)user.ProviderUserKey;

                    Models.Assessment asmObj = new Models.Assessment { assessmentID = queryResult };
                    _db.Assessments.Add(asmObj);
                    _db.Assessments.Attach(asmObj);

                    Models.aspnet_Users userObj = new Models.aspnet_Users { UserId = guid };
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
                    }
                }
            }
        }
    }
}