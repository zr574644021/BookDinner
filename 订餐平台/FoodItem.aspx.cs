using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{
    int caiId = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["caiId"] == null)
            {
                Response.Redirect("Default");
            }
            caiId = int.Parse(Session["caiId"].ToString());
            GetWord();
        }
    }

    protected void AddWord_Click(object sender, EventArgs e)
    {
        if (Session["Id"] == null)
        {
            Response.Redirect("~/Account/Login");
        }

        System.DateTime currentTime = new System.DateTime();
        currentTime = System.DateTime.Now;
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String text = "insert into 评论表 (评论,商品id,用户id,评论时间) values('"+ TextWord.Value + "',"+ int.Parse(Session["caiId"].ToString()) +"," +
            ""+ int.Parse(Session["Id"].ToString()) + ",'"+ currentTime.ToString() +"')";
        SqlCommand command = new SqlCommand(text, conn);
        int i = command.ExecuteNonQuery();
        if (i > 0)
        {
            command.Dispose();
            conn.Close();
            GetWord();
            Response.Redirect("FoodItem");
        }
    }

    public void GetWord()
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String text = "SELECT 评论表.Id, 评论表.评论, 评论表.商品id, 评论表.用户id, 评论表.评论时间, 用户表.用户名, 用户表.Id AS Expr1 FROM 评论表" +
            " INNER JOIN 用户表 ON 评论表.用户id = 用户表.Id WHERE(评论表.商品id = "+ caiId + ")";
        SqlDataAdapter command = new SqlDataAdapter(text, conn);
        DataSet dataSet = new DataSet();
        command.Fill(dataSet);
        Word.DataSource = dataSet;
        Word.DataKeyField = "Id";//设置数据表的主键
        Word.DataBind();
        conn.Close();
    }
}