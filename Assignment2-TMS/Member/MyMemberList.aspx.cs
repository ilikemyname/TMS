using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace Assignment2_TMS.Member
{
    public partial class MemberTimesheet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                userdb.SelectParameters["managerid"].DefaultValue = Session["userid"].ToString();
            }
            if (Convert.ToBoolean(Session["role"]) == false)
            {
                AdminPagesLink.Visible = false;
            }

        }
    }
}
