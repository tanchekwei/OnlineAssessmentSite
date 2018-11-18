using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineAssessmentSite.Lecturer
{
    public partial class MarkAssessment1 : System.Web.UI.Page
    {
        OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities _db
            = new OnlineAssessmentSite.Models.OnlineAssessmentSiteEntities();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // items in args[]
                //  [0] = assessmentID
                //  [1] = attemptID
                //  [2] = UserId

                HttpCookie httpCookie = Request.Cookies["markAssessment"];
                string[] args = httpCookie["args"].Split(',');

                // Display 


            }
        }
    }
}