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

namespace Assignment2_TMS.Administrator
{
    public partial class ViewProjects1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ProjectsGridView.RowCancelingEdit += new GridViewCancelEditEventHandler(ProjectsGridView_RowCancelingEdit);
        }

        protected void ProjectsGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            messageLabel.Text = "";
            messageLabel.Visible = false;
        }

        protected void UpdateData(object sender, GridViewUpdatedEventArgs e)
        {
            messageLabel.Text = "Updated Success!";
            messageLabel.Visible = true;
        }

        protected void ValidateDataUpdating(object sender, GridViewUpdateEventArgs e)
        {
            messageLabel.Visible = false;
            var row = ProjectsGridView.Rows[e.RowIndex];
            var id = row.Cells[1].Text;
            var code = ((TextBox)row.Cells[2].Controls[0]).Text;
            var name = ((TextBox)row.Cells[3].Controls[0]).Text;
            var managerid = ((TextBox)row.Cells[4].Controls[0]).Text;
            string warning = "";
            int count = 0;
            bool requiredFill = false;
            if (code == "")
            {
                warning = "Code name is required!<br />";
                count++;
                requiredFill = true;
            }
            else if (name == "")
            {
                if (count != 0)
                {
                    warning += "Project name is required!<br />";
                }
                else
                {
                    warning = "Project name is required!<br />";
                    count++;
                }
                requiredFill = true;
            }
            else if (managerid == "")
            {
                if (count != 0)
                {
                    warning += "Manager id is required!<br />";
                }
                else
                {
                    warning = "Manager id is required!<br />";
                    count++;
                }
                requiredFill = true;
            }
            if (requiredFill == false)
            {
                if (!Validation.IsValidProjectName(name))
                {
                    warning = "Project name disallows number!<br />";
                    count++;
                }
                else if(Validation.CheckThisProjectCodeAgainstOthers(Int32.Parse(id), code))
                {
                    if (count != 0)
                    {
                        warning += "Project code was duplicated with one in the database!<br />";
                    }
                    else
                    {
                        warning = "Project code was duplicated with one in the database!<br />";
                        count++;
                    }
                }
                else if (Validation.CheckThisProjectNameAgainstOthers(Int32.Parse(id), name))
                {
                    if (count != 0)
                    {
                        warning += "Project name was duplicated with one in the database!<br />";
                    }
                    else
                    {
                        warning = "Project name was duplicated with one in the database!<br />";
                        count++;
                    }
                }
                else if (!Validation.IsDigit(managerid))
                {
                    if (count != 0)
                    {
                        warning += "Manager id must be changed to a number!<br />";
                    }
                    else
                    {
                        warning = "Manager id must be changed to a number!<br />";
                        count++;
                    }
                }
                else if (!Validation.FindExistedId(Int32.Parse(managerid)))
                {
                    if (count != 0)
                    {
                        warning += "Manager id is not real!<br />";
                    }
                    else
                    {
                        warning = "Manager id is not real!<br />";
                        count++;
                    }
                }
            }

            if (warning != "")
            {
                messageLabel.Text = warning;
                messageLabel.Visible = true;
                e.Cancel = true;
            }
        }
    }
}
