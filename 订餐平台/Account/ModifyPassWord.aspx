<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ModifyPassWord.aspx.cs" Inherits="Account_ModifyPassWord" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2>修改密码</h2>
    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
        <p class="text-danger">
            <asp:Literal runat="server" ID="FailureText" />
        </p>
    </asp:PlaceHolder>
    <div class="form-horizontal">
        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
        <div class="form-group">
            <asp:Label runat="server" ID="CurrentPasswordLabel" AssociatedControlID="CurrentPassword" CssClass="col-md-2 control-label">当前密码</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="CurrentPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword"
                    CssClass="text-danger" ErrorMessage="“当前密码”字段是必填字段。"
                    ValidationGroup="ChangePassword" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" ID="NewPasswordLabel" AssociatedControlID="NewPassword" CssClass="col-md-2 control-label">新密码</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="NewPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword"
                    CssClass="text-danger" ErrorMessage="必须填写新密码。"
                    ValidationGroup="ChangePassword" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" ID="ConfirmNewPasswordLabel" AssociatedControlID="ConfirmNewPassword" CssClass="col-md-2 control-label">确认新密码</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmNewPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="“确认新密码”字段是必填字段。"
                    ValidationGroup="ChangePassword" />
                <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="新密码和确认密码不匹配。"
                    ValidationGroup="ChangePassword" />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" Text="修改密码" OnClick="ChangePassword_Click" CssClass="btn btn-default" ValidationGroup="ChangePassword" />
            </div>
        </div>
    </div>
</asp:Content>