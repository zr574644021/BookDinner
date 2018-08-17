using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OrderItem : Page
{
    DataSet PulbicSet = new DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        int id = int.Parse(Session["OrderId"].ToString());

        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String CommandText = "select * from 订单表 where Id = " + id;
        SqlDataAdapter command = new SqlDataAdapter(CommandText, conn);
        DataSet dataSet = new DataSet();
        command.Fill(dataSet);
        command.Fill(PulbicSet);
        OrderList.DataSource = dataSet;
        OrderList.DataKeyField = "Id";//设置数据表的主键
        OrderList.DataBind();
    }

    protected void OrderList_ItemCommand(object source, DataListCommandEventArgs e)
    {      
        if (e.CommandName == "SureSend")
        {
            System.DateTime currentTime = new System.DateTime();
            currentTime = System.DateTime.Now;
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
            conn.Open();
            String text = "update 订单表 set 收货状态 = '已完成',送达时间 = '"+ currentTime.ToString() + "' where Id=" + int.Parse(Session["OrderId"].ToString());
            SqlCommand command = new SqlCommand(text, conn);
            int i = command.ExecuteNonQuery();
            if (i > 0)
            {            
                Response.Redirect("OrderItem");
            }
            conn.Close();
        }
        if (e.CommandName == "SureFaHuo")
        {
            SureFaHuo(int.Parse(Session["OrderId"].ToString()));
        }
    }

    protected void OrderList_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            PlaceHolder placeHolder1 = (PlaceHolder)e.Item.FindControl("PlaceHolder1");
            PlaceHolder placeHolder2 = (PlaceHolder)e.Item.FindControl("PlaceHolder2");


            if (PulbicSet.Tables[0].Rows[0]["收货状态"].ToString() == "已完成")
            {
                placeHolder1.Visible = false;
                placeHolder2.Visible = false;
            }
            else if (PulbicSet.Tables[0].Rows[0]["收货状态"].ToString() == "未发货")
            {
                placeHolder1.Visible = true;
                placeHolder2.Visible = false;
            }
            else
            {
                placeHolder1.Visible = false;
                placeHolder2.Visible = true;
            }

            DataList dl = (DataList)e.Item.FindControl("FoodList");
            Label Labelid = (Label)e.Item.FindControl("OrderId");
            int OrderId = int.Parse(Labelid.Text);
            SqlDataAdapter command = GetFoodList(OrderId);
            DataSet dataSet = new DataSet();
            command.Fill(dataSet);
            dl.DataSource = dataSet;
            dl.DataKeyField = "Id";//设置数据表的主键
            dl.DataBind();
         
            DataList dl1 = (DataList)e.Item.FindControl("GetPersonList");
            Label Labelid1 = (Label)e.Item.FindControl("PersonId");
            int PersonId = int.Parse(Labelid1.Text);
            //Response.Write(PersonId);
            SqlDataAdapter command1 = GetFoodPerson(PersonId);
            DataSet dataSet1 = new DataSet();
            command1.Fill(dataSet1);
            dl1.DataSource = dataSet1;
            dl1.DataKeyField = "Id";//设置数据表的主键
            dl1.DataBind();
        }
    }

    public SqlDataAdapter GetFoodList(int OrderId)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String CommandText = "select * from 订单商品表 where 订单id = " + OrderId;
        SqlDataAdapter command = new SqlDataAdapter(CommandText, conn);
        conn.Close();
        return command;
    }

    public SqlDataAdapter GetFoodPerson(int PersonId)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String CommandText = "select * from 收货人表 where Id = " + PersonId;
        SqlDataAdapter command = new SqlDataAdapter(CommandText, conn);
        conn.Close();
        return command;
    }

    public void SureFaHuo(int id)
    {
        System.DateTime currentTime = new System.DateTime();
        currentTime = System.DateTime.Now.AddMinutes(40);
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String NewPassWord = "update 订单表 set 收货状态 = '未完成',送达时间 = '" + currentTime.ToString() + "' where Id=" + id;
        SqlCommand command = new SqlCommand(NewPassWord, conn);
        int i = command.ExecuteNonQuery();
        if (i > 0)
        {
            Response.Redirect("OrderItem");
        }
        conn.Close();
    }
}