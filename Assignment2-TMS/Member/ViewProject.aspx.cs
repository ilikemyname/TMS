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
using System.Collections.Specialized;

namespace Assignment2_TMS.Member
{
    public partial class ViewProject : System.Web.UI.Page
    {
        DateTime startingWeekDT, endingWeekDT;
        string sdate, edate;
        int[] workinghours = new int[7];
        StringDictionary arrDate = new StringDictionary();
        string currenttimesheetstatus = "";
        int projectid;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }
            if (Convert.ToBoolean(Session["role"]) == false)
            {
                AdminPagesLink.Visible = false;
            }
            var userid = Session["userid"].ToString();
            projectid = Int32.Parse(Request.QueryString["projectid"]);
            if (CheckValidManagerIdWithProjectId(Int32.Parse(userid), projectid))
            {
                //var userid = Session["userid"].ToString();
                //mymemberid = Int32.Parse(Request.QueryString["memberID"]);
                timesheetdb.SelectParameters[0].DefaultValue = Convert.ToString(projectid);
                if (StartingWeekTextBox.Text != "")
                {
                    string startingDate = StartingWeekTextBox.Text;
                    try
                    {
                        GetCurrentWeekDay(DateTime.Parse(startingDate));
                    }
                    catch (FormatException)
                    {
                        GetCurrentWeekDay(DateTime.Now);
                        StartingWeekTextBox.Text = startingWeekDT.ToShortDateString();
                    }
                }
                else
                {
                    GetCurrentWeekDay(DateTime.Now);
                    StartingWeekTextBox.Text = startingWeekDT.ToShortDateString();
                }
                sdate = startingWeekDT.ToShortDateString();
                edate = endingWeekDT.ToShortDateString();
                timesheetdb.SelectParameters[1].DefaultValue = sdate;
                timesheetdb.SelectParameters[2].DefaultValue = edate;
                DisplayTimesheetCurrentStatus();
            }
            else
            {
                Response.Redirect("Project.aspx");
            }
        }

        private bool CheckValidManagerIdWithProjectId(int managerid, int projectid)
        {
            SqlCommand command = new SqlCommand("SPCheckValidManagerIdProjectId", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
            command.Parameters.Add(new SqlParameter("@managerid", managerid));
            command.Parameters.Add(new SqlParameter("@projectid", projectid));
            command.CommandType = CommandType.StoredProcedure;
            SqlParameter valueReturned = new SqlParameter("valueReturned", SqlDbType.Int);
            valueReturned.Direction = ParameterDirection.ReturnValue;
            command.Parameters.Add(valueReturned);
            int size = 0;
            try
            {
                command.Connection.Open();
                command.ExecuteNonQuery();
                size = Int32.Parse(valueReturned.Value.ToString());
            }
            catch (Exception)
            {
            }
            finally
            {
                command.Connection.Close();
            }
            if (size == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        private void DisplayTimesheetCurrentStatus()
        {
            CurrentStatusLabel.Visible = false;
            SqlCommand command = new SqlCommand("SPRetrieveTimesheetById", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
            command.Parameters.Add(new SqlParameter("@id", Int32.Parse(Session["userid"].ToString())));
            command.Parameters.Add(new SqlParameter("@startingweek", startingWeekDT));
            command.Parameters.Add(new SqlParameter("@endingweek", endingWeekDT));
            command.CommandType = CommandType.StoredProcedure;
            try
            {
                command.Connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                    currenttimesheetstatus = CurrentStatusLabel.Text = reader.GetString(14);
            }
            catch (Exception)
            {
            }
            finally
            {
                command.Connection.Close();
            }
            CurrentStatusLabel.Visible = true;
        }

        private void GetCurrentWeekDay(DateTime currentDT)
        {
            startingWeekDT = currentDT.AddDays(1 - Convert.ToDouble(currentDT.DayOfWeek));
            endingWeekDT = currentDT.AddDays(7 - Convert.ToDouble(currentDT.DayOfWeek));
            arrDate.Add("MON", startingWeekDT.ToString("ddd dd"));
            arrDate.Add("TUE", currentDT.AddDays(2 - Convert.ToDouble(currentDT.DayOfWeek)).ToString("ddd dd"));
            arrDate.Add("WED", currentDT.AddDays(3 - Convert.ToDouble(currentDT.DayOfWeek)).ToString("ddd dd"));
            arrDate.Add("THU", currentDT.AddDays(4 - Convert.ToDouble(currentDT.DayOfWeek)).ToString("ddd dd"));
            arrDate.Add("FRI", currentDT.AddDays(5 - Convert.ToDouble(currentDT.DayOfWeek)).ToString("ddd dd"));
            arrDate.Add("SAT", currentDT.AddDays(6 - Convert.ToDouble(currentDT.DayOfWeek)).ToString("ddd dd"));
            arrDate.Add("SUN", currentDT.AddDays(7 - Convert.ToDouble(currentDT.DayOfWeek)).ToString("ddd dd"));
        }

        protected void StartingWeekTextBox_TextChanged(object sender, EventArgs e)
        {
            UpdateTimesheetGridView(sender, e);
            DisplayTimesheetCurrentStatus();
        }

        protected void UpdateTimesheetGridView(object sender, EventArgs e)
        {
            timesheetdb.SelectParameters[1].DefaultValue = sdate;
            timesheetdb.SelectParameters[2].DefaultValue = edate;
            TimesheetGridView.DataBind();
            DisplayTimesheetCurrentStatus();
            TimesheetUpdatePanel.Update();
        }

        protected void SumHourOfSameDay(object sender, GridViewRowEventArgs e)
        {
            if (DataControlRowType.DataRow == e.Row.RowType)
            {
                workinghours[0] += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "monday"));
                workinghours[1] += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "tuesday"));
                workinghours[2] += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "wednesday"));
                workinghours[3] += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "thursday"));
                workinghours[4] += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "friday"));
                workinghours[5] += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "saturday"));
                workinghours[6] += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "sunday"));
            }

            //workinghours[0] += Int32.Parse(DataBinder.Eval(e.Row.DataItem, "Mon").ToString());
            //workinghours[1] += Int32.Parse(DataBinder.Eval(e.Row.DataItem, "Tue").ToString());
            //workinghours[2] += Int32.Parse(DataBinder.Eval(e.Row.DataItem, "Wed").ToString());
            //workinghours[3] += Int32.Parse(DataBinder.Eval(e.Row.DataItem, "Thu").ToString());
            //workinghours[4] += Int32.Parse(DataBinder.Eval(e.Row.DataItem, "Fri").ToString());
            //workinghours[5] += Int32.Parse(DataBinder.Eval(e.Row.DataItem, "Sat").ToString());
            //workinghours[6] += Int32.Parse(DataBinder.Eval(e.Row.DataItem, "Sun").ToString());
        }

        public string GetHeader(string day)
        {
            return arrDate[day];
        }

        public int GetTotal(int d)
        {
            return workinghours[d];
        }

        public int GetTotalWorkingHoursWeek()
        {
            int total = 0;
            for (int i = 0; i < workinghours.Length; i++)
            {
                total += workinghours[i];
            }
            return total;
        }
    }
}
