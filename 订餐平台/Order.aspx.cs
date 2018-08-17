using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Order : System.Web.UI.Page
{
    DataSet PulbicSet = new DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null)
        {
            Response.Redirect("~/Account/Login.aspx");
        }

        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String CommandText = "select * from 订单表 where 用户id = " + int.Parse(Session["Id"].ToString());
        SqlDataAdapter command = new SqlDataAdapter(CommandText, conn);
        DataSet dataSet = new DataSet();
        command.Fill(dataSet);
        command.Fill(PulbicSet);
        OrderList.DataSource = dataSet;
        OrderList.DataKeyField = "Id";//设置数据表的主键
        OrderList.DataBind();
        conn.Close();
    }

    protected void OrderList_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            PlaceHolder placeHolder1 = (PlaceHolder)e.Item.FindControl("PlaceHolder1");
            PlaceHolder placeHolder2 = (PlaceHolder)e.Item.FindControl("PlaceHolder2");
            Label Id = (Label)e.Item.FindControl("Status");
            if (Id.Text == "未完成")
            {
                placeHolder1.Visible = true;
                placeHolder2.Visible = false;
            }
            else if (Id.Text == "未发货")
            {
                placeHolder1.Visible = false;
                placeHolder2.Visible = true;
            }
            else
            {
                placeHolder1.Visible = false;
                placeHolder2.Visible = false;
            }

            DataList dl = (DataList)e.Item.FindControl("ItemList");
            Label Labelid = (Label)e.Item.FindControl("OrderId");
            int OrderId = int.Parse(Labelid.Text);
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
            conn.Open();
            String CommandText = "select * from 订单商品表 where 订单id = " + OrderId;
            SqlDataAdapter command = new SqlDataAdapter(CommandText, conn);
            DataSet dataSet = new DataSet();
            command.Fill(dataSet);
            dl.DataSource = dataSet;
            dl.DataKeyField = "Id";//设置数据表的主键
            dl.DataBind();
            conn.Close();
        }
    }

    protected void OrderList_ItemCommand(object source, DataListCommandEventArgs e)
    {
        OrderList.SelectedIndex = e.Item.ItemIndex;
        int id = OrderList.SelectedIndex + 1;
        Label Labelid = (Label)OrderList.SelectedItem.FindControl("OrderId");
        //Label1.Text = Labelid.Text;
        int orderId = int.Parse(Labelid.Text);
        switch (e.CommandName)
        {
            case "Item":
                Session["OrderId"] = orderId;
                Response.Redirect("OrderItem");
                break;
            case "SendSure":
                SureSend(orderId);     
                break;
            case "Exit":
                Exit(orderId);
                break;
        }
    }

    public void SureSend(int id)
    {
        System.DateTime currentTime = new System.DateTime();
        currentTime = System.DateTime.Now;
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String NewPassWord = "update 订单表 set 收货状态 = '已完成',送达时间 = '" + currentTime.ToString() + "' where Id=" + id;
        SqlCommand command = new SqlCommand(NewPassWord, conn);
        int i = command.ExecuteNonQuery();
        if (i > 0)
        {
            Response.Redirect("Order");
        }
        conn.Close();
    }

    public void Exit(int id)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String NewPassWord = "delete from 订单表 where Id=" + id;
        SqlCommand command = new SqlCommand(NewPassWord, conn);
        int i = command.ExecuteNonQuery();
        if (i > 0)
        {
            Response.Write("<script>alert('退单成功！');window.location.href='Order.aspx';</script>");
        }
        conn.Close();
    }
}