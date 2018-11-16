<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LecturerMenu.aspx.cs" Inherits="OnlineAssessmentSite.Lecturer.LecturerMenu" %>

<asp:Content ID="Content11" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1>Assessment</h1>
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Lecturer/CreateNewAssessment.aspx">Create New Assessment</asp:HyperLink>
    <br />
    <br />
    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Lecturer/MaintainAssessment.aspx">Maintain Assessment</asp:HyperLink>
    <br />

</asp:Content>