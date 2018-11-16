using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
        }

        protected void GridViewAssessment_SelectedIndexChanged(object sender, EventArgs e)
        {
            panelSelectedAssessment.Visible = true;
            lblSelectedAssessment.Text = GridViewAsm.SelectedRow.Cells[2].Text;
        }
    }
}