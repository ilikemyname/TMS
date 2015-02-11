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
using Assignment2_TMS.Utility;
using System.Text;
using System.Text.RegularExpressions;

namespace Assignment2_TMS.Administrator
{
    public partial class ViewUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UsersGridView.RowCancelingEdit += new GridViewCancelEditEventHandler(UsersGridView_RowCancelingEdit);
        }

        protected void UsersGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            messageLabel.Text = "";
            messageLabel.Visible = false;
        }

        protected void CheckDeletingAdminRow(object sender, GridViewDeleteEventArgs e)
        {
            messageLabel.Visible = false;
            var row = UsersGridView.Rows[e.RowIndex];
            var id = row.Cells[1].Text;
            var username = row.Cells[2].Text;
            if (username.Equals("admin"))
            {
                messageLabel.ForeColor = System.Drawing.Color.Red;
                messageLabel.Text = "Deny Requests Delete Admin Account!";
                messageLabel.Visible = true;
                e.Cancel = true;
            }
            else
            {
                SqlCommand command = new SqlCommand("SPCheckManagerId", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
                command.Parameters.Add(new SqlParameter("@managerid", Int32.Parse(id)));
                command.CommandType = CommandType.StoredProcedure;
                SqlParameter valueReturned = new SqlParameter("valueReturned", SqlDbType.Int);
                valueReturned.Direction = ParameterDirection.ReturnValue;
                command.Parameters.Add(valueReturned);
                int isManager = 0;
                try
                {
                    command.Connection.Open();
                    command.ExecuteNonQuery();
                    isManager = Int32.Parse(valueReturned.Value.ToString());
                }
                catch (Exception)
                {
                }
                finally
                {
                    command.Connection.Close();
                }
                if (isManager != 0)
                {
                    messageLabel.Text = "Cannot delete this user who is manager!";
                    messageLabel.Visible = true;
                    e.Cancel = true;
                }
                else
                {
                    command = new SqlCommand("SPCheckIsManagingProject", new SqlConnection(ConfigurationSettings.AppSettings["ConnString"]));
                    command.Parameters.Add(new SqlParameter("@managerid", Int32.Parse(id)));
                    command.CommandType = CommandType.StoredProcedure;
                    valueReturned = new SqlParameter("valueReturned", SqlDbType.Int);
                    valueReturned.Direction = ParameterDirection.ReturnValue;
                    command.Parameters.Add(valueReturned);
                    int managingproject = 0;
                    try
                    {
                        command.Connection.Open();
                        command.ExecuteNonQuery();
                        managingproject = Int32.Parse(valueReturned.Value.ToString());
                    }
                    catch (Exception)
                    {
                    }
                    finally
                    {
                        command.Connection.Close();
                    }
                    if (managingproject != 0)
                    {
                        messageLabel.Text = "Cannot delete this user who is managing projects!";
                        messageLabel.Visible = true;
                        e.Cancel = true;
                    }
                }
            }
        }

        protected void UpdateData(object sender, GridViewUpdatedEventArgs e)
        {
            messageLabel.Text = "Updated Success!";
            messageLabel.Visible = true;
        }

        //protected bool ValidateDataUpdating(object sender, GridViewUpdateEventArgs e)
        //{
        //    messageLabel.Visible = false;
        //    var userrow = UsersGridView.Rows[e.RowIndex];
        //    var userid = userrow.Cells[1].Text;
        //    var username = ((TextBox)userrow.Cells[2].Controls[0]).Text;
        //    var firstname = ((TextBox)userrow.Cells[4].Controls[0]).Text;
        //    var middlename = ((TextBox)userrow.Cells[5].Controls[0]).Text;
        //    var lastname = ((TextBox)userrow.Cells[6].Controls[0]).Text;
        //    var email = ((TextBox)userrow.Cells[7].Controls[0]).Text;
        //    var managerid = ((TextBox)userrow.Cells[8].Controls[0]).Text;

        //    //string warning = "";
        //    if (!Validation.CheckExistedUsername(username))
        //    {
        //        messageLabel.Text = "Fail to update! This username has signed up before.";
        //        messageLabel.Visible = true;
        //        return false;
        //    }
        //    else if (!Validation.IsValidName(firstname) || !Validation.IsValidName(middlename) || !Validation.IsValidName(lastname))
        //    {
        //        //warning = "Fail to update! Names don't allow number.";
        //        messageLabel.Text = "Fail to update! Names don't allow number.";
        //        messageLabel.Visible = true;
        //        return false;
        //    }
        //    else if (!Validation.IsValidEmail(email))
        //    {
        //        messageLabel.Text = "Fail to update! Email is not valid.";
        //        messageLabel.Visible = true;
        //        return false;
        //    }
        //    else if (!Validation.IsDigit(managerid))
        //    {
        //        messageLabel.Text = "Fail to update! Manager id is not a number.";
        //        messageLabel.Visible = true;
        //        return false;
        //    }
        //    else if (!Validation.FindExistedId(Int32.Parse(managerid)))
        //    {
        //        messageLabel.Text = "Fail to update! Manager id hasn't ever registered.";
        //        messageLabel.Visible = true;
        //        return false;
        //    }
        //    else if (Validation.CheckCyclicManagement(Int32.Parse(userid), Int32.Parse(managerid)))
        //    {
        //        messageLabel.Text = "Fail to update! You are not allowed to be managed by person who supervises you.";
        //        messageLabel.Visible = true;
        //        return false;
        //    }
        //    else
        //    {
        //        messageLabel.Text = "Updated user success!";
        //        messageLabel.Visible = true;
        //        return true;
        //    }
        //}

        //protected void IsDeletingAdmin(object sender, GridViewDeleteEventArgs e)
        //{
        //    messageLabel.Visible = false;
        //    var userrow = UsersGridView.Rows[e.RowIndex];
        //    var userid = userrow.Cells[1].Text;
        //    var username = ((TextBox)userrow.Cells[2].Controls[0]).Text;
        //    if(username == "admin")
        //    {
        //        messageLabel.Text = "Cannot delete admin!";
        //        messageLabel.Visible = true;
        //    }
        //}

        protected void ValidateDataUpdating(object sender, GridViewUpdateEventArgs e)
        {
            messageLabel.Visible = false;
            var userrow = UsersGridView.Rows[e.RowIndex];
            var userid = userrow.Cells[1].Text;
            var username = ((TextBox)userrow.Cells[2].Controls[0]).Text;
            var firstname = ((TextBox)userrow.Cells[4].Controls[0]).Text;
            var middlename = ((TextBox)userrow.Cells[5].Controls[0]).Text;
            var lastname = ((TextBox)userrow.Cells[6].Controls[0]).Text;
            var email = ((TextBox)userrow.Cells[7].Controls[0]).Text;
            var managerid = ((TextBox)userrow.Cells[8].Controls[0]).Text;

            string warning = "";
            int count = 0;
            if (Validation.CheckExistedUsernameExceptMine(Int32.Parse(userid), username))
            {
                warning = "_This username has signed up by the other.";
                messageLabel.Text = warning + "<br />";
                count++;
            }
            if(middlename != "")
            {
                if(!Validation.IsValidName(middlename))
                {
                    if (count != 0)
                    {
                        warning = "_Names don't allow number.";
                        messageLabel.Text += warning + "<br />";
                    }
                    else
                    {
                        warning = "_Names don't allow number.";
                        messageLabel.Text = warning + "<br />";
                        count++;
                    }
                }
            }
            if (!Validation.IsValidName(firstname) || !Validation.IsValidName(lastname))
            {
                if (count != 0)
                {
                    warning = "_Names don't allow number. Firstname and Lastname are required.";
                    messageLabel.Text += warning + "<br />";
                }
                else
                {
                    warning = "_Names don't allow number. Firstname and Lastname are required.";
                    messageLabel.Text = warning + "<br />";
                    count++;
                }
            }
            if (!Validation.IsValidEmail(email))
            {
                if (count != 0)
                {
                    warning = "_Email is not valid.";
                    messageLabel.Text += warning + "<br />";
                }
                else
                {
                    warning = "_Email is not valid.";
                    messageLabel.Text = warning + "<br />";
                    count++;
                }
            }
            if (Validation.CheckExistedEmailExceptMine(Int32.Parse(userid), email))
            {
                if (count != 0)
                {
                    warning = "_This email has signed up by the other.";
                    messageLabel.Text += warning + "<br />";
                }
                else
                {
                    warning = "_This email has signed up by the other.";
                    messageLabel.Text = warning + "<br />";
                    count++;
                }
            }
            if (!Validation.IsDigit(managerid))
            {
                if (count != 0)
                {
                    warning = "_Manager id is not a number.";
                    messageLabel.Text += warning + "<br />";
                }
                else
                {
                    warning = "_Manager id is not a number.";
                    messageLabel.Text = warning + "<br />";
                    count++;
                }
            }
            else if (!Validation.FindExistedId(Int32.Parse(managerid)))
            {
                if (count != 0)
                {
                    warning = "_Manager id is not real.";
                    messageLabel.Text += warning + "<br />";
                }
                else
                {
                    warning = "_Manager id is not real.";
                    messageLabel.Text = warning + "<br />";
                    count++;
                }
            }
            else if (Validation.CheckCyclicManagement(Int32.Parse(userid), Int32.Parse(managerid)))
            {
                if (count != 0)
                {
                    warning = "_You are not allowed to be managed by person who already supervises you.";
                    messageLabel.Text += warning + "<br />_You cannot manage yourself.";
                }
                else
                {
                    warning = "_You are not allowed to be managed by person who already supervises you.";
                    messageLabel.Text = warning + "<br />_You cannot manage yourself.";
                    count++;
                }
            }
            if (warning != "")
            {
                messageLabel.Text += "Fail To Update!";
                messageLabel.Visible = true;
                e.Cancel = true;
            }
        }
    }
}
