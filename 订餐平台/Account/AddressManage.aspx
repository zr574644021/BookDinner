<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AddressManage.aspx.cs" Inherits="AddressManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div><br /></div>
    <div class="panel panel-default">
        <div class="panel-body">
            
            <h4 style="font-weight:bold">地址编辑</h4>
           
            <div class="fenge"></div >
            <br /> 
                    <asp:ValidationSummary runat="server" CssClass="text-danger" />
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Name" CssClass="col-md-2 control-label">姓名</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="Name" CssClass="form-control" value='<%# Eval("姓名") %>'/>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Name"
                                    CssClass="text-danger" ErrorMessage="请输入姓名" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" style="font-weight:bold" CssClass="col-md-2">性别</asp:Label>
                            <div class="col-md-10">
                                <asp:RadioButton ID="radSex" runat="server"  Text="先生" Checked="true" GroupName="sex"/>
                                <asp:RadioButton ID="radSex2" runat="server" Text="女士" GroupName="sex" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="WeiZhi" CssClass="col-md-2 control-label">位置</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="WeiZhi" CssClass="form-control" value='<%# Eval("位置") %>'/>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="WeiZhi"
                                    CssClass="text-danger" ErrorMessage="请输入位置" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="JTWeiZhi" CssClass="col-md-2 control-label">详细地址</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="JTWeiZhi" CssClass="form-control" value='<%# Eval("详细地址") %>' />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="JTWeiZhi"
                                    CssClass="text-danger" ErrorMessage="请输入详细地址" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Phone" CssClass="col-md-2 control-label" >联系电话</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="Phone" CssClass="form-control" value='<%# Eval("联系电话") %>'/>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Phone"
                                    CssClass="text-danger" ErrorMessage="请输入联系电话" />
                            </div>
                        </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button runat="server" OnClick="Save" Text="保存" CssClass="btn btn-default" />
                            <asp:Button runat="server" OnClick="Delete" Text="删除" CssClass="btn btn-default"/>
                        </div>
                    </div>
    </div>
</asp:Content>

