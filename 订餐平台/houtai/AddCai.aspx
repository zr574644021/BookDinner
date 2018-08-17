<%@ Page Title="" Language="C#" MasterPageFile="~/houtai/MasterPage.master" AutoEventWireup="true" CodeFile="AddCai.aspx.cs" Inherits="AddCai" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div><br /></div>
    <div class="panel panel-default">
        <div class="panel-body">
            
            <h4 style="font-weight:bold">添加菜品</h4>
           
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
                    <asp:Label runat="server" AssociatedControlID="CaiName" CssClass="col-md-2 control-label">菜名</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="CaiName" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="CaiName"
                            CssClass="text-danger" ErrorMessage="请输入菜名" />
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="Price" CssClass="col-md-2 control-label">价格</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="Price" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Price"
                            CssClass="text-danger" ErrorMessage="请输入价格" />
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" CssClass="col-md-2 control-label">种类</asp:Label>
                    <div class="col-md-10">
                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="种类" DataValueField="Id"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:订餐ConnectionString %>" SelectCommand="SELECT * FROM [种类表] WHERE ([status] = @status)">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="0" Name="status" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="Root" CssClass="col-md-2 control-label">图片路径</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="Root" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Root"
                            CssClass="text-danger" ErrorMessage="请输入图片路径" />
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="TextWord" CssClass="col-md-2 control-label">介绍</asp:Label>
                    <div class="col-md-10">
                        <textarea id="TextWord" class="form-control" runat="server" cols="40" rows="4"></textarea>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextWord"
                            CssClass="text-danger" ErrorMessage="请输入介绍" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <asp:Button runat="server" OnClick="Unnamed_Click" Text="添加" CssClass="btn btn-default" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

