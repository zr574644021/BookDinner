<%@ Page Title="" Language="C#" MasterPageFile="~/houtai/MasterPage.master" AutoEventWireup="true" CodeFile="LogOut.aspx.cs" Inherits="houtai_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <% Session.Clear(); %>
    <% Response.Redirect("Login"); %>
</asp:Content>

