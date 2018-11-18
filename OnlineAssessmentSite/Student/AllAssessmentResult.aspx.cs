using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineAssessmentSite.Student
{
    public partial class AllAssessmentResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole("student"))
            {
                MembershipUser user = Membership.GetUser(User.Identity.Name);
                Guid guid = (Guid)user.ProviderUserKey;

                SqlDataSource1.SelectParameters["UserId"].DefaultValue = guid.ToString();
                SqlDataSource2.SelectParameters["UserId"].DefaultValue = guid.ToString();
            }
        }
    }
}