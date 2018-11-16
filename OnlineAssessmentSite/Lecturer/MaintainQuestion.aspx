<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="MaintainQuestion.aspx.cs" Inherits="OnlineAssessmentSite.Lecturer.MaintainQuestion" %>


<asp:Content ID="Content14" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Panel ID="panelControl" runat="server">
                Assessment Info<br />
                <table style="width:100%;">
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
                        <td style="text-align:center;" colspan="4">

                            &nbsp;</td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <asp:Label ID="UploadWarning" runat="server" Text=""></asp:Label>
            <br />
            <asp:Panel ID="panelInsert" runat="server" Width="651px">
                <asp:FormView ID="fvInsertQuestion" runat="server" DataKeyNames="questionID" DefaultMode="Insert" ItemType="OnlineAssessmentSite.Models.Question" InsertMethod="fvInsertQuestion_InsertItem">
                    <InsertItemTemplate>
                        <table>
                            <tr>
                                <td>Question</td>
                                <td>
                                    <asp:TextBox ID="txtQName" runat="server" Text='<%# Bind("questionName") %>' Height="50px" Width="550px" />
                                </td>
                            </tr>
                            <tr>
                                <td>Selection / Extra Content</td>
                                <td>
                                    <asp:TextBox ID="txtQDesc" runat="server" Text='<%# Bind("questionDesc") %>' Height="50px" Width="550px" />
                                </td>
                            </tr>
                            <tr>
                                <td>Answer</td>
                                <td>
                                    <asp:TextBox ID="txtQAnswer" runat="server" Text='<%# Bind("questionAnswer") %>' Height="20px" Width="20px" />
                                </td>
                            </tr>
                            <tr>
                                <td>Image</td>
                                <td>
                                    <asp:Label ID="lblQImagePath" runat="server" Text='<%# Bind("questionImage") %>'></asp:Label>
                                    <asp:FileUpload ID="fuQImage" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" OnClick="InsertButton_Click" />
                                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                </td>
                            </tr>
                        </table>
                    </InsertItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="dataSrcQuestion" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Questions]"></asp:SqlDataSource>
            </asp:Panel>
        <br />
        <asp:FormView ID="fvDelUpdQuestion" runat="server" AllowPaging="True" DataKeyNames="questionID" DataSourceID="dataSrcQuestion2" DefaultMode="Edit">
            <EditItemTemplate>
                Question ID
                <asp:Label ID="questionIDLabel" runat="server" Text='<%# Bind("questionID") %>' />
                <br />
                Assessment ID
                <asp:Label ID="assessmentIDLabel" runat="server"  Text='<%# Bind("assessmentID") %>' />
                <br />
                <asp:TextBox ID="questionNameTextBox" runat="server" Text='<%# Bind("questionName") %>' />
                <br />
                <asp:TextBox ID="questionDescTextBox" runat="server" Text='<%# Bind("questionDesc") %>' />
                <br />
                <asp:TextBox ID="questionImageTextBox" runat="server" Text='<%# Bind("questionImage") %>' />
                <br />
                <asp:TextBox ID="questionAnswerTextBox" runat="server" Text='<%# Bind("questionAnswer") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="True" CommandName="Delete" Text="Delete" />
            </EditItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="dataSrcQuestion2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            DeleteCommand="DELETE FROM [Questions] WHERE [questionID] = @questionID" 
            InsertCommand="INSERT INTO [Questions] ([assessmentID], [questionName], [questionDesc], [questionAnswer], [questionImage]) VALUES (@assessmentID, @questionName, @questionDesc, @questionAnswer, @questionImage)" 
            SelectCommand="SELECT * FROM [Questions] WHERE ([assessmentID] = @assessmentID)" 
            UpdateCommand="UPDATE [Questions] SET [assessmentID] = @assessmentID, [questionName] = @questionName, [questionDesc] = @questionDesc, [questionAnswer] = @questionAnswer, [questionImage] = @questionImage WHERE [questionID] = @questionID">
            <DeleteParameters>
                <asp:Parameter Name="questionID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="assessmentID" Type="Int32" />
                <asp:Parameter Name="questionName" Type="String" />
                <asp:Parameter Name="questionDesc" Type="String" />
                <asp:Parameter Name="questionAnswer" Type="String" />
                <asp:Parameter Name="questionImage" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="lblAID" Name="assessmentID" PropertyName="Text" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="assessmentID" Type="Int32" />
                <asp:Parameter Name="questionName" Type="String" />
                <asp:Parameter Name="questionDesc" Type="String" />
                <asp:Parameter Name="questionAnswer" Type="String" />
                <asp:Parameter Name="questionImage" Type="String" />
                <asp:Parameter Name="questionID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

</asp:Content>