<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewAssessment.aspx.cs" Inherits="OnlineAssessmentSite.Student.ViewAssessment" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Public Assessment</h3>
    <p>
        <asp:DataList ID="DataList1" runat="server"
            DataKeyField="assessmentID" DataSourceID="SqlDataSource1"
            Width="307px" CellPadding="10"
            ForeColor="#333333" OnItemCommand="DataList1_ItemCommand">
            <AlternatingItemStyle BackColor="White" />
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <ItemStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <ItemTemplate>
                <asp:Table runat="server" CellSpacing="10"
                    Width="600px" BorderWidth="0"
                    GridLines="None" BorderStyle="None">
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                            <asp:Label ID="assessmentNameLabel" runat="server" Text='<%# Eval("assessmentName") %>' />
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            Type: 
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("assessmentType") %>' /></span>
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            Duration: 
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="assessmentDurationLabel" runat="server" Text='<%# Eval("assessmentDuration") %>' />
                            minutes
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            Start Date: 
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("assessmentStartDate") %>' />
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            End Date: 
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("assessmentEndDate") %>' />
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            Attempt: 
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("assessmentAttempt") %>' />
                            &nbsp; (<asp:Label ID="Label4" runat="server" Text='<%# Eval("AttemptLeft") %>' />
                            lefts) 
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            Class: 
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("className") %>' />
                            (<asp:Label ID="Label6" runat="server" Text='<%# Eval("classType") %>' />)
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                            <asp:Button ID="btnTakeAssessment" runat="server" Text="Take Assessment" CommandName="Take" CommandArgument='<%# Eval("assessmentID") + "," + Eval("AttemptLeft") %>' />
                        </asp:TableCell></asp:TableRow></asp:Table><br /></ItemTemplate><SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:DataList>
    </p>

<%--        Validation done:
            only assessment with at least one question will be published
            assessmentStartDate <= GetDate
            assessmentEndDate >= GetDate--%>
            

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT X.* 
FROM   (SELECT a.*, 
               (SELECT ( a.assessmentattempt - Isnull(Count(*), 0) ) 
                FROM   attempts 
                WHERE  attempts.userid = @UserId 
                       AND attempts.assessmentid = a.assessmentid) AS 
               attemptleft, 
               c.classname, 
               c.classtype, 
               (SELECT Count(*) 
                FROM   questions 
                WHERE  a.assessmentid = questions.assessmentid)    AS 
               noofquestion 
        FROM   assessments AS a, 
               classes c, 
               collaborations co, 
               aspnet_users au 
        WHERE  a.assessmentid = co.assessmentid 
               AND co.userid = au.userid 
               AND au.userid = c.userid 
               AND ( a.assessmentvisibility = @assessmentVisibility ) 
               AND a.assessmentenddate &gt;= Getdate() 
               AND a.assessmentstartdate &lt;= Getdate()) X 
WHERE  noofquestion &gt; 0">
        <SelectParameters>
            <asp:Parameter Name="UserId" />
            <asp:Parameter DefaultValue="Public" Name="assessmentVisibility" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
        
        <h3>Private Assessment</h3><p>
        <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource2" DataKeyField="assessmentID" CellPadding="4" ForeColor="#333333" OnItemCommand="DataList2_ItemCommand">
            <AlternatingItemStyle BackColor="White" />
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <ItemStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <ItemTemplate>
                <asp:Table runat="server" CellSpacing="10"
                    Width="600px" BorderWidth="1"
                    GridLines="None" BorderStyle="None">
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                            <asp:Label ID="assessmentNameLabel" runat="server" Text='<%# Eval("assessmentName") %>' />
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            Type: 
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("assessmentType") %>' /></span>
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            Duration: 
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="assessmentDurationLabel" runat="server" Text='<%# Eval("assessmentDuration") %>' />
                            minutes
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            Start Date: 
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("assessmentStartDate") %>' />
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            End Date: 
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("assessmentEndDate") %>' />
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            Attempt: 
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("assessmentAttempt") %>' />
                            &nbsp; (<asp:Label ID="Label4" runat="server" Text='<%# Eval("AttemptLeft") %>' />
                            lefts) 
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell HorizontalAlign="Right">
                            Class Name: 
                        </asp:TableCell><asp:TableCell>
                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("className") %>' />
                            (<asp:Label ID="Label6" runat="server" Text='<%# Eval("classType") %>' />)
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                            <asp:Button ID="btnTakeAssessment" runat="server" Text="Take Assessment" CommandName="Take" CommandArgument='<%# Eval("assessmentID") + "," + Eval("AttemptLeft") %>' />
                        </asp:TableCell></asp:TableRow></asp:Table><br /></ItemTemplate><SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        </asp:DataList><asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT X.* 
