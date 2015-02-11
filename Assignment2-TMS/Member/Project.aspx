<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Project.aspx.cs" MasterPageFile="~/TMSSite.Master" Inherits="Assignment2_TMS.Member.Project" %>

<asp:content contentplaceholderid="menu" id="C1" runat="server">
    <p><asp:HyperLink ID="AdminPagesLink" runat="server" NavigateUrl="~/Administrator/ViewProjects.aspx">Admin Function</asp:HyperLink></p>
    <li><a href="Timesheet.aspx">My Timesheet</a></li>
    <li><a href="Profile.aspx">My Profile</a></li>
</asp:content>
<asp:content contentplaceholderid="body" id="C3" runat="server">
    <h2>Your project list</h2>
    <asp:UpdatePanel ID="MyProjectUpdatePanel" runat="server">
        <ContentTemplate>
            <asp:GridView ID="myprojectgridview" runat="server" DataSourceID="projectdb" AutoGenerateColumns="false"
                AllowPaging="true" BorderStyle="Solid">
                <Columns>
                    <asp:BoundField DataField="projectcode" HeaderText="Project Code" SortExpression="projectcode" />
                    <asp:BoundField DataField="projectname" HeaderText="Project Name" SortExpression="projectname" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="MemberProjectLink" runat="server" NavigateUrl='<%# Eval("id","~/Member/ViewProject.aspx?projectid={0}") %>'>Click to view timesheet</asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <b>You have no project yet!</b>
                </EmptyDataTemplate>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="projectdb" runat="server" ConnectionString="Data Source=.\sqlexpress;Initial Catalog='TMSDB';Integrated Security=True;"
        ProviderName="System.Data.SqlClient" SelectCommandType="StoredProcedure" SelectCommand="SPRetrieveProjectsByManagerId">
        <SelectParameters>
            <asp:Parameter Name="managerid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:content>
