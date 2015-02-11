<%@ Page Language="C#" MasterPageFile="~/TMSSite.Master" AutoEventWireup="true" CodeBehind="MyMemberList.aspx.cs"
    Inherits="Assignment2_TMS.Member.MemberTimesheet" %>

<asp:Content ContentPlaceHolderID="menu" ID="C1" runat="server">
    <p><asp:HyperLink ID="AdminPagesLink" runat="server" NavigateUrl="~/Administrator/ViewProjects.aspx">Admin Function</asp:HyperLink></p>
    <li><a href="Timesheet.aspx">My Timesheet</a></li>
    <li><a href="Profile.aspx">My Profile</a></li>
    <li><a href="Project.aspx">Project</a></li>
</asp:Content>
<asp:Content ContentPlaceHolderID="body" ID="C3" runat="server">
    <asp:Label ID="label1" runat="server" Text="Your member list" 
        ForeColor="#666666"></asp:Label>
    <asp:UpdatePanel ID="MyMembersUpdatePanel" runat="server">
        <ContentTemplate>
            <asp:GridView ID="mymembergridview" runat="server" DataSourceID="userdb" AutoGenerateColumns="false"
                AllowPaging="true" BorderStyle="Solid">
                <Columns>
                    <asp:BoundField DataField="username" HeaderText="Username" SortExpression="username" />
                    <asp:BoundField DataField="firstname" HeaderText="Firstname" SortExpression="firstname" />
                    <asp:BoundField DataField="middlename" HeaderText="Middlename" SortExpression="middlename" />
                    <asp:BoundField DataField="lastname" HeaderText="Lastname" SortExpression="lastname" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="MemberTimesheetLink" runat="server" NavigateUrl='<%# Eval("id","~/Member/ViewMemberTimesheet.aspx?id={0}") %>'>Click to view timesheet</asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <b>you have no member yet!</b>
                </EmptyDataTemplate>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="userdb" runat="server" ConnectionString="Data Source=.\sqlexpress;Initial Catalog='TMSDB';Integrated Security=True;"
        ProviderName="System.Data.SqlClient" SelectCommandType="StoredProcedure" SelectCommand="SPRetrieveUsersByManagerId">
        <SelectParameters>
            <asp:Parameter Name="managerid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
