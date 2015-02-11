<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewProject.aspx.cs" MasterPageFile="~/TMSSite.Master" Inherits="Assignment2_TMS.Member.ViewProject" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:content contentplaceholderid="menu" id="C1" runat="server">
    <p><asp:HyperLink ID="AdminPagesLink" runat="server" NavigateUrl="~/Administrator/ViewProjects.aspx">Admin Function</asp:HyperLink></p>
    <li><a href="Profile.aspx">My Profile</a></li>
    <li><a href="Timesheet.aspx">My Timesheet</a></li>
</asp:content>
<asp:content contentplaceholderid="body" id="C3" runat="server">
    <asp:Label ID="StartingWeekLabel" runat="server">Week Starting</asp:Label>
    <asp:TextBox ID="StartingWeekTextBox" runat="server" AutoPostBack="true" OnTextChanged="StartingWeekTextBox_TextChanged"></asp:TextBox>
    <asp:CalendarExtender ID="StartingWeekCalendarExtender" runat="server" Enabled="true"
        TargetControlID="StartingWeekTextBox">
    </asp:CalendarExtender>
    <asp:UpdatePanel ID="TimesheetUpdatePanel" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Label ID="CurrentStatusLabel" runat="server" Visible="false" Font-Size="Larger"
                ForeColor="#33CC33" Font-Bold="True"></asp:Label>
            <asp:GridView ID="TimesheetGridView" runat="server" DataSourceID="timesheetdb" AutoGenerateColumns="false"
                PageSize="10" BorderStyle="Solid" OnRowDataBound="SumHourOfSameDay" ShowFooter="true">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="Id"></asp:BoundField>
                    <asp:BoundField DataField="projectname" HeaderText="Project Name"></asp:BoundField>
                    <asp:BoundField DataField="task" HeaderText="Task" FooterText="Total"></asp:BoundField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="DayLabel" runat="server" Text='<%# GetHeader("MON") %>'></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="MonTextBox" runat="server" Text='<%# Bind("monday")  %>' AutoPostBack="true"
                                ReadOnly="true">
                            </asp:TextBox>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="TotalMonLabel" runat="server" Text='<%# GetTotal(0) %>'></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="DayLabel" runat="server" Text='<%# GetHeader("TUE") %>'></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="TueTextBox" runat="server" Text='<%# Bind("tuesday") %>' AutoPostBack="true"
                                ReadOnly="true" />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="TotalTueLabel" runat="server" Text='<%# GetTotal(1) %>'></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="DayLabel" runat="server" Text='<%# GetHeader("WED") %>'></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="WebTextBox" runat="server" Text='<%# Bind("wednesday") %>' AutoPostBack="true"
                                ReadOnly="true" />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="TotalWedLabel" runat="server" Text='<%# GetTotal(2) %>'></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="DayLabel" runat="server" Text='<%# GetHeader("THU") %>'></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="ThuTextBox" runat="server" Text='<%# Bind("thursday") %>' AutoPostBack="true"
                                ReadOnly="true" />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="TotalThuLabel" runat="server" Text='<%# GetTotal(3) %>'></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="DayLabel" runat="server" Text='<%# GetHeader("FRI") %>'></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="FriTextBox" runat="server" Text='<%# Bind("friday") %>' AutoPostBack="true"
                                ReadOnly="true" />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="TotalFriLabel" runat="server" Text='<%# GetTotal(4) %>'></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="DayLabel" runat="server" Text='<%# GetHeader("SAT") %>'></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="SatTextBox" runat="server" Text='<%# Bind("saturday") %>' AutoPostBack="true"
                                ReadOnly="true" />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="TotalSatLabel" runat="server" Text='<%# GetTotal(5) %>'></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="DayLabel" runat="server" Text='<%# GetHeader("SUN") %>'></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="SunTextBox" runat="server" Text='<%# Bind("sunday") %>' AutoPostBack="true"
                                ReadOnly="true" />
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="TotalSunLabel" runat="server" Text='<%# GetTotal(6) %>'></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total">
                        <FooterTemplate>
                            <asp:Label ID="total" runat="server" Text='<%# GetTotalWorkingHoursWeek() %>' />
                        </FooterTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <b>Sorry, no timesheets are available now</b>
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="timesheetdb" runat="server" ConnectionString="Data Source=.\sqlexpress;Initial Catalog='TMSDB';Integrated Security=True;"
                ProviderName="System.Data.SqlClient" SelectCommandType="StoredProcedure" SelectCommand="SPRetrieveTimesheetByProjectId">
                <SelectParameters>
                    <asp:Parameter Name="projectid" Type="Int32" />
                    <asp:Parameter Name="startingweek" Type="DateTime" />
                    <asp:Parameter Name="endingweek" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="TimesheetGridView" EventName="RowDeleting" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:Label ID="SaveStatusLabel" runat="server" Visible="false" ForeColor="Red" Font-Size="Larger"></asp:Label>
</asp:content>
