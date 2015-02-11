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

namespace Assignment2_TMS.Administrator
{
    public partial class AddUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //protected void Unametb_Changed(object sender, EventArgs e)
        //{
        //    var connectionString = ConfigurationSettings.AppSettings["ConnString"];
        //    SqlConnection cnn = new SqlConnection(connectionString);
        //    cnn.Open();
        //    SqlCommand command = new SqlCommand("SPCheckUsername", cnn);
        //    command.Parameters.Add(new SqlParameter("@username", Unametb.Text));
        //    command.CommandType = CommandType.StoredProcedure;
        //    SqlParameter valueRetrieved = new SqlParameter("valueRetrieved", SqlDbType.Int);
        //    valueRetrieved.Direction = ParameterDirection.ReturnValue;
        //    command.Parameters.Add(valueRetrieved);
        //    command.ExecuteNonQuery();
        //    int id = Int32.Parse(valueRetrieved.Value.ToString());
        //    command.Dispose();
        //    cnn.Close();
        //    if (id != 0)
        //    {
        //        UserAvailability.InnerText = "Username taken, sorry.";
        //        UserAvailability.Attributes.Add("class", "taken");
        //        AddButton.Enabled = false;
        //    }
        //    else
        //    {
        //        UserAvailability.InnerText = "Username available!";
        //        UserAvailability.Attributes.Add("class", "available");
        //        AddButton.Enabled = true;
        //    }
        //}

        protected void AddButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (!CheckDuplicatedUsernameAndEmail(Unametb.Text, emailtb.Text))
                {
                    WarningLabel.Text = "New user " + Unametb.Text + " is added to the database.";
                    WarningLabel.Visible = true;
                    //Console.WriteLine(ManagerDropDownList.Text);
                    //Console.WriteLine(RoleDropDownList.Text);
                    InsertNewUser(Unametb.Text, passtb.Text, fnametb.Text, mnametb.Text,
                        lnametb.Text, emailtb.Text, ManagerDropDownList.Text);
                    //System.Threading.Thread.Sleep(5000);
                    //Response.Redirect("ViewUsers.aspx");
                }
            }
        }

        protected bool CheckDuplicatedUsernameAndEmail(String username, String email)
        {
            string warning = "";
            SqlCommand command = new SqlCommand("SPCheckUsername", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add(new SqlParameter("@username", username));
            SqlParameter valueReturned = new SqlParameter("valueReturned", SqlDbType.Int);
            valueReturned.Direction = ParameterDirection.ReturnValue;
            command.Parameters.Add(valueReturned);
            int found = 0;
            try
            {
                command.Connection.Open();
                command.ExecuteNonQuery();
                found = Int32.Parse(valueReturned.Value.ToString());
            }
            catch (Exception)
            {
            }
            finally
            {
                command.Connection.Close();
            }
            if (found == 0)
            {
                command = new SqlCommand("SPCheckEmail", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@email", email));
                valueReturned = new SqlParameter("valueReturned", SqlDbType.Int);
                valueReturned.Direction = ParameterDirection.ReturnValue;
                command.Parameters.Add(valueReturned);
                command.Connection.Open();
                command.ExecuteNonQuery();
                found = Int32.Parse(valueReturned.Value.ToString());
                command.Connection.Close();
            }
            else
            {
                warning = "Username " + username + " had taken by other user.";
            }

            if (warning != "")
            {
                WarningLabel.Text = warning;
                WarningLabel.Visible = true;
                return true;
            }

            if (found != 0)
            {
                warning = "Email " + email + " had taken by other user.";
                WarningLabel.Text = warning;
                WarningLabel.Visible = true;
                return true;
            }

            return false;
        }

        //protected int QueryDuplicatedUser(String username, String email)
        //{
        //    var connectionString = ConfigurationSettings.AppSettings["ConnString"];
        //    SqlConnection cnn = new SqlConnection(connectionString);
        //    cnn.Open();
        //    SqlCommand command = new SqlCommand("SPFindUsernameOrEmail", cnn);
        //    command.Parameters.Add(new SqlParameter("@username", username));
        //    command.Parameters.Add(new SqlParameter("@email", email));
        //    command.CommandType = CommandType.StoredProcedure;
        //    SqlParameter result = new SqlParameter("result", SqlDbType.Int);
        //    result.Direction = ParameterDirection.ReturnValue;
        //    command.Parameters.Add(result);
        //    command.ExecuteNonQuery();
        //    int i = Int32.Parse(result.Value.ToString());
        //    command.Dispose();
        //    cnn.Close();
        //    return i;
        //}

        protected void InsertNewUser(String username, String password, String firstname, String middlename, String lastname, String email, String managerid)
        {
            var connectionString = ConfigurationSettings.AppSettings["ConnString"];
            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlCommand command = new SqlCommand("SPInsertNewUser", cnn);
            command.Parameters.Add(new SqlParameter("@username", username));
            command.Parameters.Add(new SqlParameter("@password", password));
            command.Parameters.Add(new SqlParameter("@firstname", firstname));
            command.Parameters.Add(new SqlParameter("@middlename", middlename));
            command.Parameters.Add(new SqlParameter("@lastname", lastname));
            command.Parameters.Add(new SqlParameter("@email", email));
            command.Parameters.Add(new SqlParameter("@managerid", managerid));
            //command.Parameters.Add(new SqlParameter("@role", role));
            command.CommandType = CommandType.StoredProcedure;
            command.ExecuteNonQuery();
            command.Dispose();
            cnn.Close();
        }

        //protected void Unametb_TextChanged(object sender, EventArgs e)
        //{
        //    var connectionString = ConfigurationSettings.AppSettings["ConnString"];
        //    SqlConnection cnn = new SqlConnection(connectionString);
        //    cnn.Open();
        //    SqlCommand command = new SqlCommand("SPCheckUsername", cnn);
        //    command.Parameters.Add(new SqlParameter("@username", Unametb.Text));
        //    command.CommandType = CommandType.StoredProcedure;
        //    SqlParameter valueRetrieved = new SqlParameter("valueRetrieved", SqlDbType.Int);
        //    valueRetrieved.Direction = ParameterDirection.ReturnValue;
        //    command.Parameters.Add(valueRetrieved);
        //    command.ExecuteNonQuery();
        //    int id = Int32.Parse(valueRetrieved.Value.ToString());
        //    command.Dispose();
        //    cnn.Close();
        //    if (id != 0)
        //    {
        //        UserAvailability.InnerText = "Username taken, sorry.";
        //        UserAvailability.Attributes.Add("class", "taken");
        //        AddButton.Enabled = false;
        //    }
        //    else
        //    {
        //        UserAvailability.InnerText = "Username available!";
        //        UserAvailability.Attributes.Add("class", "available");
        //        AddButton.Enabled = true;
        //    }
        //}

    }
}
