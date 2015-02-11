<%@ Page MasterPageFile="~/TMSSite.Master" Language="C#" AutoEventWireup="true" CodeBehind="AddProject.aspx.cs"
    Inherits="Assignment2_TMS.Administrator.AddProject" %>

<asp:Content ContentPlaceHolderID="menu" ID="C1" runat="server">
    <p><asp:HyperLink ID="MemberPagesLink" runat="server" NavigateUrl="~/Member/Profile.aspx">Member Function</asp:HyperLink></p>
    <li><a href="ViewProjects.aspx">Projects</a></li>
    <li><a href="ViewUsers.aspx">Users</a></li>
    <li><a href="Audit.aspx">Audit Trail</a></li>
</asp:Content>
<asp:Content ContentPlaceHolderID="body" ID="C3" runat="server">
    <table>
        <tr>
            <td>
                Code
                <br />
                <asp:TextBox ID="CodeTextBox" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="CodeRequiredFieldValidator" runat="server" ErrorMessage="Project code is required."
                    ControlToValidate="CodeTextBox"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Name
                <br />
                <asp:TextBox ID="NameTextBox" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ErrorMessage="Project name is required."
                    ControlToValidate="NameTextBox" Visible="True" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="NameRegularExpressionValidator" runat="server"
                    ErrorMessage="Number is disallowed!" ControlToValidate="NameTextBox" ValidationExpression="^[a-zA-Z+]+(\s[a-zA-Z+]+)*$"></asp:RegularExpressionValidator>
                <!--  -->
            </td>
        </tr>
        <tr>
            <td>
                Manager
                <br />
                <asp:SqlDataSource ID="userdb" ConnectionString="<%$ appSettings:ConnString %>" runat="server"
                    SelectCommandType="Text" SelectCommand="select id, username from users"></asp:SqlDataSource>
                <asp:DropDownList ID="ManagerDropDownList" runat="server" DataSourceID="userdb" DataTextField="username"
                    DataValueField="id">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="AddProjectButton" runat="server" Text="Add Project!" OnClick="AddProjectButton_Click" />
                <br />
                <asp:Label ID="WarningLabel" runat="server" Text="Label" Visible="False" Font-Size="Larger"
                    ForeColor="Red"></asp:Label>
                <br />
                <asp:Label ID="MessageLabel" runat="server" Text="Label" Visible="False" ForeColor="#33CC33"
                    Font-Size="Larger"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
