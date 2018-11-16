<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MaintainPermission.aspx.cs" Inherits="OnlineAssessmentSite.Lecturer.MaintainPermission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="panelControl" runat="server">
        Assessment Info<br />
        <table style="width: 100%;">
            <tr>
                <td>ID</td>
                <td>
                    <asp:Label ID="lblAID" runat="server"></asp:Label>
                </td>
                <td>Name</td>
                <td>
                    <asp:Label ID="lblAName" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Duration</td>
                <td class="auto-style1">
                    <asp:Label ID="lblADuration" runat="server"></asp:Label>
                </td>
                <td class="auto-style1">Type</td>
                <td class="auto-style1">
                    <asp:Label ID="lblAType" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Visibility</td>
                <td>
                    <asp:Label ID="lblAVisibility" runat="server"></asp:Label>
                </td>
                <td>Available Date</td>
                <td>
                    <asp:Label ID="lblADates" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: center;" colspan="4">&nbsp;</td>
            </tr>
        </table>
        <br />
        Select class to give permission access the assessment:<br />
        <asp:DropDownList ID="ddlClass" runat="server" DataSourceID="SqlDataSource2" DataTextField="className" DataValueField="classID" Width="189px">
        </asp:DropDownList>
        &nbsp;
        <asp:Button ID="btnAuthorise" runat="server" OnClick="btnAuthorise_Click" Text="Give Access" Width="114px" />
        &nbsp;<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT c.classID, c.className 
FROM Classes c 
WHERE c.UserId = @UserId">
            <SelectParameters>
                <asp:Parameter Name="UserId" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
        List of class authorized to take the assessment:<br />
        <hr />
        <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333">
            <AlternatingItemStyle BackColor="White" />
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <ItemStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <ItemTemplate>
                <asp:Table runat="server" Width="600px">
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            Class Name:
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="classNameLabel" runat="server" Text='<%# Eval("className") %>' />
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Button ID="btnRemove" runat="server" Text="Remove" CommandName="Delete" OnCommand="btnRemove_Command" CommandArgument='<%# Eval("classID") %>' />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            Class Code:                       
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="classCodeLabel" runat="server" Text='<%# Eval("classCode") %>' />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            Class Type: 
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="classTypeLabel" runat="server" Text='<%# Eval("classType") %>' />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            Class Session: 
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="classSessionLabel" runat="server" Text='<%# Eval("classSession") %>' />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            Number of Student: 
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("NoOfStudent") %>' />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <hr />

            </ItemTemplate>
            <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT c.classID, c.className, c.classCode, c.classType, c.classSession,
  (SELECT COUNT(*)
  FROM Enrollments
  WHERE classID = c.classID) AS NoOfStudent  
FROM Classes c, Permissions p, Collaborations o, Assessments a 
WHERE c.classID = p.classID AND 
 p.assessmentID = a.assessmentID AND
 a.assessmentID = o.assessmentID AND
 p.assessmentID = @assessmentID AND 
 o.UserId = @UserId
 ">
            <SelectParameters>
                <asp:Parameter Name="assessmentID" />
                <asp:Parameter Name="UserId" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>
</asp:Content>
