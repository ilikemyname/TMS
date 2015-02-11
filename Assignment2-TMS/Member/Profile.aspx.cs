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
using Assignment2_TMS.Utility;

namespace Assignment2_TMS.Member
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                var userid = Session["userid"].ToString();
                userdb.SelectParameters["id"].DefaultValue = userid;
                userdb.UpdateParameters["id"].DefaultValue = userid;
            }
            if(Convert.ToBoolean(Session["role"]) == false)
            {
                AdminPagesLink.Visible = false;
            }
            //ProfileDetailView.ModeChanged += new EventHandler(ProfileDetailView_ModeChanged);
        }
        //void ProfileDetailView_ModeChanged(object sender, EventArgs e)
        //{
        //    if(Pro)
        //    {
        //    }
        //}
        protected void UpdatedData(Object sender, DetailsViewUpdatedEventArgs e)
        {
            messageLabel.Text = "Your profile has been updated!";
            messageLabel.ForeColor = System.Drawing.Color.Green;
            messageLabel.Visible = true;
        }
        protected void UpdatingData(Object sender, DetailsViewUpdateEventArgs e)
        {
            int userid = Int32.Parse(Session["userid"].ToString());
            messageLabel.Visible = false;
            var password = ((TextBox)ProfileDetailView.Rows[1].Cells[1].Controls[0]).Text;
            var firstname = ((TextBox)ProfileDetailView.Rows[2].Cells[1].Controls[0]).Text;
            var middlename = ((TextBox)ProfileDetailView.Rows[3].Cells[1].Controls[0]).Text;
            var lastname = ((TextBox)ProfileDetailView.Rows[4].Cells[1].Controls[0]).Text;
            var email = ((TextBox)ProfileDetailView.Rows[5].Cells[1].Controls[0]).Text;

            string warning = "";
            messageLabel.Text = "";
            int count = 0;
            bool emptyField = false;
            if (password == "")
            {
                warning = "Password is required!<br />";
                count++;
                emptyField = true;
            }
            else if (firstname == "")
            {
                if (count != 0)
                {
                    warning += "Firstname is required!<br />";
                }
                else
                {
                    warning = "Firstname is required!<br />";
                    count++;
                }
                emptyField = true;
            }
            else if (lastname == "")
            {
                if (count != 0)
                {
                    warning += "Lastname is required!<br />";
                }
                else
                {
                    warning = "Lastname is required!<br />";
                    count++;
                }
                emptyField = true;
            }
            else if (email == "")
            {
                if (count != 0)
                {
                    warning += "Email is required!<br />";
                }
                else
                {
                    warning = "Email is required!<br />";
                    count++;
                }
                emptyField = true;
            }

            bool validMidName = true;
            if (!emptyField)
            {
                if(middlename != "" && !Validation.IsValidName(middlename))
                {
                    validMidName = false;
                    warning = "Names don't allow number!<br />";
                    count++;
                }
                if(validMidName)
                {
                    if (!Validation.IsValidName(firstname) || !Validation.IsValidName(lastname))
                    {
                        warning = "Names don't allow number!<br />";
                        count++;
                    }
                }
                
                if (!Validation.IsValidEmail(email))
                {
                    if (count != 0)
                    {
                        warning += "Email is not valid!<br />";
                    }
                    else
                    {
                        warning = "Email is not valid.";
                        count++;
                    }
                }
                if (Validation.CheckExistedEmailExceptMine(userid, email))
                {
                    if (count != 0)
                    {
                        warning += "This email has signed up by the other!<br />";
                    }
                    else
                    {
                        warning = "This email has signed up by the other!<br />";
                        count++;
                    }
                }
            }

            if (warning != "")
            {
                messageLabel.ForeColor = System.Drawing.Color.Red;
                messageLabel.Text = warning;
                messageLabel.Text += "Fail To Update!<br />";
                messageLabel.Visible = true;
                e.Cancel = true;
            }
        }
    }
}
