<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VoiceRecoder.aspx.cs" Inherits="VoiceRecorder.VoiceRecoder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            color: #FF0000;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <br />
            &nbsp;<strong>Employee Name: </strong> &nbsp;<asp:TextBox ID="txtName" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:ImageButton ID="ImageButton1" runat="server" Height="46" ImageUrl="~/Img/Speak-mic.png" OnClick="ImageButton1_Click" ToolTip="Speak" Width="39px" />
            &nbsp;<asp:Button ID="Btnsavestop" runat="server" Text="Stop and Save" OnClick="Btnsavestop_Click" Height="49px" />
            &nbsp;&nbsp;
            <asp:ImageButton ID="ImageButton2" runat="server" Height="48px" ImageUrl="~/Img/Speaker.png" OnClick="ImageButton2_Click" Width="50px" />
            <br />
            &nbsp;
            <strong>Status&nbsp; :&nbsp;&nbsp; </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblMessage" runat="server" BackColor="#66FF99" Font-Bold="true" ForeColor="Red" Text="Message..."></asp:Label>
            <br />
            <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>&nbsp;&nbsp;&nbsp;&nbsp;
            <br/>
            <br />
            <strong>List of All Pronunciation Recorded:</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Button ID="Button1" runat="server" Height="42px" OnClick="Button1_Click" Text="Get All Recordings" />
            <br />
            <strong>Total Recording (Count)</strong> :
            <asp:Label ID="lbCount" runat="server" BackColor="#FFFF66" Font-Bold="true" ForeColor="Red"></asp:Label>
            <br />
            <br />
            <span class="auto-style1"><strong>Did Not Find Recording? Please Try</strong></span><a href="https://mdn.github.io/web-speech-api/speak-easy-synthesis/"><span class="auto-style1"><strong> Here</strong></span></a><span class="auto-style1"><strong>. </strong></span>
            <br />
            <br />
        </div>
        <asp:ListBox ID="lstBoxEmployeeRecorded" runat="server" Height="334px" OnSelectedIndexChanged="lstBoxEmployeeRecorded_SelectedIndexChanged" AutoPostBack="true" ToolTip="List of Employee Recorded" Width="294px"></asp:ListBox>
        <br />
    </form>
</body>
</html>
