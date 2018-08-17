<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="FoodItem.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div><br /></div>

    <div class="panel panel-default" style="text-align:center">
        <div class="panel-body">
            
            <h4 style="font-weight:bold">商品信息</h4>
           
            <div class="fenge"></div >
          
            <br />
        </div>
        <div class="panel-body" style="border:1px solid #808080;margin:10px;width:70%;margin-left:15%" >
            <div>
            <asp:DataList ID="foodItem" align="Center" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" Height="180px" ImageUrl='<%# Eval("图片路径") %>' Width="300px"/>
                        <br />                  
                        <asp:Label ID="菜名Label" runat="server" Text='<%# Eval("菜名") %>' />
                        <br />
                        <asp:Label ID="种类Label" runat="server" Text='<%# Eval("种类") %>' />
                        <br />
                        价格:
                        <asp:Label ID="价格Label" runat="server" Text='<%# Eval("价格") %>' />元
                        <br />
                        销量:
                        <asp:Label ID="销量Label" runat="server" Text='<%# Eval("销量") %>' />份<br />
                        介绍:
                        <asp:Label ID="介绍Label" runat="server" Text='<%# Eval("介绍") %>' />
                        <br />
                    <asp:Button ID="AddCar" runat="server" class="btn btn-primary" style="float:right;margin-top:10px" Text="加入购物车" CommandName="AddCart"/>
                </ItemTemplate>
            </asp:DataList>
            </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:订餐ConnectionString %>" SelectCommand="SELECT 菜单表.Id, 菜单表.菜名, 菜单表.价格, 菜单表.销量, 菜单表.种类id, 菜单表.图片路径, 菜单表.介绍, 种类表.种类 FROM 菜单表 INNER JOIN 种类表 ON 菜单表.种类id = 种类表.Id WHERE (菜单表.Id = @Id)">
                <SelectParameters>
                    <asp:SessionParameter Name="Id" SessionField="caiId" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="panel-body" style="width:70%;margin-left:15%">
            
                    <h4 style="font-weight:bold">评论区</h4>
           
                    <div class="fenge"></div >
          
                    <br />

                    <asp:DataList ID="Word" runat="server" RepeatLayout="Flow" >
                        <ItemTemplate>
                            <div>
                                <span style="float:left">
                                    评论人:
                                    <asp:Label ID="用户名Label" runat="server" Text='<%# Eval("用户名") %>' />
                                </span>
                                <span style="float:right">
                                    评论时间:
                                    <asp:Label ID="评论时间Label"  runat="server" Text='<%# Eval("评论时间") %>' />
                                </span>
                            </div>
                            <br />
                            <div>
                                <span style="float:left">
                                    评论内容:
                                    <asp:Label ID="评论Label" runat="server" Text='<%# Eval("评论") %>' />
                                </span>
                            </div>
                            <br />
                            <br />

                        </ItemTemplate>
                    </asp:DataList>
                    <br />
                    <br />
                    <div>
                        <textarea id="TextWord" runat="server" cols="40" rows="4"></textarea>
                            <br />
                        <asp:Button ID="AddWord" runat="server" Text="添加评论" style="margin-left:210px" OnClick="AddWord_Click"/>
                    </div>

                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>

