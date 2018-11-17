<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TakeAssessment.aspx.cs" Inherits="OnlineAssessmentSite.Student.TakeAssessment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .container {
            text-align: center;
            width: 100%;
        }

        .button {
            background-color: #4CAF50; /* Green */
            border: none;
            color: white;
            padding: 10px 26px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            -webkit-transition-duration: 0.4s; /* Safari */
            transition-duration: 0.4s;
            cursor: pointer;
        }

        .button1 {
            background-color: white;
            color: black;
            border: 2px solid #4CAF50;
        }

        .button2 {background-color: #f44336;}

            .button1:hover {
                background-color: #4CAF50;
                color: white;
            }

        .tablink {
            background-color: #555;
            color: black;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            padding: 10px;
            font-size: 17px;
            width: 15%;
        }

            .tablink:hover {
                background-color: #777;
            }

        /* Style the tab content */
        .tabcontent {
            display: none;
            padding: 50px;
        }

        div{
            overflow: visible;
        }
    </style>

    <h3>
        <asp:Label ID="lblName" runat="server"></asp:Label></h3>
    <asp:PlaceHolder ID="plhBtn" runat="server"></asp:PlaceHolder>
    <br />
    <asp:PlaceHolder runat="server" ID="plh"></asp:PlaceHolder>
    <br />


    <script type="text/javascript">
        function openPage(page) {
            var i, tabcontent;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            document.getElementById(page).style.display = "block";
        }
        // Get the element with id="defaultOpen" and click on it
        function defaultPage () {
            document.getElementById("ContentPlaceHolder1_page1").click();
        };
    </script>

    <asp:Button ID="btnQuit" runat="server" Text="Quit" 
        CssClass="button button2"  OnClick="btnQuit_Click" 
        OnClientClick="alert('Are you sure want to quit the assessment?\nYour answer will be recorded.')"/>

</asp:Content>