FROM   (SELECT a.*, 
               (SELECT ( a.assessmentattempt - Isnull(Count(*), 0) ) 
                FROM   attempts 
                WHERE  attempts.userid = @UserId 
                       AND attempts.assessmentid = a.assessmentid) AS 
               AttemptLeft, 
               c.classname, 
               c.classtype, 
               (SELECT Count(*) 
                FROM   questions 
                WHERE  a.assessmentid = questions.assessmentid)    AS 
               noofquestion 
        FROM   assessments a, 
               permissions p, 
               classes c, 
               enrollments e 
        WHERE  a.assessmentid = p.assessmentid 
               AND p.classid = c.classid 
               AND c.classid = e.classid 
               AND a.assessmentvisibility = @assessmentVisibility 
               AND e.userid = @UserId 
               AND a.assessmentenddate &gt;= Getdate() 
               AND a.assessmentstartdate &lt;= Getdate()) X 
WHERE  noofquestion &gt; 0 "><SelectParameters>
                <asp:Parameter DefaultValue="" Name="UserId" />
                <asp:Parameter DefaultValue="Private" Name="assessmentVisibility" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>


    <h3>Expired Assessment</h3><asp:DataList ID="DataList3" runat="server" 
        DataSourceID="SqlDataSource3" DataKeyField="assessmentID"
        CellPadding="4" BackColor="White" BorderColor="#336666" 
        BorderStyle="Double" BorderWidth="3px" GridLines="Horizontal">
        <FooterStyle BackColor="White" ForeColor="#333333" />
        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
        <ItemStyle BackColor="#DCDCDC" ForeColor="#333333" /><ItemTemplate>
            <asp:Table runat="server" CellSpacing="10"
                Width="600px" BorderWidth="1"
                GridLines="None" BorderStyle="None">
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                        <asp:Label ID="assessmentNameLabel" runat="server" Text='<%# Eval("assessmentName") %>' />
                        [<%# Eval("assessmentVisibility") %>]
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell HorizontalAlign="Right">
                            Type: 
                    </asp:TableCell><asp:TableCell>
                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("assessmentType") %>' /></span>
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell HorizontalAlign="Right">
                            Duration: 
                    </asp:TableCell><asp:TableCell>
                        <asp:Label ID="assessmentDurationLabel" runat="server" Text='<%# Eval("assessmentDuration") %>' />
                        minutes
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell HorizontalAlign="Right">
                            Start Date: 
                    </asp:TableCell><asp:TableCell>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("assessmentStartDate") %>' />
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell HorizontalAlign="Right">
                            End Date: 
                    </asp:TableCell><asp:TableCell>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("assessmentEndDate") %>' />
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell HorizontalAlign="Right">
                            Attempt: 
                    </asp:TableCell><asp:TableCell>
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("assessmentAttempt") %>' />
                    </asp:TableCell></asp:TableRow><asp:TableRow>
                    <asp:TableCell HorizontalAlign="Right">
                            Class Name: 
                    </asp:TableCell><asp:TableCell>
                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("className") %>' />
                        (<asp:Label ID="Label6" runat="server" Text='<%# Eval("classType") %>' />)
                    </asp:TableCell></asp:TableRow></asp:Table><br /></ItemTemplate><SelectedItemStyle BackColor="#339966" Font-Bold="True" ForeColor="White" /></asp:DataList><asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT a.assessmentID, a.assessmentName, a.assessmentDuration, a.assessmentType, a.assessmentVisibility, a.assessmentStartDate, a.assessmentEndDate, a.assessmentAttempt, c.className, c.classType 
FROM 
Assessments AS a, Collaborations co, aspnet_Users au, Enrollments e, Classes c
WHERE a.assessmentID = co.assessmentID AND 
  co.UserId = au.UserId AND 
  au.UserId = c.UserId AND 
 c.classID = e.classID AND
 e.UserId = @UserId AND 
  a.assessmentEndDate &lt; GETDATE()">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="UserId" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
