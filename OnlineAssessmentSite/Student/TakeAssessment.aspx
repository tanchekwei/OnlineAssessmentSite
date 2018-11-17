<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TakeAssessment.aspx.cs" Inherits="OnlineAssessmentSite.Student.TakeAssessment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3><asp:Label ID="lblName" runat="server"></asp:Label></h3>
    <asp:PlaceHolder runat="server" ID="plh">
    </asp:PlaceHolder>
    <br />
    <asp:Table ID="tblQuestion" runat="server" CellPadding="10">
    </asp:Table>
    <br />
    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
</asp:Content>
