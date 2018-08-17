using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            GetAll();
            if (FoodName.Text == "")
            {
                if (FoodType.Text == "全部")
                {
                    GetAllFood();
                }
                else
                {
                    GetTypeFood();
                }
            }
            else
            {
                GetSearchFood();
            }
        }
    }



    protected void Search_Click(object sender, EventArgs e)
    {
        if (FoodName.Text == "")
        {
            GetAllFood();

            if (FoodType.Text == "1")
            {
                GetAllFood();
            }
            else
            {
                GetTypeFood();
            }
        }
        else
        {
            GetSearchFood();
        }
    }

    protected void FoodType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (FoodType.Text == "1")
        {
            GetAllFood();
        }
        else
        {
            GetTypeFood();
        }
        
    }


    public void GetAllFood()
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String CommandText = "select * from 菜单表 ";
        SqlDataAdapter command = new SqlDataAdapter(CommandText, conn);
        DataSet dataSet = new DataSet();
        command.Fill(dataSet);
        FoodList.DataSource = dataSet;
        FoodList.DataKeyField = "Id";//设置数据表的主键
        FoodList.DataBind();
        conn.Close();
    }

    public void GetSearchFood()
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String CommandText = "select * from 菜单表 where 菜名='" + FoodName.Text + "'";
        SqlDataAdapter command = new SqlDataAdapter(CommandText, conn);
        DataSet dataSet = new DataSet();
        command.Fill(dataSet);
        FoodList.DataSource = dataSet;
        FoodList.DataKeyField = "Id";//设置数据表的主键
        FoodList.DataBind();
        conn.Close();
    }

    public void GetTypeFood()
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String CommandText = "select * from 菜单表 where 种类id=" + int.Parse(FoodType.Text);
        SqlDataAdapter command = new SqlDataAdapter(CommandText, conn);
        DataSet dataSet = new DataSet();
        command.Fill(dataSet);
        FoodList.DataSource = dataSet;
        FoodList.DataKeyField = "Id";//设置数据表的主键
        FoodList.DataBind();
        conn.Close();
    }

    protected void FoodList_ItemCommand(object source, DataListCommandEventArgs e)
    { 
        FoodList.SelectedIndex = e.Item.ItemIndex;
        Label label1 = null;
        label1 = (Label)FoodList.SelectedItem.FindControl("菜名Label");
        string cainame = label1.Text;

        Label label2 = (Label)FoodList.SelectedItem.FindControl("价格Label");
        float caiprice = float.Parse(label2.Text);

        Label label3 = (Label)FoodList.SelectedItem.FindControl("IdLabel");
        int foodId = int.Parse(label3.Text);

        switch (e.CommandName)
        {
            case "AddCart":
                if (Session["id"] == null)
                {
                    Response.Redirect("Account/Login");
                }
                SqlConnection conn = new SqlConnection();
                conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
                conn.Open();
                String CommandText1 = "select * from 购物车  where 菜名 ='" + cainame + "'";
                String CommandText = "update 购物车 set 数量 = 数量+1 where 菜名 ='" + cainame + "' and 用户id = "+ int.Parse(Session["Id"].ToString());
                SqlCommand command1 = new SqlCommand(CommandText1, conn);
                SqlDataReader read = command1.ExecuteReader();
                command1.Dispose();
                if (read.Read())
                {
                    read.Close();
                    SqlCommand command = new SqlCommand(CommandText, conn);
                    command.ExecuteNonQuery();
                    command.Dispose();
                }
                else
                {
                    read.Close();
                    String CommandText2 = "insert into 购物车 (菜名,数量,金额,用户id) values('" + label1.Text + "'," + 1 + ","+ float.Parse(label2.Text) +","+ int.Parse(Session["Id"].ToString()) +")";
                    SqlCommand command = new SqlCommand(CommandText2, conn);
                    command.ExecuteNonQuery();
                    command.Dispose();
                }
                GetAll();
                conn.Close();
                break;
            //GetAllCart(); 
            case "foodItem":
                Session["caiId"] = foodId;
                Response.Redirect("FoodItem");
                break;
        }
    }

    public void GetAll()
    {
        if (Session["Id"] != null)
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

    protected void Empty_Click(object sender, EventArgs e)
    {
        if (Session["Id"] != null)
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
            }
        }

    }

    protected void Result_Click(object sender, EventArgs e)
    {
        if (Session["Id"] != null)
        {
            if (SelectCart())
            {
                Response.Redirect("BuyCar");
            }
            else
            {
                Response.Write("<script>alert('购物车为空不能结算！')</script>");
            }
        }
        else
        {
            Response.Write("<script>alert('未登录,请登录后再进行相关操作!');window.location('Login')</script>");
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
                    Response.Redirect("Default");
                }
                else
                {
                    CommandText = "update 购物车 set 数量 = 数量-1 where 菜名 ='" + label1.Text + "'";
                    SqlCommand command3 = new SqlCommand(CommandText, conn);
                    command3.ExecuteNonQuery();
                    GetAll();
                }
                GetAll();
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
}