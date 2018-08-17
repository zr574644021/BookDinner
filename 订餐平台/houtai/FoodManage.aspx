<%@ Page Title="" Language="C#" MasterPageFile="~/houtai/MasterPage.master" AutoEventWireup="true" CodeFile="FoodManage.aspx.cs" Inherits="FoodManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div><br /></div>
    <div class="panel panel-default">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
        <div class="panel-body">
            
            <h4 style="font-weight:bold">菜品管理</h4>
           
            <div class="fenge"></div >
            <br /> 

            <asp:Button ID="Button1" runat="server" Text="添加分类" OnClick="Button1_Click"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button2" runat="server" Text="添加菜品" OnClick="Button2_Click"/>
            <div class="profile-panelcontent">
                 <div class="panel-body" style="text-align:center">  
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True"  style="width:30%" align="center" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="TypeDataSource" PageSize="6">
                    <RowStyle HorizontalAlign="Center"/>
                    <PagerStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center"/>
                    <Columns>                        
                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" />
                        <asp:BoundField DataField="种类" HeaderText="种类" SortExpression="种类" />
                        <asp:CommandField HeaderText="操作" ShowEditButton="True" ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView>
                     <asp:SqlDataSource ID="TypeDataSource" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:订餐ConnectionString %>" DeleteCommand="DELETE FROM [种类表] WHERE [Id] = @original_Id AND [种类] = @original_种类 AND (([status] = @original_status) OR ([status] IS NULL AND @original_status IS NULL))" InsertCommand="INSERT INTO [种类表] ([Id], [种类], [status]) VALUES (@Id, @种类, @status)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [种类表] WHERE ([status] = @status)" UpdateCommand="UPDATE 种类表 SET 种类 = @种类 WHERE (Id = @original_Id)">
                         <DeleteParameters>
                             <asp:Parameter Name="original_Id" Type="Int32" />
                             <asp:Parameter Name="original_种类" Type="String" />
                             <asp:Parameter Name="original_status" Type="Int32" />
                         </DeleteParameters>
                         <InsertParameters>
                             <asp:Parameter Name="Id" Type="Int32" />
                             <asp:Parameter Name="种类" Type="String" />
                             <asp:Parameter Name="status" Type="Int32" />
                         </InsertParameters>
                         <SelectParameters>
                             <asp:Parameter DefaultValue="0" Name="status" Type="Int32" />
                         </SelectParameters>
                         <UpdateParameters>
                             <asp:Parameter Name="种类" Type="String" />
                             <asp:Parameter Name="original_Id" Type="Int32" />
                         </UpdateParameters>
                     </asp:SqlDataSource>
                </div>
                <div class="panel-body" style="text-align:center">  
                <asp:GridView ID="GridView2" runat="server" AllowPaging="True"  style="width:50%" align="center" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="FoodDataSource" PageSize="6">
                    <RowStyle HorizontalAlign="Center"/>
                    <PagerStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center"/>
                    <Columns>                        
                        <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" InsertVisible="False" ReadOnly="True" />                       
                        <asp:BoundField DataField="种类" HeaderText="种类" SortExpression="种类" />
                        <asp:ImageField DataImageUrlField="图片路径" HeaderText="图片" ControlStyle-Height="120px" ControlStyle-Width="160px">
                            <ControlStyle Height="120px" Width="160px" />
                        </asp:ImageField>
                        <asp:BoundField DataField="菜名" HeaderText="菜名" SortExpression="菜名" />
                        <asp:BoundField DataField="价格" HeaderText="价格" SortExpression="价格" />
                        <asp:BoundField DataField="销量" HeaderText="销量" SortExpression="销量" />
                        <asp:BoundField DataField="介绍" HeaderText="介绍" SortExpression="介绍" />
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" HeaderText="操作" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="FoodDataSource" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:订餐ConnectionString %>" DeleteCommand="DELETE FROM [菜单表] WHERE [Id] = @original_Id" InsertCommand="INSERT INTO [菜单表] ([菜名], [价格], [销量], [种类id], [图片路径], [介绍]) VALUES (@菜名, @价格, @销量, @种类id, @图片路径, @介绍)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT 菜单表.介绍 AS Expr1, 种类表.种类, 种类表.status, 菜单表.介绍 AS Expr8, 菜单表.* FROM 菜单表 INNER JOIN 种类表 ON 菜单表.种类id = 种类表.Id WHERE (种类表.status = 0)" UpdateCommand="UPDATE [菜单表] SET [菜名] = @菜名, [价格] = @价格, [销量] = @销量, [图片路径] = @图片路径, [介绍] = @介绍 WHERE [Id] = @original_Id">
                    <DeleteParameters>
                        <asp:Parameter Name="original_Id" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="菜名" Type="String" />
                        <asp:Parameter Name="价格" Type="Double" />
                        <asp:Parameter Name="销量" Type="Int32" />
                        <asp:Parameter Name="种类id" Type="Int32" />
                        <asp:Parameter Name="图片路径" Type="String" />
                        <asp:Parameter Name="介绍" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="菜名" Type="String" />
                        <asp:Parameter Name="价格" Type="Double" />
                        <asp:Parameter Name="销量" Type="Int32" />
                        <asp:Parameter Name="图片路径" Type="String" />
                        <asp:Parameter Name="介绍" Type="String" />
                        <asp:Parameter Name="original_Id" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </div>
            </div>
        </div>
                </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>

