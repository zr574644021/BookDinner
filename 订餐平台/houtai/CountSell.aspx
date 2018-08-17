<%@ Page Title="" Language="C#" MasterPageFile="~/houtai/MasterPage.master" AutoEventWireup="true" CodeFile="CountSell.aspx.cs" Inherits="CountSell" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div><br /></div>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>   
           
        <div class="panel panel-default">           
            <div class="panel-body">
                <h4 style="font-weight:bold">销售统计</h4>
                <div class="left" style="float:left;width:50%">
                    食物分类：
                    <asp:DropDownList ID="FoodType" runat="server" Height="34px" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="种类" DataValueField="Id" OnSelectedIndexChanged="FoodType_SelectedIndexChanged"  >
                        <asp:ListItem Value="全部"></asp:ListItem>
                    </asp:DropDownList>
                   
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:订餐ConnectionString %>" SelectCommand="SELECT [Id], [种类] FROM [种类表]"></asp:SqlDataSource>
                   
                </div>
            
                <div class="input-group" style="width:50%;">
                    <asp:TextBox runat="server" ID="FoodName" CssClass="form-control" style="float:right" placeholder="搜索菜品" aria-describedby="basic-addon2"/>                
                    <span class="input-group-btn">                
                        <asp:Button ID="Search" runat="server" class="btn btn-default" type="button" Text="搜索" OnClick="Search_Click"/>
                    </span>
                </div>
            </div>
        </div>
            
            <div class="panel panel-default">     
                <div class="panel-body">
                    <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="false">
                        <asp:GridView ID="GridView1" runat="server" style="width:50%" align="center" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource2" PageSize="6">
                            <RowStyle HorizontalAlign="Center"/>
                            <PagerStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center"/>
                            <Columns>
                                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                                <asp:BoundField DataField="种类" HeaderText="种类" SortExpression="种类" />
                                <asp:BoundField DataField="菜名" HeaderText="菜名" SortExpression="菜名" />
                                <asp:ImageField DataImageUrlField="图片路径" HeaderText="图片" ControlStyle-Height="120px" ControlStyle-Width="160px">
                                </asp:ImageField>
                                <asp:BoundField DataField="销量" HeaderText="销量" SortExpression="销量" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:订餐ConnectionString %>" SelectCommand="SELECT 菜单表.Id, 菜单表.菜名, 菜单表.销量, 菜单表.图片路径, 种类表.种类, 种类表.status FROM 菜单表 INNER JOIN 种类表 ON 菜单表.种类id = 种类表.Id WHERE (种类表.status = 0)"></asp:SqlDataSource>
                    </asp:PlaceHolder>

                    <asp:PlaceHolder ID="PlaceHolder2" runat="server" Visible="false">
                        <asp:GridView ID="GridView2" runat="server" style="width:50%" align="center" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource3">
                            <RowStyle HorizontalAlign="Center"/>
                            <PagerStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center"/>
                            <Columns>
                                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                                <asp:BoundField DataField="种类" HeaderText="种类" SortExpression="种类" />
                                <asp:BoundField DataField="菜名" HeaderText="菜名" SortExpression="菜名" />
                                <asp:ImageField DataImageUrlField="图片路径" HeaderText="图片" ControlStyle-Height="120px" ControlStyle-Width="160px"></asp:ImageField>
                                <asp:BoundField DataField="销量" HeaderText="销量" SortExpression="销量" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:订餐ConnectionString %>" SelectCommand="SELECT 菜单表.Id, 菜单表.菜名, 菜单表.销量, 菜单表.图片路径, 种类表.种类, 种类表.status, 菜单表.种类id FROM 菜单表 INNER JOIN 种类表 ON 菜单表.种类id = 种类表.Id WHERE (种类表.status = 0) AND (菜单表.种类id = @种类id)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="FoodType" Name="种类id" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:PlaceHolder>

                    <asp:PlaceHolder ID="PlaceHolder3" runat="server"  Visible="false">
                        <asp:GridView ID="GridView3" runat="server" style="width:50%" align="center" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource4">
                            <RowStyle HorizontalAlign="Center"/>
                            <PagerStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center"/>
                            <Columns>
                                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                                <asp:BoundField DataField="种类" HeaderText="种类" SortExpression="种类" />                        
                                <asp:BoundField DataField="菜名" HeaderText="菜名" SortExpression="菜名" />
                                <asp:ImageField DataImageUrlField="图片路径" HeaderText="图片" ControlStyle-Height="120px" ControlStyle-Width="160px"></asp:ImageField>
                                <asp:BoundField DataField="销量" HeaderText="销量" SortExpression="销量" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:订餐ConnectionString %>" SelectCommand="SELECT 菜单表.Id, 菜单表.菜名, 菜单表.价格, 菜单表.图片路径, 菜单表.销量, 种类表.种类, 种类表.status FROM 菜单表 INNER JOIN 种类表 ON 菜单表.种类id = 种类表.Id WHERE (菜单表.菜名 = @菜名) AND (种类表.status = 0)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="FoodName" Name="菜名" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:PlaceHolder>

               </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

