<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MaintainCollaboration.aspx.cs" Inherits="OnlineAssessmentSite.Lecturer.MaintainCollaboration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width:100%;">
        <tr>
            <td>Assessment ID</td>
            <td>
                <asp:Label ID="lblAID" runat="server"></asp:Label>
            </td>
            <td>Assessment Name</td>
            <td>
                <asp:Label ID="lblAName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="vertical-align:top;" colspan="2">
                <asp:GridView ID="gvCollaborators" runat="server" DataSourceID="dataSrcCollaborator" AutoGenerateColumns="False" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4">
                    <Columns>
                        <asp:BoundField DataField="Column1" HeaderText="Collaborators' Full Name [Username]" ReadOnly="True" SortExpression="Column1" />
                    </Columns>
                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                    <RowStyle BackColor="White" ForeColor="#003399" />
                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <SortedAscendingCellStyle BackColor="#EDF6F6" />
                    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                    <SortedDescendingCellStyle BackColor="#D6DFDF" />
                    <SortedDescendingHeaderStyle BackColor="#002876" />
                </asp:GridView>
                <asp:SqlDataSource ID="dataSrcCollaborator" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT CONCAT(P.Name, ' [', U.UserName, ']')
FROM [aspnet_Users] U, [Collaborations] C, [UserProfiles] P
WHERE C.assessmentID = @assessmentID
AND C.UserId = U.UserId
AND C.UserId = P.UserId">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblAID" Name="assessmentID" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td style="vertical-align:top;" colspan="2">
                Username
                <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" />
                <br />
                <asp:Label ID="lblErrorMsg" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
