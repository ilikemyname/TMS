<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Audit.aspx.cs" MasterPageFile="~/TMSSite.Master"
    Inherits="Assignment2_TMS.Administrator.Audit" %>

<asp:Content ContentPlaceHolderID="menu" ID="C1" runat="server">
<p><asp:HyperLink ID="MemberPagesLink" runat="server" NavigateUrl="~/Member/Profile.aspx">Member Function</asp:HyperLink></p>
    <li><a href="ViewProjects.aspx">Project</a></li>
    <li><a href="ViewUsers.aspx">User</a></li>
</asp:Content>
<asp:Content ContentPlaceHolderID="body" ID="C3" runat="server">
    <asp:UpdatePanel ID="AuditUP" runat="server">
        <ContentTemplate>
            <asp:GridView ID="AuditGV" DataKeyNames="id" runat="server" DataSourceID="auditdb"
                AutoGenerateColumns="false" AllowPaging="true" BorderStyle="Solid">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="Id" />
                    <asp:BoundField DataField="action" HeaderText="Action" />
                    <asp:BoundField DataField="tablename" HeaderText="Table Name" />
                    <asp:BoundField DataField="detail" HeaderText="Detail" />
                    <asp:BoundField DataField="logtime" HeaderText="Log time" DataFormatString="{0:dd/MM/yyyy}" />
                </Columns>
                <EmptyDataTemplate>
                    <b>Sorry, no audit trail records found</b></EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="auditdb" runat="server" ConnectionString="<%$ appSettings:ConnString %>"
                ProviderName="System.Data.SqlClient" SelectCommandType="StoredProcedure" SelectCommand="SPRetrieveAudits">
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
