<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageRoles.aspx.cs" Inherits="OnlineAssessmentSite.Admin.WebForm1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style type="text/css">
        .auto-style1 {
            height: 54px;
            width: 558px;
        }

        .auto-style2 {
            width: 558px;
        }
    </style>

    <div>
        <table align="center">
            <tr>
                <td class="auto-style1">
                    <b>Create a New Role: </b>
                    <asp:TextBox ID="RoleName" runat="server" Width="237px"></asp:TextBox>
                    &nbsp;
    <asp:Button ID="CreateRoleButton" runat="server" Text="Create Role" OnClick="CreateRoleButton_Click" />

                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:GridView ID="RoleList" runat="server" AutoGenerateColumns="False" Width="310px">
                        <RowStyle HorizontalAlign="Center"></RowStyle>
                        <Columns>
                            <asp:CommandField DeleteText="Delete Role" ShowDeleteButton="True" HeaderText="Operation" />
                            <asp:TemplateField HeaderText="Role">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="RoleNameLabel" Text='<%# Container.DataItem %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
