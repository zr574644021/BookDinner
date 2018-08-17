<%@ Page Title="" Language="C#" MasterPageFile="~/houtai/MasterPage.master" AutoEventWireup="true" CodeFile="UserManage.aspx.cs" Inherits="UserManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style>
        .div
        {
            text-align:center;
        }
        .th
        {
            text-align:center;
        }
    </style>

    <div><br /></div>

    <div class="panel panel-default">
        <div class="panel-body">            
            <h4 style="font-weight:bold;display:inline">用户信息管理</h4>
                      
            <div class="input-group" style="width:36%;float:right;display:inline">
                <asp:TextBox runat="server" ID="FoodName" CssClass="form-control"  placeholder="搜索用户" aria-describedby="basic-addon2"/>                
                <span class="input-group-btn" style="width:50px">                
                    <asp:Button ID="Search" runat="server" style="float:left" class="btn btn-default" type="button" Text="搜索" OnClick="Search_Click" />
                </span>
            </div>
        </div>
    </div>
     
    <div class="panel panel-default">
        <div class="panel-body" style="text-align:center">   
            <asp:PlaceHolder ID="All" runat="server" Visible="false">
                <asp:GridView ID="GridView1" runat="server" align="center" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="UserDataSource" Width="60%" PageSize="4">
                    <RowStyle HorizontalAlign="Center"/>
                    <PagerStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center"/>
                    <Columns>                                                          
                        
                        <asp:BoundField DataField="Id" HeaderText="Id" HeaderStyle-HorizontalAlign="Center" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                        <asp:BoundField DataField="用户名" HeaderText="用户名" SortExpression="用户名" />                   
                        <asp:BoundField DataField="身份" HeaderText="身份" SortExpression="身份" />
                        <asp:CommandField ShowDeleteButton="True" HeaderText="操作"  ShowEditButton="True" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:订餐ConnectionString %>" SelectCommand="SELECT [Id], [用户名], [身份] FROM [用户表] WHERE ([身份] = @身份)" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [用户表] WHERE [Id] = @original_Id AND [用户名] = @original_用户名 AND [身份] = @original_身份" InsertCommand="INSERT INTO [用户表] ([用户名], [身份]) VALUES (@用户名, @身份)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [用户表] SET [用户名] = @用户名, [身份] = @身份 WHERE [Id] = @original_Id AND [用户名] = @original_用户名 AND [身份] = @original_身份">
                    <DeleteParameters>
                        <asp:Parameter Name="original_Id" Type="Int32" />
                        <asp:Parameter Name="original_用户名" Type="String" />
                        <asp:Parameter Name="original_身份" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="用户名" Type="String" />
                        <asp:Parameter Name="身份" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:Parameter DefaultValue="普通用户" Name="身份" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                    <asp:Parameter Name="用户名" Type="String" />
                    <asp:Parameter Name="身份" Type="String" />
                    <asp:Parameter Name="original_Id" Type="Int32" />
                    <asp:Parameter Name="original_用户名" Type="String" />
                    <asp:Parameter Name="original_身份" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
           </asp:PlaceHolder>
            
            <asp:PlaceHolder ID="SearchName" runat="server" Visible="false">
                <asp:GridView ID="SearchView" runat="server" align="center" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SearchDataSource"  Width="60%" PageSize="4">
                    <RowStyle HorizontalAlign="Center"/>
                    <PagerStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center"/>
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                        <asp:BoundField DataField="用户名" HeaderText="用户名" SortExpression="用户名" />
                        <asp:BoundField DataField="身份" HeaderText="身份" SortExpression="身份" />
                        <asp:CommandField ShowDeleteButton="True" HeaderText="操作" ShowEditButton="True" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SearchDataSource" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:订餐ConnectionString %>" DeleteCommand="DELETE FROM [用户表] WHERE [Id] = @original_Id AND [用户名] = @original_用户名 AND [身份] = @original_身份" InsertCommand="INSERT INTO [用户表] ([用户名], [身份]) VALUES (@用户名, @身份)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [Id], [用户名], [身份] FROM [用户表] WHERE (([身份] = @身份) AND ([用户名] = @用户名))" UpdateCommand="UPDATE [用户表] SET [用户名] = @用户名, [身份] = @身份 WHERE [Id] = @original_Id AND [用户名] = @original_用户名 AND [身份] = @original_身份">
                    <DeleteParameters>
                        <asp:Parameter Name="original_Id" Type="Int32" />
                        <asp:Parameter Name="original_用户名" Type="String" />
                        <asp:Parameter Name="original_身份" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="用户名" Type="String" />
                        <asp:Parameter Name="身份" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:Parameter DefaultValue="普通用户" Name="身份" Type="String" />
                        <asp:ControlParameter ControlID="FoodName" Name="用户名" PropertyName="Text" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="用户名" Type="String" />
                        <asp:Parameter Name="身份" Type="String" />
                        <asp:Parameter Name="original_Id" Type="Int32" />
                        <asp:Parameter Name="original_用户名" Type="String" />
                        <asp:Parameter Name="original_身份" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </asp:PlaceHolder>
        <br />
    </div>
            
    </div>         
</asp:Content>

