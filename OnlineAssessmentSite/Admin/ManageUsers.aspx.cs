using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineAssessmentSite.Admin
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void GridView1_DeleteItem(string UserName)
        {
            if(Membership.DeleteUser(UserName, true))
            {
                Response.Write(UserName + " deleted successfully");
            } else
            {
                Response.Write("Failed to delete"  + UserName);

            }
        }

        public IQueryable GridView1_GetData()
        {
            return Membership.GetAllUsers().Cast<MembershipUser>().AsQueryable<MembershipUser>();
        }
    }
}