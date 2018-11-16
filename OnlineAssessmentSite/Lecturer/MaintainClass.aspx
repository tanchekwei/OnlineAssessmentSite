<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MaintainClass.aspx.cs" Inherits="OnlineAssessmentSite.Lecturer.MaintainClass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="GridView1" runat="server" 
        AutoGenerateColumns="False" DataKeyNames="classID" 
        DataSourceID="SqlDataSource1" BackColor="White" 
        BorderColor="#E7E7FF" BorderStyle="None" 
        BorderWidth="1px" CellPadding="10" 
        GridLines="Horizontal">
        <AlternatingRowStyle BackColor="#F7F7F7" />
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
            <asp:BoundField DataField="classID" HeaderText="Class ID" InsertVisible="False" ReadOnly="True" SortExpression="classID" />
            <asp:BoundField DataField="className" HeaderText="Class Name" SortExpression="className" />
            <asp:BoundField DataField="classCode" HeaderText="Class Code" SortExpression="classCode" ReadOnly="true" />
            <asp:BoundField DataField="classType" HeaderText="Class Type" SortExpression="classType" />
            <asp:BoundField DataField="classSession" HeaderText="Class Session" SortExpression="classSession" />
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

    <br />

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Classes] WHERE [classID] = @classID" InsertCommand="INSERT INTO [Classes] ([UserId], [className], [classCode], [classType], [classSession]) VALUES (@UserId, @className, @classCode, @classType, @classSession)" SelectCommand="SELECT * FROM [Classes] WHERE ([UserId] = @UserId)" UpdateCommand="UPDATE [Classes] SET [UserId] = @UserId, [className] = @className, [classCode] = @classCode, [classType] = @classType, [classSession] = @classSession WHERE [classID] = @classID">
        <SelectParameters>
            <asp:Parameter Name="UserId" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="classID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="UserId" Type="Object" />
            <asp:Parameter Name="className" Type="String" />
            <asp:Parameter Name="classCode" Type="String" />
            <asp:Parameter Name="classType" Type="String" />
            <asp:Parameter Name="classSession" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserId" Type="Object" />
            <asp:Parameter Name="className" Type="String" />
            <asp:Parameter Name="classCode" Type="String" />
            <asp:Parameter Name="classType" Type="String" />
            <asp:Parameter Name="classSession" Type="String" />
            <asp:Parameter Name="classID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:DetailsView ID="DetailsView1" runat="server"
        DataSourceID="SqlDataSource2" Height="50px" 
        Width="550px" AutoGenerateRows="False" 
        DataKeyNames="classID" BackColor="White" 
        BorderColor="#E7E7FF" BorderStyle="None" 
        BorderWidth="1px" CellPadding="10" 
        GridLines="Horizontal">
        <AlternatingRowStyle BackColor="#F7F7F7" />
        <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        <Fields>
            <asp:BoundField DataField="classID" HeaderText="Class ID:"
                InsertVisible="False" ReadOnly="True"
                SortExpression="classID" HeaderStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="className" HeaderText="Class Name:"
                SortExpression="className" HeaderStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="classCode" HeaderText="Class Code:"
                SortExpression="classCode" HeaderStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="classType" HeaderText="Class Type:"
                SortExpression="classType" HeaderStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="classSession" HeaderText="Class Session:"
                SortExpression="classSession" HeaderStyle-HorizontalAlign="Right" />
            <asp:BoundField DataField="NoOfStudent" HeaderText="Number of Students:"
                ReadOnly="True" SortExpression="NoOfStudent" HeaderStyle-HorizontalAlign="Right" />
        </Fields>
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
    </asp:DetailsView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT *,
 (SELECT COUNT(*)
  FROM Enrollments
  WHERE classID = @classID) AS NoOfStudent
FROM Classes
WHERE classID = @classID">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="classID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    List of student in the class:<br />
    <br />
    <asp:GridView ID="GridView2" runat="server"
        AllowPaging="True" DataSourceID="SqlDataSource3"
        BackColor="White" BorderColor="#E7E7FF"
        BorderStyle="None" BorderWidth="1px"
        CellPadding="10" GridLines="Horizontal" 
        AutoGenerateColumns="False" Width="550px" 
        OnRowCommand="GridView2_RowCommand">
        <AlternatingRowStyle BackColor="#F7F7F7" />
        <Columns>
            <asp:BoundField DataField="UserId" SortExpression="UserId" Visible="false" />
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            <asp:BoundField DataField="Dob" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Dob" SortExpression="Dob" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btunRemove" runat="server" CommandName="DeleteStud" CommandArgument='<%#Eval("UserId")%>' Text="Remove"></asp:Button>

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
    <br />
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="
        SELECT u.UserId, up.Name, u.Email, up.Dob 
        FROM UserProfiles up, aspnet_Membership u, Enrollments e 
        WHERE up.UserId = u.UserId AND 
        e.UserId = u.UserId AND 
        e.classId = @classId">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="classId" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
</asp:Content>
