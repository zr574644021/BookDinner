<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="BuyCar.aspx.cs" Inherits="BuyCar" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div><br /></div>
    <div class="panel panel-default">
        <div class="panel-body">
            
            <h4 style="font-weight:bold">购物车</h4>
           
            <div class="fenge"></div >
          
            <br />   

            <div>
                <div class="ng-isolate-scope">
                    <div class="orderprogress-rstinfo" style="height: 100px;">
                        <div class="orderprogress-rstgrid">
                            <h4 class="orderprogress-rstname" style="margin-top:20px">
                                <span class="inherit ng-binding" style="font-size:20px;font-weight:bold">购物车详情</span>
                            </h4>
                        </div>
                    </div>
                </div>

                <div class="orderprogress-cardtable">
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
                            <div class="orderprogress-totalactual">实际支付：
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
                    <div class="orderprogress-cardcell rightside ng-isolate-scope">
                        <div class="orderprogress-deliveryinfo">
                            <h5 class="orderprogress-deliverytitle">配送信息</h5>
                            <div class="orderprogress-deliverygroup">
                                <p>
                                    <span class="">配送方式：</span> 
                                    <span class="ng-binding">商家配送</span>
                                </p>
                                <p>
                                    <span class="">送达时间：</span>
                                    <span class="ng-binding">40分钟左右</span>
                                </p>
                            </div>
                            <asp:UpdatePanel ID="UpdatePanel5" runat="server"><ContentTemplate>
                            收货地址：<asp:DropDownList ID="AddressId" runat="server" AutoPostBack="True" DataSourceID="AddressDataSource" DataTextField="收货地址" DataValueField="Id" Width="353px" >
                            </asp:DropDownList></ContentTemplate></asp:UpdatePanel>
                            <asp:SqlDataSource ID="AddressDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:订餐ConnectionString %>" SelectCommand="SELECT 姓名 + 联系电话 + 位置 + 详细地址 AS 收货地址, Id FROM 收货人表 WHERE (用户id = @用户id)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="用户id" SessionField="Id" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:DataList ID="GetPersonList" runat="server" DataSourceID="地址详细信息">
                                <ItemTemplate>
                                    <!--<div class="orderprogress-deliverygroup">-->
                                     <asp:UpdatePanel ID="UpdatePanel5"  class="orderprogress-deliverygroup" runat="server">
                                        <ContentTemplate>
                                        <p>
                                            <span class="">联 系 人：</span> 
                                            <span class="ng-binding"><%# Eval("姓名") %>(<%# Eval("性别") %>)</span>
                                        </p>
                                        <p>
                                            <span class="">联系电话：</span> 
                                            <span class="ng-binding"><%# Eval("联系电话") %></span>
                                        </p>
                                        <p>
                                            <span class="">收货地址：</span> 
                                            <span class="ng-binding"><%# Eval("位置") %>&nbsp;&nbsp;<%# Eval("详细地址") %></span>
                                        </p>
                                    <!--</div>-->
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </ItemTemplate>
                            </asp:DataList>

                            <asp:SqlDataSource ID="地址详细信息" runat="server" ConnectionString="<%$ ConnectionStrings:订餐ConnectionString %>" SelectCommand="SELECT * FROM [收货人表] WHERE ([Id] = @Id)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="AddressId" Name="Id" PropertyName="SelectedValue" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                            <div class="orderprogress-deliverygroup tail">
                                <div>
                                    <span class="">备 注：</span> 
                                    <span class="ng-binding"><textarea id="TextArea1" runat="server" cols="40" rows="4"></textarea></span>
                                </div>

                                <div style="float:right;margin-bottom:20px">
                                    <asp:LinkButton ID="SureSend"  class="btn btn-primary" runat="server" OnClick="SureSend_Click">确认下单</asp:LinkButton>
                                    <asp:LinkButton ID="Empty"  class="btn btn-danger" runat="server" OnClick="Empty_Click">清空</asp:LinkButton>
                                </div>                            
                            </div>
                        </div>
                    </div>
                </div>
                <div class="orderprogress-roundborder"></div>
            </div>
        </div>
    </div>
</asp:Content>
