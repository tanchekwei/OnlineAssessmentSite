<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AssignRoles.aspx.cs" Inherits="OnlineAssessmentSite.Admin.AssignRoles" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Manage Roles By User</h3>
    <style>
        .Important {
            font-size: large;
            color: Red;
        }
    </style>
    <p align="center">

        <asp:Label ID="ActionStatus" runat="server" CssClass="Important"></asp:Label>
    </p>

    <p>
        <b>Select a User:</b>
        <asp:DropDownList ID="UserList" runat="server" AutoPostBack="True"
            DataTextField="UserName" DataValueField="UserName" OnSelectedIndexChanged="UserList_SelectedIndexChanged">
        </asp:DropDownList>
    </p>
    <p>
        <asp:Repeater ID="UsersRoleList" runat="server">
            <ItemTemplate>
                <asp:CheckBox runat="server" ID="RoleCheckBox"
                    AutoPostBack="true"
                    Text='<%# Container.DataItem %>'
                    OnCheckedChanged="RoleCheckBox_CheckChanged" />
                <br />
            </ItemTemplate>
        </asp:Repeater>
    </p>

</asp:Content>
