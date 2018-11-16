<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MaintainAssessment.aspx.cs" Inherits="OnlineAssessmentSite.Lecturer.MaintainAssessment" %>

<asp:Content ID="Content12" ContentPlaceHolderID="ContentPlaceHolder1" runat="server" ClientIDMode="Static">

    <asp:GridView ID="GridViewAsm" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="assessmentID" DataSourceID="DataSrcAssessmentDetails" OnSelectedIndexChanged="GridViewAssessment_SelectedIndexChanged" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" EditText="Edit Assessment Detail" ShowSelectButton="True" />
                    <asp:BoundField DataField="assessmentID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                    <asp:BoundField DataField="assessmentName" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="assessmentDuration" HeaderText="Duration" SortExpression="Duration" />
                    <asp:BoundField DataField="assessmentType" HeaderText="Type" SortExpression="Type" />
                    <asp:BoundField DataField="assessmentVisibility" HeaderText="Visibility" SortExpression="Visibility" />
                    <asp:BoundField DataField="assessmentStartDate" HeaderText="Start Date" SortExpression="Start Date" />
                    <asp:BoundField DataField="assessmentEndDate" HeaderText="End Date" SortExpression="End Date" />
                    <asp:BoundField DataField="Number Of Questions" HeaderText="Number Of Questions" ReadOnly="True" SortExpression="Number Of Questions" />
                </Columns>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <SortedAscendingCellStyle BackColor="#F4F4FD" />
                <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                <SortedDescendingCellStyle BackColor="#D8D8F0" />
                <SortedDescendingHeaderStyle BackColor="#3E3277" />
            </asp:GridView>
            <asp:SqlDataSource ID="DataSrcAssessmentDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                DeleteCommand="DELETE FROM [Assessments] WHERE [assessmentID] = @assessmentID" 
                InsertCommand="INSERT INTO [Assessments] ([assessmentName], [assessmentDuration], [assessmentType], [assessmentVisibility], [assessmentStartDate], [assessmentEndDate]) VALUES (@assessmentName, @assessmentDuration, @assessmentType, @assessmentVisibility, @assessmentStartDate, @assessmentEndDate)" 
                SelectCommand="SELECT A.assessmentID, A.assessmentName, A.assessmentDuration, A.assessmentType, A.assessmentVisibility, A.assessmentStartDate, A.assessmentEndDate, COUNT(Q.questionID) AS &quot;Number of Questions&quot;
FROM [Assessments] A
LEFT JOIN [Questions] Q ON A.assessmentID = Q.assessmentID
GROUP BY A.assessmentID, A.assessmentName, A.assessmentDuration, A.assessmentType, A.assessmentVisibility, A.assessmentStartDate, A.assessmentEndDate;" 
                UpdateCommand="UPDATE [Assessments] SET [assessmentName] = @assessmentName, [assessmentDuration] = @assessmentDuration, [assessmentType] = @assessmentType, [assessmentVisibility] = @assessmentVisibility, [assessmentStartDate] = @assessmentStartDate, [assessmentEndDate] = @assessmentEndDate WHERE [assessmentID] = @assessmentID">
                <DeleteParameters>
                    <asp:Parameter Name="assessmentID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="assessmentName" Type="String" />
                    <asp:Parameter Name="assessmentDuration" Type="Int32" />
                    <asp:Parameter Name="assessmentType" Type="String" />
                    <asp:Parameter Name="assessmentVisibility" Type="String" />
                    <asp:Parameter Name="assessmentStartDate" Type="DateTime" />
                    <asp:Parameter Name="assessmentEndDate" Type="DateTime" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="assessmentName" Type="String" />
                    <asp:Parameter Name="assessmentDuration" Type="Int32" />
                    <asp:Parameter Name="assessmentType" Type="String" />
                    <asp:Parameter Name="assessmentVisibility" Type="String" />
                    <asp:Parameter Name="assessmentStartDate" Type="DateTime" />
                    <asp:Parameter Name="assessmentEndDate" Type="DateTime" />
                    <asp:Parameter Name="assessmentID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            
            <br />
            <asp:Panel ID="panelSelectedAssessment" runat="server">
                What functions you want to perform to assessment &quot; <asp:Label ID="lblSelectedAssessment" runat="server"></asp:Label>
                &quot;?<br />
                <asp:Button ID="btnQuestion" runat="server"  Text="Maintain Question" PostBackUrl="~/Lecturer/MaintainQuestion.aspx" />
                <asp:Button ID="btnPermission" runat="server" Text="Maintain Permission" PostBackUrl="~/Lecturer/MaintainPermission.aspx" />
            </asp:Panel>

</asp:Content>