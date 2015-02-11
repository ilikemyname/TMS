<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Assignment2_TMS._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Login Page</title>
    <%--<link href="App_Themes/TMS/Styles.css" rel="stylesheet" type="text/css" />--%>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <div>
            <div>
                <div>
                    <h3>Login form</h3>
                    <div>
                        <asp:Label ID="unamelb" runat="server">Username</asp:Label>
                    </div>
                    <asp:TextBox ID="uname" runat="server"></asp:TextBox>
                    <div>
                        <asp:Label ID="passlb" runat="server">Password</asp:Label>
                    </div>
                    <asp:TextBox ID="pass" runat="server" TextMode="Password"></asp:TextBox>
                    <br />
                    <asp:Label ID="loginfaillb" runat="server" Text="LoginFailLabel" Visible="False"></asp:Label>
                    <p>
                        
                        <asp:Button ID="submitbtt" runat="server" Text="Login" 
                            onclick="submitbtt_Click" /> 
                        
                    </p>
                </div>
            </div>
        </div>
    
    </div>
    </form>
</body>
</html>
