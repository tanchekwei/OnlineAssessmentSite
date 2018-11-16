<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="JoinClass.aspx.cs" Inherits="OnlineAssessmentSite.Student.JoinClass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h4>Enter class code: 
    <asp:textbox runat="server" ID="txtClassCode"></asp:textbox>
&nbsp;<asp:Button ID="btnJoin" runat="server" OnClick="btnJoin_Click" Text="Join Class" />
    </h4>
</asp:Content>
