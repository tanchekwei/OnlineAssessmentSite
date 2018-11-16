<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="OnlineAssessmentSite.Admin.ManageUsers" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="GridView1" runat="server" SelectMethod="GridView1_GetData" 
        AutoGenerateColumns="False" DeleteMethod="GridView1_DeleteItem">
        <Columns>
            <asp:BoundField DataField="UserName" HeaderText="UserName" ReadOnly="True" SortExpression="UserName" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            <asp:ButtonField CommandName="Delete" HeaderText="Delete User" 
                ShowHeader="True" Text="Delete" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="objAllUsers" runat="server" SelectMethod="GetAllUsers" TypeName="System.Web.Security.Membership" OldValuesParameterFormatString="original_{0}"></asp:ObjectDataSource>
</asp:Content>
