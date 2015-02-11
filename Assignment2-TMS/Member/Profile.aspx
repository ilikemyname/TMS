<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/TMSSite.Master" CodeBehind="Profile.aspx.cs"
    Inherits="Assignment2_TMS.Member.Profile" %>

<asp:Content ContentPlaceHolderID="menu" ID="C1" runat="server">
    <p><asp:HyperLink ID="AdminPagesLink" runat="server" NavigateUrl="~/Administrator/ViewProjects.aspx">Admin Function</asp:HyperLink></p>
    <li><a href="Timesheet.aspx">Timesheet</a></li>
    <li><a href="Project.aspx">Project</a></li>
</asp:Content>
<asp:Content ContentPlaceHolderID="body" ID="C3" runat="server">
    <asp:Label ID="messageLabel" runat="server" Visible="false" ForeColor="Red" Font-Size="Larger"></asp:Label>
    <asp:DetailsView ID="ProfileDetailView" runat="server" DataSourceID="userdb" AutoGenerateRows="false"
        AutoGenerateEditButton="true" OnItemUpdated="UpdatedData" OnItemUpdating="UpdatingData"
        AllowPaging="true" HeaderText="Your detail profile">
        <Fields>
            <asp:BoundField DataField="username" HeaderText="Username" ReadOnly="true" />
            <asp:BoundField DataField="password" HeaderText="Password" />
            <asp:BoundField DataField="firstname" HeaderText="Firstname" />
            <asp:BoundField DataField="middlename" HeaderText="Middlename" />
            <asp:BoundField DataField="lastname" HeaderText="Lastname" />
            <asp:BoundField DataField="email" HeaderText="Email" />
            <asp:BoundField DataField="managerid" HeaderText="Manager id" ReadOnly="true" />
            <asp:BoundField DataField="isadmin" HeaderText="is admin" ReadOnly="true" />
        </Fields>
    </asp:DetailsView>
    <asp:SqlDataSource ID="userdb" runat="server" ConnectionString="Data Source=.\sqlexpress;Initial Catalog='TMSDB';Integrated Security=True;"
        ProviderName="System.Data.SqlClient" SelectCommandType="StoredProcedure" UpdateCommandType="StoredProcedure"
        SelectCommand="SPRetrievesUserById" UpdateCommand="SPMemberUpdate">
        <SelectParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="id" Type="Int32" />
            <asp:Parameter Name="password" Type="String" />
            <asp:Parameter Name="firstname" Type="String" />
            <asp:Parameter Name="middlename" Type="String" />
            <asp:Parameter Name="lastname" Type="String" />
            <asp:Parameter Name="email" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
