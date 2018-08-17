<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="LogOut.aspx.cs" Inherits="LogOut" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <% Session.Clear(); %>
    <% Response.Redirect("~/Default"); %>
</asp:Content>

