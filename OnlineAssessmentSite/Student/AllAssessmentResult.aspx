<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AllAssessmentResult.aspx.cs" Inherits="OnlineAssessmentSite.Student.AllAssessmentResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Your Assessment Result</h3>
    <p>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1"
            AutoGenerateColumns="False" DataKeyNames="assessmentid" AllowPaging="True"
            Width="500" CellPadding="10">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="assessmentname" HeaderText="Name" SortExpression="assessmentname" />
                <asp:BoundField DataField="assessmentduration" HeaderText="Duration" SortExpression="assessmentduration" />
                <asp:BoundField DataField="assessmenttype" HeaderText="Type" SortExpression="assessmenttype" />
                <asp:BoundField DataField="assessmentattempt" HeaderText="Attempt" SortExpression="assessmentattempt" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT a.assessmentid, 
                a.assessmentname, 
                a.assessmentduration, 
                a.assessmenttype, 
                a.assessmentvisibility, 
                a.assessmentstartdate, 
                a.assessmentenddate, 
                a.assessmentattempt 
FROM   assessments a, 
       attempts at 
WHERE  a.assessmentid = at.assessmentid 
       AND at.userid = @UserId ">
            <SelectParameters>
                <asp:Parameter Name="UserId" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource2">
            <ItemTemplate>
                <asp:Table runat="server" Width="500" CellPadding="10">
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                            Attempt ID: <%# Eval("attemptID") %>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">Start time: </asp:TableCell>
                        <asp:TableCell><%# Eval("attemptStartTime") %></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">End time: </asp:TableCell>
                        <asp:TableCell><%# Eval("attemptEndTime") %></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">Your Score: </asp:TableCell>
                        <asp:TableCell><%# Eval("attemptScore") %></asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ItemTemplate>
        </asp:ListView>
    </p>
    <p>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT at.attemptID, at.assessmentID, at.UserId, at.attemptScore, at.attemptStartTime, at.attemptEndTime
FROM Attempts at, Assessments a
WHERE at.assessmentID = @assessmentID AND
  at.UserId = @UserId">
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView1" Name="assessmentID" PropertyName="SelectedValue" />
                <asp:Parameter Name="UserId" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
