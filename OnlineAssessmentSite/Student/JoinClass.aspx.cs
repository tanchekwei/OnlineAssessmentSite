using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineAssessmentSite.Student
{
    public partial class JoinClass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnJoin_Click(object sender, EventArgs e)
        {
            // find classId using classCode
            OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db
                = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();

            var query = from c in _db.Classes
                        where c.classCode == txtClassCode.Text
                        select c.classID;

            int queryResult = 0;

            if (query.Any())
            {
                queryResult = query.Single();

                MembershipUser user = Membership.GetUser(User.Identity.Name);
                Guid guid = (Guid)user.ProviderUserKey;

                Models.Class classObj = new Models.Class { classID = queryResult };
                _db.Classes.Add(classObj);
                _db.Classes.Attach(classObj);

                Models.aspnet_Users userObj = new Models.aspnet_Users { UserId = guid };
                _db.aspnet_Users.Add(userObj);
                _db.aspnet_Users.Attach(userObj);

                classObj.aspnet_Users1 = new List<Models.aspnet_Users>();
                classObj.aspnet_Users1.Add(userObj);

                try
                {
                    _db.SaveChanges();
                    Response.Write("<script language=javascript>alert('Joined class successfully.\\n" +
                        "You are now allowed to take private assessment from the class you joined.');" +
                        "window.location.href = \"JoinClass.aspx\";</script>");
                }
                catch (System.Data.Entity.Infrastructure.DbUpdateException ex)
                {
                    Response.Write("<script language=javascript>alert('You already in the class.');" +
                        "window.location.href = \"JoinClass.aspx\";</script>");
                }
            }
            else
            {
                Response.Write("<script language=javascript>alert('Opps! Wrong class code.');</script>");
            }

            //if (query != 0)
            //{
            //    MembershipUser user = Membership.GetUser(User.Identity.Name);
            //    Guid guid = (Guid)user.ProviderUserKey;

            //    using (var context = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities())
            //    {
            //        var classObj = new Models.Class { classID = query };
            //        classObj.aspnet_Users1.Add(new Models.aspnet_Users { UserId = guid });
            //        //TryUpdateModel(classObj);

            //        Debug.WriteLine("classID: " + query);
            //        Debug.WriteLine("");

            //        if (ModelState.IsValid)
            //        {
            //            // Save changes here
            //            _db.SaveChanges();


            //        }


            //    }
            //}

            //Models.Class classObj = new Models.Class();

            ////get current entry from db (db is context)
            //var item = _db.Entry<Models.Class>(classObj);

            ////change item state to modified
            //item.State = System.Data.Entity.EntityState.Modified;

            ////load existing items for ManyToMany collection
            //item.Collection(i => i.aspnet_Users1).Load();

            //////clear Student items          
            ////classObj.aspnet_Users1.Clear();

            ////add Toner items
            ////foreach (var studentId in classObj)
            ////{
            //var student = _db.Student.Find(int.Parse(studentId));
            //classObj.aspnet_Users1.Add(student);
            ////}

            //if (ModelState.IsValid)
            //{
            //    db.SaveChanges();
            //    return RedirectToAction("Index");
            //}

            //return View(mathClassModel);




        }
    }
}