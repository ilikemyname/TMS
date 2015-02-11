using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Data.SqlClient;

namespace Assignment2_TMS.Utility
{
    public class Validation
    {
        internal static bool IsValidName(string s)
        {
            Regex pattern = new Regex(@"^[a-z]+$", RegexOptions.IgnoreCase);
            return pattern.Match(s).Success;
        }

        internal static bool IsValidEmail(string email)
        {
            Regex pattern = new Regex(@"^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$", RegexOptions.IgnoreCase);
            return pattern.Match(email).Success;
        }

        internal static bool IsDigit(string managerid)
        {
            Regex pattern = new Regex(@"^[0-9]+$", RegexOptions.IgnoreCase);
            return pattern.Match(managerid).Success;
        }

        internal static bool FindExistedId(int id)
        {
            SqlCommand command = new SqlCommand("SPCheckUserId", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add(new SqlParameter("@id", id));
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
            catch (Exception e)
            {
            }
            finally
            {
                command.Connection.Close();
            }
            if (found == 0)
            {
                return false;
            }
            else
            {
                return true;
            }

        }

        internal static bool CheckCyclicManagement(int myid, int managerid)
        {
            if (managerid == myid)
            {
                return true;
            }
            SqlConnection cnn = new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]);
            cnn.Open();
            SqlCommand command = new SqlCommand("SPRetrieveInfoByUserID", cnn);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add(new SqlParameter("@userid", managerid));

            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = command;

            DataSet ds = new DataSet();
            adapter.Fill(ds, "users");

            DataRow row = ds.Tables["users"].Rows[0];
            int myManagerId = Int32.Parse(row["managerid"].ToString());

            command.Dispose();
            adapter.Dispose();
            ds.Dispose();
            cnn.Close();

            if (myManagerId == myid)
            {
                return true;
            }
            return false;
        }

        internal static bool CheckExistedUsernameExceptMine(int userid, string username)
        {
            SqlCommand command = new SqlCommand("SPCheckOtherUsernameExceptMine", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
            command.Parameters.Add(new SqlParameter("@userid", userid));
            command.Parameters.Add(new SqlParameter("@username", username));
            command.CommandType = CommandType.StoredProcedure;
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
            catch (Exception e)
            {
            }
            finally
            {
                command.Connection.Close();
            }
            if (found == 0)
            {
                return false;
            }
            return true;
        }

        internal static bool CheckExistedEmailExceptMine(int id, string email)
        {
            SqlCommand command = new SqlCommand("SPCheckExistedEmailExceptMine", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
            command.Parameters.Add(new SqlParameter("@userid", id));
            command.Parameters.Add(new SqlParameter("@email", email));
            command.CommandType = CommandType.StoredProcedure;
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
                return false;
            }
            return true;
        }

        internal static bool IsValidProjectName(string name)
        {
            Regex pattern = new Regex(@"^[a-zA-Z+]+(\s[a-zA-Z+]+)*$", RegexOptions.IgnoreCase);
            return pattern.Match(name).Success;
        }

        internal static bool CheckThisProjectCodeAgainstOthers(int id, string code)
        {
            SqlCommand command = new SqlCommand("SPCheckExistedProjectCodeExceptCurrent", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
            command.Parameters.Add(new SqlParameter("@id", id));
            command.Parameters.Add(new SqlParameter("@projectCode", code));
            command.CommandType = CommandType.StoredProcedure;
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
                return false;
            }
            return true;
        }

        internal static bool CheckThisProjectNameAgainstOthers(int id, string name)
        {
            SqlCommand command = new SqlCommand("SPCheckExistedProjectNameExceptCurrent", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
            command.Parameters.Add(new SqlParameter("@id", id));
            command.Parameters.Add(new SqlParameter("@projectName", name));
            command.CommandType = CommandType.StoredProcedure;
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
                return false;
            }
            return true;
        }
    }
}
