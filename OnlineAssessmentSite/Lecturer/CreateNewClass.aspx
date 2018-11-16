<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateNewClass.aspx.cs" Inherits="OnlineAssessmentSite.Lecturer.CreateClass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h3>Create New Class</h3>

    <asp:FormView ID="fvClass" runat="server"
        DefaultMode="Insert" InsertMethod="fvClass_InsertItem"
        ItemType="OnlineAssessmentSite.Models.Class" DataKeyNames="classID" Width="309px">
        <InsertItemTemplate>
            <asp:Table runat="server">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="Label1" runat="server" Text="Class Name"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtClassName" runat="server" Text='<%# Bind("className") %>'></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="Label3" runat="server" Text="Class Type"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtClassType" runat="server" Text='<%# Bind("classType") %>'></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="Label4" runat="server" Text="Class Session"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:TextBox ID="txtClassSession" runat="server" Text='<%# Bind("classSession") %>'></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:Button ID="Button1" runat="server" 
                Text="Create" CommandName="Insert" />   
        </InsertItemTemplate>
    </asp:FormView>

</asp:Content>
