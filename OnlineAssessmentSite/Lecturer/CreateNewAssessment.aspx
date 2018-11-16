<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateNewAssessment.aspx.cs" Inherits="OnlineAssessmentSite.Lecturer.CreateNewAssessment" %>

<asp:Content ID="Content10" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:FormView ID="fvNewAssessment" runat="server" ItemType="OnlineAssessmentSite.Models.Assessment" DataKeyNames="assessmentID" DefaultMode="Insert" InsertMethod="fvNewAssessment_InsertItem">
                <InsertItemTemplate>
                    <table style="width:100%;">
                        <tr>
                            <td>Name:</td>
                            <td colspan="3">
                                <asp:TextBox ID="txtAssessmentName" runat="server" Text='<%# Bind("assessmentName") %>' Height="22px" Width="278px" />
                            </td>
                        </tr>
                        <tr>
                            <td>Duration:</td>
                            <td>
                                <asp:TextBox ID="txtAssessmentDuration" runat="server" Text='<%# Bind("assessmentDuration") %>' Height="20px" Width="50px" />
                            </td>
                            <td>Type:</td>
                            <td>
                                <asp:RadioButtonList ID="rblAssessmentType" runat="server" SelectedValue='<%# Bind("assessmentType") %>'>
                                    <asp:ListItem>MCQ</asp:ListItem>
                                    <asp:ListItem Value="WRT">Written</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td>Visibility:</td>
                            <td>
                                <asp:DropDownList ID="ddlAssessmentVisibility" runat="server" SelectedValue='<%# Bind("assessmentVisibility") %>'>
                                    <asp:ListItem>Public</asp:ListItem>
                                    <asp:ListItem>Private</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>Number of Attemps:</td>
                            <td>
                                <asp:TextBox ID="txtNumberOfAttemps" runat="server" Text='<%# Bind("assessmentAttempt") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">Start Date:</td>
                            <td colspan="2">End Date:</td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Calendar ID="calAssessmentStartDate" runat="server" SelectedDate='<%# Bind("assessmentStartDate") %>'></asp:Calendar>
                            </td>
                            <td colspan="2">
                                <asp:Calendar ID="calAssessmentEndDate" runat="server" SelectedDate='<%# Bind("assessmentEndDate") %>'></asp:Calendar>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="text-align:center;">
                                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                                &nbsp;
                                <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            </td>
                        </tr>
                    </table>
                    <br />
                    &nbsp;
                </InsertItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="DataSrcAssessment" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Assessments]"></asp:SqlDataSource>


</asp:Content>