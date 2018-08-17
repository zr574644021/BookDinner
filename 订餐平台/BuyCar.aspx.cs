using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BuyCar : Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null)
        {
            Response.Redirect("~/Account/Login");
        }

        if (!IsPostBack)
        {
            GetAll();
        }
    }

    public void GetAll()
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String CommandText = "select * from 购物车 where 用户id = " + int.Parse(Session["Id"].ToString());
        SqlDataAdapter command = new SqlDataAdapter(CommandText, conn);
        DataSet dataSet = new DataSet();
        command.Fill(dataSet);
        ShopCartList.DataSource = dataSet;
        ShopCartList.DataKeyField = "Id";//设置数据表的主键
        ShopCartList.DataBind();
        float allPay = 0;
        foreach (DataRow row in dataSet.Tables[0].Rows)
        {
            allPay += float.Parse(row[3].ToString()) * int.Parse(row[2].ToString());
        }
        Session["AllPay"] = allPay;
        conn.Close();
    }

    public bool SelectCart()
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String CommandText = "select * from 购物车 where 用户id = " + int.Parse(Session["Id"].ToString());
        SqlCommand command = new SqlCommand(CommandText, conn);
        SqlDataReader read = command.ExecuteReader();

        if (read.Read())
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    protected void ShopCartList_ItemCommand(object source, DataListCommandEventArgs e)
    {
        ShopCartList.SelectedIndex = e.Item.ItemIndex;
        TextBox textBox = (TextBox)ShopCartList.SelectedItem.FindControl("TextBox1");
        Label label1 = (Label)ShopCartList.SelectedItem.FindControl("Label1");
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String CommandText = null;

        switch (e.CommandName)
        {
            case "SendCut":
                textBox.Text = (int.Parse(textBox.Text) - 1).ToString();
                if (int.Parse(textBox.Text) <= 0)
                {
                    CommandText = "delete from 购物车 where 菜名 ='" + label1.Text + "'";
                    SqlCommand command2 = new SqlCommand(CommandText, conn);
                    command2.ExecuteNonQuery();
                    GetAll();
                    Response.Redirect("BuyCar");
                }
                else
                {
                    CommandText = "update 购物车 set 数量 = 数量-1 where 菜名 ='" + label1.Text + "'";
                    SqlCommand command3 = new SqlCommand(CommandText, conn);
                    command3.ExecuteNonQuery();
                    GetAll();
                }             
               
                conn.Close();
                break;
            case "SendAdd":
                textBox.Text = (int.Parse(textBox.Text) + 1).ToString();
                CommandText = "update 购物车 set 数量 = 数量+1 where 菜名 ='" + label1.Text + "'";
                SqlCommand command1 = new SqlCommand(CommandText, conn);
                command1.ExecuteNonQuery();
                conn.Close();
                GetAll();
                break;
        }
    }

    protected void SureSend_Click(object sender, EventArgs e)
    {

        if (SelectCart())
        {           
            System.DateTime currentTime = new System.DateTime();
            currentTime = System.DateTime.Now;
            TextBox textBox = (TextBox)ShopCartList.SelectedItem.FindControl("TextBox1");

            SqlConnection conn = new SqlConnection();
            SqlConnection conn1 = new SqlConnection();

            conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
            conn1.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";

            conn.Open();
            conn1.Open();

            String Select = "select * from 购物车 where 用户id=" + int.Parse(Session["Id"].ToString());
            String Delete = "delete from 购物车 where 用户id=" + int.Parse(Session["Id"].ToString());
            String InsertOrder = "insert into 订单表 (用户id,收货人id,总金额,下单时间,订单备注) values(" + int.Parse(Session["Id"].ToString())
                + "," + int.Parse(AddressId.Text) + "," + float.Parse(Session["AllPay"].ToString()) + ",'" + currentTime.ToString() + "','" + TextArea1.Value + "')";
            String SelectId = "select Id from 订单表 where 下单时间='" + currentTime.ToString() + "'";


            SqlCommand insertOrder = new SqlCommand(InsertOrder, conn);
            int i = insertOrder.ExecuteNonQuery();
            insertOrder.Dispose();
            int orderId = 0;
            int a, l = 0;
            int n = 0;
            if (i > 0)
            {
                SqlCommand selectId = new SqlCommand(SelectId, conn);
                SqlDataReader read = selectId.ExecuteReader();
                selectId.Dispose();             
                if (read.Read())
                {               
                    orderId = int.Parse(read["Id"].ToString());
                    read.Close();
                    SqlCommand select = new SqlCommand(Select, conn);
                    SqlDataReader read1 = select.ExecuteReader();
                    
                    select.Dispose();
                    while (read1.Read())
                    {
                        String InsertFood = "insert into 订单商品表 (订单id,菜名,数量,总金额) values(" + orderId + ",'" + read1["菜名"].ToString() + "'," + int.Parse(textBox.Text) + "," + float.Parse(read1["金额"].ToString()) * int.Parse(read1["数量"].ToString()) + ")";
                        String Update = "update 菜单表 set 销量 = 销量+" + int.Parse(read1["数量"].ToString()) + " where 菜名 ='" + read1["菜名"].ToString() + "'";
                        SqlCommand update = new SqlCommand(Update, conn1);
                        l = update.ExecuteNonQuery();
                        update.Dispose();

                        SqlCommand insertFood = new SqlCommand(InsertFood, conn1);
                        n = insertFood.ExecuteNonQuery();
                        insertFood.Dispose();

                    }
                    read1.Close();
                }
            }

            if (n > 0 && l > 0)
            {
                SqlCommand delete = new SqlCommand(Delete, conn);
                a = delete.ExecuteNonQuery();
                delete.Dispose();
                conn.Close();
                conn1.Close();
                if (a > 0)
                {
                    Response.Write("<script>window.alert('下单成功！');window.location='Order.aspx'</script>");
                }
            }
        }
        else
        {
            Response.Write("<script>alert('购物车为空不能结算！')</script>");

        }

        

    }

    protected void Empty_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String Delete = "delete from 购物车 where 用户id=" + int.Parse(Session["Id"].ToString());
        SqlCommand delete = new SqlCommand(Delete, conn);
        int a = delete.ExecuteNonQuery();
        delete.Dispose();
        conn.Close();
        if (a > 0)
        {
            GetAll();
            Response.Write("<script>alert('清空购物车成功!')</script>");
        }
    }
}