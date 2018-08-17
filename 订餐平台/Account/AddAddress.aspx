<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AddAddress.aspx.cs" Inherits="AddAddress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <style>
        .fenge
        {
             height:1px;
             border:none;
             border-bottom:1px solid #ddd;
        }
        .button-width 
        {
            width:40px;
        }
        .linkButton 
        {
            color:#bbb;
        }
        .linkButton:hover
        {
            color:#0089dc;
        }
    </style>

    <div><br /></div>
    <div class="panel panel-default">
        <div class="panel-body">
            <h4 style="font-weight:bold">地址管理</h4>

            <div class="fenge"></div>  
            
            <div class="profile-panelcontent">
                <div class="desktop-addresslist clearfix ng-scope" style="margin-left:85px">
                    <asp:DataList ID="AddressList" runat="server" RepeatLayout="Flow" DataSourceID="地址DataSource" OnItemDataBound="AddressList_ItemDataBound" OnItemCommand="AddressList_ItemCommand" RepeatDirection="Horizontal">
                        <ItemTemplate>
                            <div class="desktop-addressblock ng-scope">
                                <div class="desktop-addressblock-buttons">
                                    <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="false">
                                    <asp:Label ID="AddressId" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                                    </asp:PlaceHolder>
                                    <asp:LinkButton ID="Update" class="linkButton"  style="text-decoration:none" runat="server" CommandName="Manage">编辑操作</asp:LinkButton>
                                    <!--<asp:LinkButton ID="Delete" class="linkButton"  style="text-decoration:none" type="button" CausesValidation="false" runat="server" data-toggle="modal" data-target="#deleteAddress" CommandName="delete">删除</asp:LinkButton>-->
                                </div>
                                <div class='desktop-addressblock-name ng-binding'><%# Eval("姓名") %><span class='ng-binding'><%# Eval("性别") %></span></div>
                                <div class='desktop-addressblock-address ng-binding' ><%# Eval("位置") %> <%# Eval("详细地址") %></div> 
                                <div class='desktop-addressblock-mobile ng-binding' ><%# Eval("联系电话") %></div>
                            </div>
                        </ItemTemplate>
                        <SelectedItemTemplate></SelectedItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="地址DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:订餐ConnectionString %>" SelectCommand="SELECT * FROM [收货人表] WHERE ([用户id] = @用户id)">
                        <SelectParameters>
                            <asp:SessionParameter Name="用户id" SessionField="ID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                  
                    <button class="desktop-addressblock desktop-addressblock-addblock" type="button" data-toggle="modal" data-target="#addAddress">
                        <span class="glyphicon glyphicon-plus"></span>添加新地址</button>
                </div>            
            </div>         

            <!-- 添加地址弹框 -->
            <div class="modal fade" id="addAddress" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="addModalLabel">添加新地址</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <asp:Label runat="server" CssClass="col-md-2 control-label">姓名</asp:Label>
                                    <div class="col-md-10">
                                        <asp:TextBox runat="server" ID="Name" CssClass="form-control" />
                                        <!--<asp:RequiredFieldValidator runat="server" ControlToValidate="Name"
                                            CssClass="text-danger" ErrorMessage="请输入姓名" />-->
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:Label runat="server" style="padding-bottom:7px;margin-bottom: 0;text-align: right;font-weight:bold" CssClass="col-md-2">性别</asp:Label>
                                    <div class="col-md-10">
                                        <asp:RadioButton ID="radSex" runat="server"  Text="先生" Checked="true" GroupName="sex"/>
                                        <asp:RadioButton ID="radSex2" runat="server" Text="女士" GroupName="sex" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:Label runat="server"  CssClass="col-md-2 control-label">位置</asp:Label>
                                    <div class="col-md-10">
                                        <asp:TextBox runat="server" ID="Address" CssClass="form-control" />
                                        <!--<asp:RequiredFieldValidator runat="server" ControlToValidate="Address" CssClass="text-danger" ErrorMessage="请输入位置" />-->
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:Label runat="server"  CssClass="col-md-2 control-label">详细地址</asp:Label>
                                    <div class="col-md-10">
                                        <asp:TextBox runat="server" ID="DetaAddress" CssClass="form-control" />
                                        <!--<asp:RequiredFieldValidator runat="server" ControlToValidate="DetaAddress" CssClass="text-danger" ErrorMessage="请输入详细地址" />-->
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:Label runat="server" CssClass="col-md-2 control-label">联系电话</asp:Label>
                                    <div class="col-md-10">
                                        <asp:TextBox runat="server" ID="Phone" CssClass="form-control" />
                                        <!--<asp:RequiredFieldValidator runat="server" ControlToValidate="Phone" CssClass="text-danger" ErrorMessage="请输入电话号" />-->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <asp:Button ID="Add" runat="server" class="btn btn-primary" OnClick="Add_Click" Text="保存" />
                        </div>
                    </div>
                </div>
            </div>   

            <!-- 修改地址弹框 
            <div class="modal fade" id="updateAddress" tabindex="-1" role="dialog" aria-labelledby="upModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="upModalLabel">修改地址</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="newName" CssClass="col-md-2 control-label">姓名</asp:Label>
                                    <div class="col-md-10">
                                        <asp:TextBox runat="server" ID="newName" CssClass="form-control" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Name"
                                            CssClass="text-danger" ErrorMessage="请输入姓名" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:Label runat="server" style="padding-bottom:7px;margin-bottom: 0;text-align: right;font-weight:bold" CssClass="col-md-2">性别</asp:Label>
                                    <div class="col-md-10">
                                        <asp:RadioButton ID="newRadSex" runat="server"  Text="先生" Checked="true" GroupName="newSex"/>
                                        <asp:RadioButton ID="newRadSex2" runat="server" Text="女士" GroupName="newSex" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="newAddress" CssClass="col-md-2 control-label">位置</asp:Label>
                                    <div class="col-md-10">
                                        <asp:TextBox runat="server" ID="newAddress" CssClass="form-control" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Address" CssClass="text-danger" ErrorMessage="请输入位置" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="newDetaAddress" CssClass="col-md-2 control-label">详细地址</asp:Label>
                                    <div class="col-md-10">
                                        <asp:TextBox runat="server" ID="newDetaAddress" CssClass="form-control" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="DetaAddress" CssClass="text-danger" ErrorMessage="请输入详细地址" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="newPhone" CssClass="col-md-2 control-label">联系电话</asp:Label>
                                    <div class="col-md-10">
                                        <asp:TextBox runat="server" ID="newPhone" CssClass="form-control" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Phone" CssClass="text-danger" ErrorMessage="请输入电话号" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <asp:Button ID="Update" runat="server" class="btn btn-primary" OnClick="Update_Click" Text="保存" />
                        </div>
                    </div>
                </div>
            </div>-->

            <!-- 删除地址弹框 
            <div class="modal fade" id="deleteAddress" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body" style="text-align:center"><span style="font-size:20px">是否确认删除该地址?</span></div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <!--<button type="button" class="btn btn-primary">确认</button>
                            <asp:Button ID="Delete" runat="server" class="btn btn-primary" Text="确认" OnClick="Delete_Click" />
                        </div>
                    </div>
                </div>
            </div>-->
                       
        </div>
    </div>
</asp:Content>

    