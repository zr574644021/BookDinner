<%@ Page Title="" Language="C#" MasterPageFile="~/houtai/MasterPage.master" AutoEventWireup="true" CodeFile="AddType.aspx.cs" Inherits="AddType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div><br /></div>
    <div class="panel panel-default">
        <div class="panel-body">
            
            <h4 style="font-weight:bold">添加菜品分类</h4>
           
            <div class="fenge"></div >
            <br /> 


            <div class="form-horizontal">
                <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                    <p class="text-danger">
                        <asp:Literal runat="server" ID="FailureText" />
                    </p>
                </asp:PlaceHolder>
                <asp:ValidationSummary runat="server" CssClass="text-danger" />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="CaiType" CssClass="col-md-2 control-label">种类</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="CaiType" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="CaiType"
                            CssClass="text-danger" ErrorMessage="请输入菜名" />
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button runat="server" OnClick="Unnamed_Click" Text="添加" CssClass="btn btn-default" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

