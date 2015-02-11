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
    public partial class AddProject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddProjectButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (!FindThisProject(CodeTextBox.Text, NameTextBox.Text))
                {
                    WarningLabel.Visible = false;
                    InsertNewProject(CodeTextBox.Text, NameTextBox.Text, ManagerDropDownList.Text);
                    MessageLabel.Text = "A new project has created on the database.";
                    MessageLabel.Visible = true;
                }
            }
        }

        private bool FindThisProject(String projectCode, String projectName)
        {
            string warning = "";
            SqlCommand command = new SqlCommand("SPCheckCode", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add(new SqlParameter("@projectCode", projectCode));
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
                command = new SqlCommand("SPCheckProjectName", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@projectName", projectName));
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
                warning = "Project Code " + projectCode + " has existed already in the database.";
            }

            if (warning != "")
            {
                WarningLabel.Text = warning;
                WarningLabel.Visible = true;
                MessageLabel.Visible = false;
                return true;
            }

            if (found != 0)
            {
                warning = "Project Name " + projectName + " has existed already in the database.";
                WarningLabel.Text = warning;
                WarningLabel.Visible = true;
                MessageLabel.Visible = false;
                return true;
            }

            return false;
        }

        private void InsertNewProject(string projectCode, string projectName, string manager)
        {
            var connectionString = ConfigurationSettings.AppSettings["ConnString"];
            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlCommand command = new SqlCommand("SPInsertNewProject", cnn);
            command.Parameters.Add(new SqlParameter("@projectCode", projectCode));
            command.Parameters.Add(new SqlParameter("@projectName", projectName));
            command.Parameters.Add(new SqlParameter("@manager", manager));
            command.CommandType = CommandType.StoredProcedure;
            command.ExecuteNonQuery();
            command.Dispose();
            cnn.Close();
        }
    }
}
