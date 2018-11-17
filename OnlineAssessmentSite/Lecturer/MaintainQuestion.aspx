<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="MaintainQuestion.aspx.cs" Inherits="OnlineAssessmentSite.Lecturer.MaintainQuestion" %>


<asp:Content ID="Content14" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Panel ID="panelControl" runat="server">
        Assessment Info<br />
        <table style="width: 100%;">
            <tr>
                <td style="width: 15%;">ID</td>
                <td style="width: 35%;">
                    <asp:Label ID="lblAID" runat="server"></asp:Label>
                </td>
                <td style="width: 15%;">Name</td>
                <td style="width: 35%;">
                    <asp:Label ID="lblAName" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Duration</td>
                <td>
                    <asp:Label ID="lblADuration" runat="server"></asp:Label>
                </td>
                <td>Type</td>
                <td>
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
                <td style="text-align: center;" colspan="4">
                    <asp:CheckBox ID="cbInsertPanel" runat="server" Text="Show Insert Question Panel" OnCheckedChanged="cbInsertPanel_CheckedChanged" AutoPostBack="true" />
                    <asp:CheckBox ID="cbRUDPanel" runat="server" Text="Show Edit/Delete Question Panel" OnCheckedChanged="cbRUDPanel_CheckedChanged" AutoPostBack="true" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="panelInsert" runat="server">
        <br />
    <asp:Label ID="lblSuccessInsert" runat="server"></asp:Label>
    <br />
    <asp:Label ID="lblUploadWarning" runat="server"></asp:Label>
    <br />
    <asp:Label ID="lblInsertErrorMsg" runat="server"></asp:Label>
    <br />
        <asp:FormView ID="fvInsertQuestion" runat="server" Width="100%" DataKeyNames="questionID" DefaultMode="Insert" InsertMethod="fvInsertQuestion_InsertItem">
            <InsertItemTemplate>
                <table>
                    <tr>
                        <td width="15%">Question</td>
                        <td>
                            <asp:TextBox ID="txtQName" runat="server" Wrap="true" TextMode="MultiLine" Text='<%# Bind("questionName") %>' Height="50px" Width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Selection / Extra Content</td>
                        <td>
                            <asp:Panel ID="panelSelection" runat="server"></asp:Panel>
                            <asp:Panel ID="PanelWritten" runat="server">
                                <asp:TextBox ID="txtQDesc" Wrap="true" TextMode="MultiLine" runat="server" Text='<%# Bind("questionDesc") %>' Height="50px" Width="100%" />
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="btnAddTB" runat="server" Text="Add Selection" OnClick="btnAddTB_Click" />
                            <asp:Button ID="btnRemoveTB" runat="server" OnClick="btnRemoveTB_Click" Text="Remove Selection" />
                        </td>
                    </tr>
                    <tr>
                        <td>Answer</td>
                        <td>
                            <asp:TextBox ID="txtQAnswer" runat="server" Text='<%# Bind("questionAnswer") %>' Height="20px" Width="20px" MaxLength="1"/>
                        </td>
                    </tr>
                    <tr>
                        <td>Mark</td>
                        <td>
                            <asp:TextBox ID="txtQMark" runat="server" Text='<%# Bind("questionMark") %>' Height="20px" Width="50px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Image</td>
                        <td>
                            <asp:Label ID="lblQImagePath" runat="server" Text='<%# Bind("questionImage") %>'></asp:Label><asp:FileUpload ID="fuQImage" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align:center;">
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                            &nbsp;<asp:LinkButton ID="InsertClearButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Clear" OnClick="InsertClearButton_Click" />
                        </td>
                    </tr>
                </table>
            </InsertItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="dataSrcQuestion" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Questions]"></asp:SqlDataSource>
    </asp:Panel>
    <hr />
    <asp:Panel ID="panelRUD" runat="server">
        <asp:DetailsView ID="dvRUD" runat="server" Height="50px" Width="100%" OnPreRender="dvRUD_PreRender" OnDataBound="dvRUD_DataBound" AutoGenerateRows="False" CellPadding="4" DataKeyNames="questionID" DataSourceID="dataSrcQuestion2" ForeColor="#333333" GridLines="None" AllowPaging="True">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
            <EditRowStyle BackColor="#999999" />
            <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" Width="15%" />
            <Fields>
                <asp:BoundField DataField="questionID" HeaderText="Question ID" InsertVisible="False" ReadOnly="True" Visible="False" SortExpression="questionID" />
                <asp:BoundField DataField="assessmentID" HeaderText="Assessment ID" ReadOnly="True" Visible="False" SortExpression="assessmentID" />
                <asp:BoundField DataField="questionName" HeaderText="Question" SortExpression="questionName" />
                <asp:BoundField DataField="questionDesc" HeaderText="Selection / Extra Content" SortExpression="questionDesc" />
                <asp:BoundField DataField="questionAnswer" HeaderText="Answer" SortExpression="questionAnswer" />
                <asp:BoundField DataField="questionMark" HeaderText="Mark" SortExpression="questionMark" />
                <asp:BoundField DataField="questionImage" HeaderText="Image" ReadOnly="True" SortExpression="questionImage" />
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            </Fields>
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        </asp:DetailsView>
        <asp:SqlDataSource ID="dataSrcQuestion2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="SELECT * FROM [Questions] WHERE (([assessmentID] = @assessmentID))" 
            DeleteCommand="DELETE FROM [Questions] WHERE [questionID] = @questionID" 
            InsertCommand="INSERT INTO [Questions] ([assessmentID], [questionName], [questionDesc], [questionAnswer], [questionImage], [questionMark]) VALUES (@assessmentID, @questionName, @questionDesc, @questionAnswer, @questionImage, @questionMark)" 
            UpdateCommand="UPDATE [Questions] SET [questionName] = @questionName, [questionDesc] = @questionDesc, [questionAnswer] = @questionAnswer, [questionImage] = @questionImage, [questionMark] = @questionMark WHERE [questionID] = @questionID">
            <DeleteParameters>
                <asp:Parameter Name="questionID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="assessmentID" Type="Int32" />
                <asp:Parameter Name="questionName" Type="String" />
                <asp:Parameter Name="questionDesc" Type="String" />
                <asp:Parameter Name="questionAnswer" Type="String" />
                <asp:Parameter Name="questionImage" Type="String" />
                <asp:Parameter Name="questionMark" Type="Int32" />
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
                <asp:Parameter Name="questionMark" Type="Int32" />
                <asp:Parameter Name="questionID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </asp:Panel>
</asp:Content>
