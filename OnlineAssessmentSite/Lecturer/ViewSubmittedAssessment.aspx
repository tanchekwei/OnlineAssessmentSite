<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" EnableViewState="true" CodeBehind="ViewSubmittedAssessment.aspx.cs" Inherits="OnlineAssessmentSite.Lecturer.MarkAssessment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function updateLabel() {
            var e = document.getElementById("ContentPlaceHolder1_DropDownList1");
            document.getElementById('ContentPlaceHolder1_lblAssessmentName').innerHTML = e.options[e.selectedIndex].text;
        }

        window.onload = function () {
            updateLabel();
        };
    </script>

    <p>
        Assessment Name:
        <asp:DropDownList ID="DropDownList1" runat="server" EnableViewState="true" DataSourceID="SqlDataSource1" DataTextField="assessmentName" DataValueField="assessmentID" Height="22px" Width="400px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
        </asp:DropDownList>
        &nbsp;*only able to mark written type assessment.<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [assessmentID], [assessmentName] FROM [Assessments] WHERE ([assessmentType] = @assessmentType)">
            <SelectParameters>
                <asp:Parameter DefaultValue="WRT" Name="assessmentType" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        List of student completed
        <asp:Label ID="lblAssessmentName" runat="server"></asp:Label>
        :
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource2"
            AutoGenerateColumns="False" Width="800px" CellPadding="10" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" GridLines="Horizontal" OnRowCommand="GridView1_RowCommand">
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <Columns>
                <asp:TemplateField HeaderText="No.">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                <asp:BoundField DataField="attemptStartTime" HeaderText="Attempt Start Time" 
                    SortExpression="attemptStartTime" DataFormatString="{0:hh:mm tt dd/MM/yyyy}">
                </asp:BoundField>
                <asp:BoundField DataField="attemptEndTime" HeaderText="Attempt End Time" SortExpression="attemptEndTime" DataFormatString="{0:hh:mm tt dd/MM/yyyy}"></asp:BoundField>
<%--                <asp:BoundField DataField="TimeTaken" HeaderText="Time Taken<br/>(minutes)" ReadOnly="True" SortExpression="TimeTaken" DataFormatString="{0: minutes}"></asp:BoundField>--%>

                <asp:TemplateField HeaderText="Time Taken<br/>(hh:mm:ss)" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# String.Format("{0:00}", Eval("HourPart")) %>:
                        <%# String.Format("{0:00}", Eval("MinutePart")) %>:
                        <%# String.Format("{0:00}", Eval("SecondPart")) %>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Operation" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Button runat="server" Text="Mark" ID="btnMark" CommandName="Mark" 
                            CommandArgument='<%# Eval("assessmentID") + "," + 
                                Eval("attemptID") + "," + Eval("UserId") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
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
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="
SELECT up.Name, at.attemptStartTime, at.attemptEndTime, at.attemptID, at.assessmentID, at.UserId,
 DATEDIFF(HOUR, at.attemptStartTime, at.attemptEndTime) AS HourPart, 
 DATEDIFF(MINUTE, at.attemptStartTime, at.attemptEndTime)%60 AS MinutePart,
 DATEDIFF(SECOND, at.attemptStartTime, at.attemptEndTime)%60 AS SecondPart
FROM Assessments a, Attempts at, aspnet_Users au, UserProfiles up
WHERE a.assessmentID = at.assessmentID AND
 at.UserId = au.UserId AND
 au.UserId = up.UserId AND
 at.assessmentID = @assessmentID AND
 at.attemptEndTime IS NOT NULL
GROUP BY up.Name, at.attemptStartTime, at.attemptEndTime, at.attemptID, at.assessmentID, at.UserId">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="assessmentID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
