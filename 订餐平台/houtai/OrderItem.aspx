<%@ Page Title="Contact" Language="C#" MasterPageFile="~/houtai/MasterPage.master" AutoEventWireup="true" CodeFile="OrderItem.aspx.cs" Inherits="OrderItem" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div><br /></div>
    <div class="panel panel-default">
        <div class="panel-body">
            <h4 style="font-weight:bold">订单详情</h4>
            
            <div class="fenge"></div>

            <div style="width:100%">
                <asp:DataList ID="OrderList" runat="server" OnItemCommand="OrderList_ItemCommand" OnItemDataBound="OrderList_ItemDataBound" RepeatLayout="Flow">
                    <ItemTemplate>
                        <div class="ng-scope">
                            <div class="ng-isolate-scope"></div>
                            <div class="orderprogress-card ng-isolate-scope">
                                <div class="orderprogress-status ng-scope">
                                    
                                    <%# Eval("收货状态").ToString() == "已完成" ?
                                            "<h5 class='orderprogress-statustitle ng-binding'>订单已完成</h5>" +
                                            "<p class='orderprogress-statusdesc ng-binding'> "+ Eval("送达时间") + "确认送达</p>":"" %>

                                   <asp:PlaceHolder ID="PlaceHolder2" runat="server" Visible="false">
                                        <h5 class="orderprogress-statustitle ng-binding">订单未完成</h5>
                                        <div class="orderprogress-statusbuttons">
                                            <asp:LinkButton ID="SureSend"  class="btn btn-danger" runat="server" CommandName="SureSend">确认送达</asp:LinkButton>
                                        </div>
                                    </asp:PlaceHolder>
                                    <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="false">
                                        <h5 class="orderprogress-statustitle ng-binding">订单未发货</h5>
                                        <div class="orderprogress-statusbuttons">
                                            <asp:LinkButton ID="SureFaHuo"  class="btn btn-danger" runat="server" CommandName="SureFaHuo">确认发货</asp:LinkButton>
                                        </div>
                                    </asp:PlaceHolder>
                                </div>
                            </div>

                            <div class="ng-isolate-scope">
                                <div class="orderprogress-rstinfo" style="height: 100px;">
                                    <div class="orderprogress-rstgrid">
                                        <h4 class="orderprogress-rstname">
                                            <a class="inherit ng-binding" href="Default">鲜味订餐</a>
                                        </h4>
                                        <div class="orderprogress-rstextra">
                                            订单号：<asp:Label ID="OrderId" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                                        </div>
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
                                        
                                        <asp:DataList ID="FoodList" runat="server" SelectedIndex="0" RepeatLayout="Flow">                                         
                                            <ItemTemplate >                                   
                                                    <div class="orderprogress-totalrow ng-scope">
                                                        <span class="cell name ng-binding"><%# Eval("菜名") %></span>
                                                        <span class="cell quantity ng-binding" ><%# Eval("数量") %></span>
                                                        <span class="cell price ng-binding"><%# Eval("总金额") %></span>
                                                    </div>                                          
                                            </ItemTemplate>
                                        </asp:DataList>

                                        <div class="ng-scope">
                                            <div class="orderprogress-baseline ng-scope"></div>
                                        </div>
                                        <div class="orderprogress-totalactual">实际支付：
                                            <span class="ng-binding"><%# Eval("总金额") %></span>
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
                                                <span class="ng-binding"><%# Eval("送达时间") %></span>
                                            </p>
                                        </div>

                                        <asp:Label ID="PersonId" runat="server" style="display:none" Text='<%# Eval("收货人id") %>'></asp:Label>

                                        <asp:DataList ID="GetPersonList" runat="server">
                                            <ItemTemplate>
                                                <div class="orderprogress-deliverygroup">
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
                                                        <span class="ng-binding"><%# Eval("位置") %>&nbsp;&nbsp;<%# Eval("详细地址") %></span></p>
                                                </div>
                                            </ItemTemplate>
                                        </asp:DataList>

                                        <div class="orderprogress-deliverygroup tail">
                                            <p>
                                                <span class="orderprogress-deliverykey">备 注：</span> 
                                                <span class="ng-binding"><%# Eval("订单备注") %></span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="orderprogress-roundborder"></div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function SureSend()
        {
           
        }
    </script>
</asp:Content>
