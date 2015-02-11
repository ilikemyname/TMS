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
using System.Data.SqlClient;

namespace Assignment2_TMS
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void submitbtt_Click(object sender, EventArgs e)
        {
            /*  */
            var connectionString = ConfigurationManager.AppSettings["ConnString"];
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();
            SqlCommand cmm = new SqlCommand("SPCheckAuthorizedUser", conn);
            cmm.Parameters.Add(new SqlParameter("@Username",uname.Text));
            cmm.Parameters.Add(new SqlParameter("@Password",pass.Text));
            cmm.CommandType = CommandType.StoredProcedure;
            cmm.Parameters.Add(new SqlParameter("Result", SqlDbType.Int, 4, ParameterDirection.ReturnValue, false, 0, 0, string.Empty, DataRowVersion.Default, null));
            cmm.CommandType = CommandType.StoredProcedure;
            cmm.ExecuteNonQuery();
            var userid = (int)cmm.Parameters["Result"].Value;
            cmm.Dispose();
            conn.Close();

            /*  */
            if (userid == 0)
            {
                loginfaillb.Text = "Login fail! Incorrect username/password";
                loginfaillb.Visible = true;
            }
            else 
            {
                conn.Open();
                cmm = new SqlCommand("SPRetrieveInfoByUserID", conn);
                cmm.Parameters.Add(new SqlParameter("@userId",userid));
                cmm.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = cmm;
                DataSet dataSet = new DataSet();
                adapter.Fill(dataSet, "users");
                cmm.Dispose();
                adapter.Dispose();
                conn.Close();
                DataRow userTableRow = dataSet.Tables["users"].Rows[0];

                /* */
                int id = Int32.Parse(userTableRow["id"].ToString());
                Session["userid"] = id;
                string username = (string)userTableRow["username"];
                Session["username"] = username;
                bool role = Convert.ToBoolean(userTableRow["isadmin"]);
                Session["role"] = role;
                dataSet.Dispose();
                
                //FormsAuthenticationTicket faTicket = new FormsAuthenticationTicket(
                //                                                                    1,userid.ToString(),
                //                                                                    DateTime.Now, DateTime.Now.AddHours(1),
                //                                                                    false, role,
                //                                                                    FormsAuthentication.FormsCookiePath);
                //HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName);
                //Response.Cookies.Add(cookie);
                if (role == true)
                {
                    Response.Redirect("/Administrator/ViewUsers.aspx");
                }
                else
                {
                    Response.Redirect("/Member/Profile.aspx");
                }
                //if (role.ToLower().Equals("admin"))
                //{
                //    Response.Redirect("/Administrator/ViewUsers.aspx");
                //}
                //else
                //{
                //    Response.Redirect("~/Member/setting.aspx");
                //}
            }

        }
    }
}
