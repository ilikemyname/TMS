<%@ Page Language="C#" MasterPageFile="~/TMSSite.Master" AutoEventWireup="true" CodeBehind="Timesheet.aspx.cs"
    Inherits="Assignment2_TMS.Member.Timesheet1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ContentPlaceHolderID="menu" ID="C1" runat="server">
    <p><asp:HyperLink ID="AdminPagesLink" runat="server" NavigateUrl="~/Administrator/ViewProjects.aspx">Admin Function</asp:HyperLink></p>
    <li><a href="Profile.aspx">My Profile</a></li>
    <li><a href="Project.aspx">Project</a></li>
</asp:Content>
<asp:Content ContentPlaceHolderID="submenu" ID="C2" runat="server">
    <ul>
        <li>
            <asp:HyperLink ID="myMemberLink" NavigateUrl="~/Member/MyMemberList.aspx" runat="server">View Your Member's Timesheets</asp:HyperLink>
        </li>
        <li>
            <asp:LinkButton ID="deleteButton" runat="server" OnClick="deleteButton_Click">Delete Selected Row</asp:LinkButton>
        </li>
        <li>
            <asp:LinkButton ID="submitButton" runat="server" OnClick="submitButton_Click">Submit</asp:LinkButton>
        </li>
        <li>
            <asp:LinkButton ID="saveButton" runat="server" OnClick="saveButton_Click">Save</asp:LinkButton>
        </li>
<%--        <li>--%>
            <%--<asp:LinkButton ID="addRow" runat="server">Add Row</asp:LinkButton>--%>
            <asp:Label ForeColor="Green" Visible="false" ID="TaskMessageLabel" Text="Task is added to timesheet!" runat="server"></asp:Label>
            <asp:Panel ID="popupPanel" runat="server">
                <asp:Table ID="AddTaskTable" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>Project</asp:TableCell>
                        <asp:TableCell>
                            <asp:DropDownList ID="projectList" runat="server" DataTextField="projectname" DataValueField="id">
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Task</asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="TaskTextbox" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell RowSpan="2">
                            <asp:Label ID="MessageLabel" runat="server" Visible="false"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableFooterRow>
                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                            <asp:Button ID="AddButton" runat="server" Text="Add" OnClick="AddButton_Click" />
                            <asp:Button ID="CancelButton" runat="server" Text="Cancel" />
                        </asp:TableCell>
                    </asp:TableFooterRow>
                </asp:Table>
            </asp:Panel>
<%--            <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" Enabled="true" TargetControlID="addRow"
                EnableViewState="true" PopupControlID="popupPanel" CancelControlID="CancelButton">
            </asp:ModalPopupExtender>--%>
<%--        </li>--%>
    </ul>
</asp:Content>
<asp:Content ContentPlaceHolderID="body" ID="C3" runat="server">
    <asp:Label ID="StartingWeekLabel" runat="server">Week Starting</asp:Label>
    <asp:TextBox ID="StartingWeekTextBox" runat="server" AutoPostBack="true" OnTextChanged="StartingWeekTextBox_TextChanged"></asp:TextBox>
    <asp:CalendarExtender ID="StartingWeekCalendarExtender" runat="server" Enabled="true"
        TargetControlID="StartingWeekTextBox">
    </asp:CalendarExtender>
    <asp:UpdatePanel ID="TimesheetUpdatePanel" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Label ID="CurrentStatusLabel" runat="server" Visible="false" Font-Size="Larger" ForeColor="#33CC33" Font-Bold="True"></asp:Label>
            <asp:GridView ID="TimesheetGridView" runat="server" DataSourceID="timesheetdb" AutoGenerateColumns="false"
                PageSize="10" BorderStyle="Solid" OnRowDataBound="SumHourOfSameDay" ShowFooter="true">
                <Columns>
                    <asp:TemplateField HeaderText="Select">
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox" runat="server" AutoPostBack="true" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="id" HeaderText="Id"></asp:BoundField>
                    <asp:BoundField DataField="projectname" HeaderText="Project Name"></asp:BoundField>
                    <asp:BoundField DataField="task" HeaderText="Task" FooterText="Total"></asp:BoundField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="DayLabel" runat="server" Text='<%# GetHeader("MON") %>'></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="MonTextBox" runat="server" Text='<%# Bind("monday")  %>' AutoPostBack="true"
                                OnTextChanged="saveButton_Click">
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
                                OnTextChanged="saveButton_Click" />
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
                                OnTextChanged="saveButton_Click" />
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
                                OnTextChanged="saveButton_Click" />
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
                                OnTextChanged="saveButton_Click" />
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
                                OnTextChanged="saveButton_Click" />
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
                                OnTextChanged="saveButton_Click" />
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
                ProviderName="System.Data.SqlClient" SelectCommandType="StoredProcedure" UpdateCommandType="StoredProcedure"
                DeleteCommandType="StoredProcedure" SelectCommand="SPRetrieveTimesheetById" UpdateCommand="SPUpdateTimesheetById"
                DeleteCommand="SPDeleteTimesheetById">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:Parameter Name="id" Type="Int32" />
                    <asp:Parameter Name="startingweek" Type="DateTime" />
                    <asp:Parameter Name="endingweek" Type="DateTime" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="id" Type="Int32" />
                    <asp:Parameter Name="startingweek" Type="DateTime" />
                    <asp:Parameter Name="endingweek" Type="DateTime" />
                    <asp:Parameter Name="mon" Type="Int32" />
                    <asp:Parameter Name="tue" Type="Int32" />
                    <asp:Parameter Name="wed" Type="Int32" />
                    <asp:Parameter Name="thu" Type="Int32" />
                    <asp:Parameter Name="fri" Type="Int32" />
                    <asp:Parameter Name="sat" Type="Int32" />
                    <asp:Parameter Name="sun" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Label ID="SaveStatusLabel" runat="server" Visible="false" ForeColor="Red" Font-Size="Larger"></asp:Label>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="TimesheetGridView" EventName="RowDeleting" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
