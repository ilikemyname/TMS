<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddUser.aspx.cs" Inherits="Assignment2_TMS.Administrator.AddUser"
    MasterPageFile="~/TMSSite.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ContentPlaceHolderID="menu" ID="C1" runat="server">
<p><asp:HyperLink ID="MemberPagesLink" runat="server" NavigateUrl="~/Member/Profile.aspx">Member Function</asp:HyperLink></p>
    <li><a  href="ViewUsers.aspx">View Users</a></li>
    <li><a  href="ViewProjects.aspx">Projects</a></li>
    <li><a  href="Audit.aspx">Audit Trail</a></li>
</asp:Content>
<asp:Content ContentPlaceHolderID="body" ID="C3" runat="server">
    <table class="AddUserForm">
        <tr>
            <td>
                Username
            </td>
        </tr>
        <tr>
            <td>
                <%--<asp:UpdatePanel ID="up1" runat="server">
                    <ContentTemplate>
                        <asp:TextBox ID="Unametb" runat="server" MaxLength="32" 
                            AutoPostBack="true"             ValidationGroup="ValAddUserGroup"
                            ontextchanged="Unametb_TextChanged" />
                        <div runat="server" id="UserAvailability"></div><br />
                    </ContentTemplate>
               </asp:UpdatePanel>
               <div></div>
               <br />--%>
                <asp:TextBox ID="Unametb" runat="server" MaxLength="32" AutoPostBack="true" ValidationGroup="ValAddUserGroup" />
                <asp:RequiredFieldValidator ID="UNameRequiredFieldValidator" runat="server" ErrorMessage="Username is required"
                    ControlToValidate="Unametb" ValidationGroup="ValAddUserGroup"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="UNameRegularExpressionValidator" runat="server"
                    ErrorMessage="Username must be between 4 and 32 characters long([a-z][0-9])"
                    ControlToValidate="Unametb" Display="None" ValidationExpression="^[a-z0-9_]{4,32}"
                    ValidationGroup="ValAddUserGroup"></asp:RegularExpressionValidator>
                <asp:ValidatorCalloutExtender ID="UNameRegularExpressionValidator_ValidatorCalloutExtender"
                    runat="server" Enabled="true" TargetControlID="UNameRegularExpressionValidator">
                </asp:ValidatorCalloutExtender>
            </td>
        </tr>
        <tr>
            <td>
                Password
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="passtb" runat="server" TextMode="Password" MaxLength="32" ValidationGroup="ValAddUserGroup"></asp:TextBox>
                <asp:RequiredFieldValidator ID="PassRequiredFieldValidator" runat="server" ErrorMessage="Password is required"
                    ControlToValidate="passtb" ValidationGroup="ValAddUserGroup"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="PassRegularExpressionValidator" runat="server"
                    ErrorMessage="Password must be between 6 and 32 characters long([a-z][0-9].@)"
                    ControlToValidate="passtb" Display="None" ValidationExpression="^([0-9A-Za-z@.]{6,32})$"
                    ValidationGroup="ValAddUserGroup"></asp:RegularExpressionValidator>
                <asp:ValidatorCalloutExtender ID="PassRegularExpressionValidator_ValidatorCalloutExtender"
                    runat="server" Enabled="true" TargetControlID="PassRegularExpressionValidator">
                </asp:ValidatorCalloutExtender>
            </td>
        </tr>
        <tr>
            <td>
                Firstname
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="fnametb" runat="server" ValidationGroup="ValAddUserGroup"></asp:TextBox>
                <asp:RequiredFieldValidator ID="FNameRequiredFieldValidator" runat="server" ErrorMessage="Firstname is required"
                    ControlToValidate="fnametb" ValidationGroup="ValAddUserGroup"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="FNameRegularExpressionValidator" runat="server"
                    ErrorMessage="Invalid name" ControlToValidate="fnametb" ValidationExpression="^[a-z]+$"
                    Display="None" ValidationGroup="ValAddUserGroup"></asp:RegularExpressionValidator>
                <asp:ValidatorCalloutExtender ID="FNameRegularExpressionValidator_ValidatorCalloutExtender"
                    runat="server" Enabled="true" TargetControlID="FNameRegularExpressionValidator">
                </asp:ValidatorCalloutExtender>
            </td>
        </tr>
        <tr>
            <td>
                Middlename
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="mnametb" runat="server" ValidationGroup="ValAddUserGroup"></asp:TextBox>
                <asp:RegularExpressionValidator ID="MNameRegularExpressionValidator" runat="server"
                    ErrorMessage="Invalid name" ControlToValidate="mnametb" ValidationExpression="^[a-z]+$"
                    Display="None" ValidationGroup="ValAddUserGroup"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td>
                Lastname
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="lnametb" runat="server" ValidationGroup="ValAddUserGroup"></asp:TextBox>
                <asp:RequiredFieldValidator ID="LNameRequiredFieldValidator" runat="server" ErrorMessage="Lastname is required"
                    ControlToValidate="lnametb" ValidationGroup="ValAddUserGroup"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="LNameRegularExpressionValidator" runat="server"
                    ErrorMessage="Invalid name" ControlToValidate="lnametb" ValidationExpression="^[a-z]+$"
                    Display="None" ValidationGroup="ValAddUserGroup"></asp:RegularExpressionValidator>
                <asp:ValidatorCalloutExtender ID="LNameRegularExpressionValidator_ValidatorCalloutExtender"
                    runat="server" Enabled="true" TargetControlID="LNameRegularExpressionValidator">
                </asp:ValidatorCalloutExtender>
            </td>
        </tr>
        <tr>
            <td>
                Email
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="emailtb" runat="server" ValidationGroup="ValAddUserGroup"></asp:TextBox>
                <asp:RequiredFieldValidator ID="EmailRequiredFieldValidator" runat="server" ErrorMessage="Email is required"
                    ControlToValidate="emailtb" ValidationGroup="ValAddUserGroup"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="EmailRegularExpressionValidator" runat="server"
                    ErrorMessage="Invalid email" ControlToValidate="emailtb" ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$"
                    Display="None" ValidationGroup="ValAddUserGroup"></asp:RegularExpressionValidator>
                <asp:ValidatorCalloutExtender ID="EmailRegularExpressionValidator_ValidatorCalloutExtender"
                    runat="server" Enabled="true" TargetControlID="EmailRegularExpressionValidator">
                </asp:ValidatorCalloutExtender>
            </td>
        </tr>
        <tr>
            <td>
                Direct Manager
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=.\sqlexpress;Initial Catalog='TMSDB';Integrated Security=True;"
                    SelectCommand="SELECT id, username FROM users" SelectCommandType="Text"></asp:SqlDataSource>
                <asp:DropDownList ID="ManagerDropDownList" runat="server" DataSourceID="SqlDataSource1"
                    DataTextField="username" DataValueField="id" BackColor="IndianRed"
                    ForeColor="Snow">
                </asp:DropDownList>
            </td>
        </tr>
        <%--        <tr>
            <td>
                Admin?
                <asp:DropDownList ID="RoleDropDownList" runat="server">
                    <asp:ListItem Value="true">True</asp:ListItem>
                    <asp:ListItem Value="false">False</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>--%>
        <tr>
            <td>
                <%--                <asp:UpdatePanel ID="up2" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="AddButton" runat="server" Text="Sign me up!" OnClick="AddButton_Click"
                            ValidationGroup="ValAddUserGroup" Enabled="false" />
                    </ContentTemplate>
                </asp:UpdatePanel>--%>
                <asp:Button ID="AddButton" runat="server" Text="Sign me up!" OnClick="AddButton_Click"
                    ValidationGroup="ValAddUserGroup" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="WarningLabel" runat="server" Visible="false" Font-Bold="True" ForeColor="Blue"
                    Font-Size="Larger"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
