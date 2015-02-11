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
    public partial class Timesheet1 : System.Web.UI.Page
    {
        DateTime startingWeekDT, endingWeekDT;
        string sdate, edate;
        int[] workinghours = new int[7];
        StringDictionary arrDate = new StringDictionary();

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
            timesheetdb.SelectParameters[0].DefaultValue = userid;
            if (StartingWeekTextBox.Text != "")
            {
                string startingDate = StartingWeekTextBox.Text;
                try
                {
                    GetCurrentWeekDay(DateTime.Parse(startingDate));
                }
                catch (FormatException fe)
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
            RetrieveAllProjectsOnPopupPanel();
        }

        private void RetrieveAllProjectsOnPopupPanel()
        {
            projectList.Items.Clear();
            SqlCommand command = new SqlCommand("SPRetrieveProjects", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
            command.CommandType = CommandType.StoredProcedure;
            command.Connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                projectList.DataSource = reader;
                projectList.DataValueField = "id";
                projectList.DataTextField = "projectname";
                projectList.DataBind();
            }
            command.Connection.Close();
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
                    CurrentStatusLabel.Text = reader.GetString(14);
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

        protected void deleteButton_Click(object sender, EventArgs e)
        {
            string status = GetTimeSheetStatusById(Int32.Parse(Session["userid"].ToString()));
            if (status.Equals("Approved") || status.Equals("Submitted"))
            {
                SaveStatusLabel.Text = "You cannot do on this timesheet since approved!";
                SaveStatusLabel.Visible = true;
            }
            else
            {
                for (int i = 0; i < TimesheetGridView.Rows.Count; i++)
                {
                    var row = TimesheetGridView.Rows[i];
                    CheckBox checkbox = (CheckBox)row.Cells[0].FindControl("CheckBox");

                    if (checkbox.Checked)
                    {
                        timesheetdb.DeleteParameters["id"].DefaultValue = row.Cells[1].Text;
                        timesheetdb.Delete();
                    }
                }
            }
            UpdateTimesheetGridView(sender, e);
        }

        protected void saveButton_Click(object sender, EventArgs e)
        {
            string status = GetTimeSheetStatusById(Int32.Parse(Session["userid"].ToString()));
            if (status.Equals("Approved") || status.Equals("Submitted"))
            {
                SaveStatusLabel.Text = "You cannot do on this timesheet since approved!";
                SaveStatusLabel.Visible = true;
            }
            else
            {
                for (int i = 0; i < TimesheetGridView.Rows.Count; i++)
                {
                    var row = TimesheetGridView.Rows[i];
                    timesheetdb.UpdateParameters[0].DefaultValue = row.Cells[1].Text;
                    timesheetdb.UpdateParameters[1].DefaultValue = sdate;
                    timesheetdb.UpdateParameters[2].DefaultValue = edate;
                    timesheetdb.UpdateParameters[3].DefaultValue = ((TextBox)row.Cells[4].FindControl("MonTextBox")).Text;
                    timesheetdb.UpdateParameters[4].DefaultValue = ((TextBox)row.Cells[5].FindControl("TueTextBox")).Text;
                    timesheetdb.UpdateParameters[5].DefaultValue = ((TextBox)row.Cells[6].FindControl("WedTextBox")).Text;
                    timesheetdb.UpdateParameters[6].DefaultValue = ((TextBox)row.Cells[7].FindControl("ThuTextBox")).Text;
                    timesheetdb.UpdateParameters[7].DefaultValue = ((TextBox)row.Cells[8].FindControl("FriTextBox")).Text;
                    timesheetdb.UpdateParameters[8].DefaultValue = ((TextBox)row.Cells[9].FindControl("SatTextBox")).Text;
                    timesheetdb.UpdateParameters[9].DefaultValue = ((TextBox)row.Cells[10].FindControl("SunTextBox")).Text;

                    timesheetdb.Update();
                }
            }
            UpdateTimesheetGridView(sender, e);
        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < TimesheetGridView.Rows.Count; i++)
            {
                var row = TimesheetGridView.Rows[i];

                SqlCommand command = new SqlCommand("SPUpdateTimesheetStatusById", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
                command.Parameters.Add(new SqlParameter("@id", row.Cells[1].Text));
                command.Parameters.Add(new SqlParameter("@startingweek", startingWeekDT));
                command.Parameters.Add(new SqlParameter("@endingweek", endingWeekDT));
                command.Parameters.Add(new SqlParameter("@status", "Submitted"));
                command.CommandType = CommandType.StoredProcedure;
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }
            UpdateTimesheetGridView(sender, e);
        }

        protected void AddButton_Click(object sender, EventArgs e)
        {
            string status = GetTimeSheetStatusById(Int32.Parse(Session["userid"].ToString()));
            if (status.Equals("Approved") || status.Equals("Submitted"))
            {
                SaveStatusLabel.Text = "You cannot do on this timesheet since approved!";
                SaveStatusLabel.Visible = true;
            }
            if (TaskTextbox.Text != "")
            {
                if (ValidateTaskData(projectList.SelectedItem.Text, TaskTextbox.Text))
                {
                    AddTaskToTimesheet(projectList.SelectedItem.Text, TaskTextbox.Text, Int32.Parse(projectList.SelectedValue));
                    TaskMessageLabel.ForeColor = System.Drawing.Color.Green;
                    TaskMessageLabel.Text = "Added Task!";
                    TaskMessageLabel.Visible = true;
                }
                else
                {
                    TaskMessageLabel.ForeColor = System.Drawing.Color.Red;
                    TaskMessageLabel.Text = "Cannot add task is duplicated!";
                    TaskMessageLabel.Visible = true;
                }
                CurrentStatusLabel.Visible = false;
                TaskTextbox.Text = "";
                UpdateTimesheetGridView(sender, e);
            }
        }

        private void AddTaskToTimesheet(string projectname, string taskname, int projectid)
        {
            SqlCommand cmd = new SqlCommand("SPInsertTask", new SqlConnection(ConfigurationManager.AppSettings["ConnString"]));
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@projectname", projectname));
            cmd.Parameters.Add(new SqlParameter("@task", taskname));
            cmd.Parameters.Add(new SqlParameter("@startingweek", sdate));
            cmd.Parameters.Add(new SqlParameter("@endingweek", edate));
            cmd.Parameters.Add(new SqlParameter("@mon", '0'));
            cmd.Parameters.Add(new SqlParameter("@tue", '0'));
            cmd.Parameters.Add(new SqlParameter("@wed", '0'));
            cmd.Parameters.Add(new SqlParameter("@thu", '0'));
            cmd.Parameters.Add(new SqlParameter("@fri", '0'));
            cmd.Parameters.Add(new SqlParameter("@sat", '0'));
            cmd.Parameters.Add(new SqlParameter("@sun", '0'));
            cmd.Parameters.Add(new SqlParameter("@userid", Int32.Parse(Session["userid"].ToString())));
            cmd.Parameters.Add(new SqlParameter("@projectid", projectid));
            cmd.Parameters.Add(new SqlParameter("@status", "Not Submitted"));
            try
            {
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
            }
            finally
            {
                cmd.Connection.Close();
            }
        }

        private bool ValidateTaskData(String projectname, String taskname)
        {
            SqlCommand command = new SqlCommand("SPCheckDuplicatedTask", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
            command.Parameters.Add(new SqlParameter("@projectname", projectname));
            command.Parameters.Add(new SqlParameter("@taskname", taskname));
            command.CommandType = CommandType.StoredProcedure;
            SqlParameter valueReturned = new SqlParameter("valueReturned", SqlDbType.Int);
            command.Parameters.Add(valueReturned);
            valueReturned.Direction = ParameterDirection.ReturnValue;
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
            if (found != 0)
                return false;
            return true;
        }

        private string GetTimeSheetStatusById(int userid)
        {
            SqlCommand command = new SqlCommand("SPRetrieveTimesheetById", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));

            command.Parameters.Add("@Id", Int32.Parse(Session["userid"].ToString()));
            command.Parameters.Add("@StartingWeek", startingWeekDT);
            command.Parameters.Add("@EndingWeek", endingWeekDT);

            command.CommandType = CommandType.StoredProcedure;
            string s = "";
            try
            {
                command.Connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    s = reader.GetString(14);
                }

            }
            catch (Exception)
            {
            }
            finally
            {
                command.Connection.Close();
            }
            return s;
        }

        protected void SumHourOfSameDay(object sender, GridViewRowEventArgs e)
        {
            if(DataControlRowType.DataRow == e.Row.RowType)
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

        protected void UpdateTimesheetGridView(object sender, EventArgs e)
        {
            timesheetdb.SelectParameters[1].DefaultValue = sdate;
            timesheetdb.SelectParameters[2].DefaultValue = edate;
            TimesheetGridView.DataBind();
            DisplayTimesheetCurrentStatus();
            TimesheetUpdatePanel.Update();
        }
    }
}
