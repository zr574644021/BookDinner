<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>      
    .side-bar 
    {
        width: 400px;
        position: fixed;
        bottom: 20px;
        right: 25px;
        z-index: 100;

    } 

    </style>

    <br />
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="left" style="float:left;width:50%">
                    食物分类：
                    <asp:DropDownList ID="FoodType" runat="server" Height="34px"  DataSourceID="订餐Source" DataTextField="种类" DataValueField="Id" AutoPostBack="True" OnSelectedIndexChanged="FoodType_SelectedIndexChanged">
                        <asp:ListItem Value="全部"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="订餐Source" runat="server" ConnectionString="<%$ ConnectionStrings:订餐ConnectionString %>" SelectCommand="SELECT [Id], [种类] FROM [种类表]"></asp:SqlDataSource>
                </div>
            
                <div class="input-group" style="width:50%;">
                    <asp:TextBox runat="server" ID="FoodName" CssClass="form-control" style="float:right" placeholder="搜索美食" aria-describedby="basic-addon2"/>                
                    <span class="input-group-btn">                
                        <asp:Button ID="Search" runat="server" class="btn btn-default" type="button" Text="搜索" OnClick="Search_Click" />
                    </span>
                </div>
            </div>
        </div>

        <div class="panel panel-default" style="width:100%;text-align:center">
            <div class="panel-body">            
                <asp:DataList ID="FoodList" runat="server" style="text-align:center;margin-left:34px" RepeatColumns="3" OnItemCommand="FoodList_ItemCommand">                      
                    <ItemTemplate>
                        <div class="panel-body" style="border:1px solid #808080;margin:10px" >
                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="foodItem"><asp:Image ID="Image1" runat="server" Height="180px" ImageUrl='<%# Eval("图片路径") %>' Width="300px"/></asp:LinkButton>
                        <br />
                        <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="false">
                        <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        </asp:PlaceHolder>
                        <asp:Label ID="菜名Label" runat="server" Text='<%# Eval("菜名") %>' />
                        <br />
                        介绍:
                        <asp:Label ID="介绍Label" runat="server" Text='<%# Eval("介绍") %>' />
                        <br />
                        价格:
                        <asp:Label ID="价格Label" runat="server" Text='<%# Eval("价格") %>' />元
                        <br />
                        销量:
                        <asp:Label ID="销量Label" runat="server" Text='<%# Eval("销量") %>' />份<br />
                            <asp:Button ID="AddCar" runat="server" class="btn btn-primary" style="float:right" Text="加入购物车" CommandName="AddCart"/>
                        </div>
                    </ItemTemplate>            
                </asp:DataList>
            </div>
        </div>

        <div class="side-bar" style="height:auto"> 
            <div class="orderprogress-cardcell ng-isolate-scope" >
                        <div class="orderprogress-total">
                            <div class="orderprogress-totalrow orderprogress-totaltitle" style="margin-bottom:5px">
                                <span style="height:60px" class="cell name">菜品</span>
                                <span style="height:60px" class="cell quantity">数量</span> 
                                <span style="height:60px" class="cell price">小计（元）</span>
                            </div>
                                        
                            <asp:DataList ID="ShopCartList" runat="server" SelectedIndex="0" RepeatLayout="Flow" OnItemCommand="ShopCartList_ItemCommand">                                         
                                <ItemTemplate >                    
                                    <div class="orderprogress-totalrow ng-scope">
                                        <span class="cell name ng-binding">
                                            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                <ContentTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("菜名") %>'></asp:Label>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            </span>
                                        <asp:UpdatePanel ID="UpdatePanel1"  style="width:78px" runat="server">
                                            <ContentTemplate>                                                                                           
                                                   <asp:Button ID="Cut" runat="server" style="float:left" Text="-" CommandName="SendCut"/>                                              
                                                   <asp:TextBox ID="TextBox1" runat="server" style="width:30px;margin-left:1.5px"  Text='<%# Eval("数量") %>'></asp:TextBox>                                                  
                                                   <asp:Button ID="Add" runat="server" style="float:right" Text="+" CommandName="SendAdd"/>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>                                                  
                                        <span class="cell price ng-binding">
                                        <asp:UpdatePanel ID="UpdatePanel2" style="float:right;display:inline;margin-bottom:10px" runat="server">
                                            <ContentTemplate>
                                                <%# float.Parse(Eval("金额").ToString()) * int.Parse(Eval("数量").ToString()) %>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        </span>
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                            <div class="ng-scope">
                                <div class="orderprogress-baseline ng-scope"></div>
                            </div>
                            <div class="orderprogress-totalactual">
                                <div style="float:left;margin-left:15px">
                                    <asp:LinkButton ID="Result"  class="btn btn-primary" runat="server" OnClick="Result_Click">结账</asp:LinkButton>
                                    <asp:LinkButton ID="Empty" style="margin-left:15px" class="btn btn-danger" runat="server" OnClick="Empty_Click">清空</asp:LinkButton>
                                </div>           
                                实际支付：
                                <asp:Label ID="FinalPay" class="ng-binding" runat="server">
                                    <asp:UpdatePanel ID="UpdatePanel3" style="display:inline-block" runat="server">
                                        <ContentTemplate>
                                            <%: Session["AllPay"] %>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </asp:Label>
                            </div>
                        </div>
                    </div>
        </div> 
        </ContentTemplate>
    </asp:UpdatePanel>


</asp:Content>
