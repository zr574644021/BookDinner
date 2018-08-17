<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Order.aspx.cs" Inherits="Order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <style>
        td
        {
            text-align:center;
        }

    </style>

        <div><br /></div>
    <div class="panel panel-default">
        <div class="panel-body">
            
            <h4 style="font-weight:bold">订单信息</h4>
           
            <div class="fenge"></div >
            
            <br />   
            <div class="profile-panelcontent">   
                <table class="order-list" style="text-align:center">
                    <thead>
                        <tr>
                            <th style="width:90px">下单时间</th>
                            <th class="order-list-infoth" style="width:500px">订单内容</th>                                    
                            <th style="width:150px">支付金额（元）</th>
                            <th style="width:150px">状态</th>
                            <th style="width:150px">操作</th>
                        </tr>
                    </thead>
                <asp:DataList ID="OrderList" style="width:100%"  runat="server" OnItemCommand="OrderList_ItemCommand" OnItemDataBound="OrderList_ItemDataBound">
                    <ItemTemplate>                           
                            <tbody>
                                <tr class="timeline">
                                    <td class="ordertimeline-time" style="width:90px">
                                        <p class="ng-binding"><%# Eval("下单时间") %></p><i class="ordertimeline-time-icon icon-uniE65E finish ng-scope"></i>
                                    </td>
                                    <td class="ordertimeline-info" style="width:500px">                                        
                                        <span style="padding-left:5%;font-size:14px;">订单号:</span><asp:Label ID="OrderId" runat="server" style="font-size:14px;" Text='<%# Eval("Id") %>'></asp:Label>
                                        <br/>
                                        <span style="padding-left:5%;font-size:14px;">菜&nbsp;&nbsp;&nbsp;&nbsp;名:</span>
                                        <asp:DataList ID="ItemList" runat="server" SelectedIndex="0" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                            <ItemTemplate>
                                                <span style="font-size:14px;">&nbsp;&nbsp;<%# Eval("菜名") %></span>                                                                                           
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </td>
                                    <td class="ordertimeline-amount" style="width:150px">
                                        <p class="ordertimeline-title ordertimeline-price ui-arial ng-binding" ><%# Eval("总金额") %></p>
                                    </td>
                                    <td class="ordertimeline-status" style="width:150px">
                                        <p class="ng-binding end" style="font-size:16px;" >
                                            <asp:Label ID="Status" runat="server" Text='<%# Eval("收货状态") %>'></asp:Label></p>
                                    </td>
                                    <td class="ordertimeline-handle" style="width:150px">
                                        <asp:LinkButton ID="ToOrderItem" class="ordertimeline-handle-detail" style="margin-bottom:10px;text-decoration:none;background:white" runat="server" CommandName="Item">订单详情</asp:LinkButton>
                                        <br />
                                        <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="false">
                                            <asp:LinkButton ID="Sure" class="btn-danger" style="width:78px;height:26px;text-decoration:none;" runat="server" CommandName="SendSure">确认送达</asp:LinkButton>
                                        </asp:PlaceHolder>

                                        <asp:PlaceHolder ID="PlaceHolder2" runat="server" Visible="false">
                                            <asp:LinkButton ID="Exit" class="btn-danger" style="width:78px;height:26px;text-decoration:none;" runat="server" CommandName="Exit">退单</asp:LinkButton>
                                        </asp:PlaceHolder>
                                    </td>
                                </tr>
                            </tbody>                                           
                    </ItemTemplate>
                </asp:DataList> 
                </table>
            </div>
        </div>
    </div>
</asp:Content>

