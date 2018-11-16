using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineAssessmentSite.Lecturer
{
    public partial class CreateClass : System.Web.UI.Page
    {
        Random rand = new Random();

        public const string Alphabet =
        "abcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void fvClass_InsertItem()
        {
            Models.Class item = new Models.Class();

            MembershipUser user = Membership.GetUser(User.Identity.Name);
            Guid guid = (Guid)user.ProviderUserKey;

            item.UserId = guid;

            TryUpdateModel(item);
            if (ModelState.IsValid)
            {
                // Save changes here
                OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db
                    = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();

                item.classCode = GenerateString(8);

                _db.Classes.Add(item);
                _db.SaveChanges();

                Response.Write("<script language=javascript>alert('Class created! " +
                    "\\n(Class Code: " + item.classCode + ") " +
                    "\\nShare class code to your students for them to join.');" +
                    "window.location.href = \"MaintainClass.aspx\";</script>");
                //Response.Redirect("/Lecturer/MaintainClass.aspx");
            }
        }

        public string GenerateString(int size)
        {
            char[] chars = new char[size];
            for (int i = 0; i < size; i++)
            {
                chars[i] = Alphabet[rand.Next(Alphabet.Length)];
            }
            return new string(chars);
        }
    }
}