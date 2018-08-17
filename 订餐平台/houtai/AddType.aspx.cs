using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddType : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["id"] == null)
            {
                Response.Redirect("Login");
            }
        }
    }

    protected void Unnamed_Click(object sender, EventArgs e)
    {
        SqlConnection conn1 = new SqlConnection();
        SqlConnection conn2 = new SqlConnection();
        conn1.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn1.Open();
        String Check = "select * from 种类表 where 种类='" + CaiType.Text + "'";
        SqlCommand command_check = new SqlCommand(Check, conn1);
        SqlDataReader read_check = command_check.ExecuteReader();
        //read_check.Read()
        if (read_check.Read())
        {
            FailureText.Text = "该种类已存在！";
            ErrorMessage.Visible = true;
        }
        else
        {
            String Insert = "insert into 种类表 (种类) values('" + CaiType.Text + "')";
            conn2.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
            conn2.Open();
            SqlCommand command_insert = new SqlCommand(Insert, conn2);
            int i = command_insert.ExecuteNonQuery();
            if (i > 0)
            {
                this.Response.Write("<script>window.alert('添加成功！');window.location='FoodManage.aspx'</script>");
                //Response.Redirect("Login.aspx");
            }
            else
            {
                FailureText.Text = "添加失败！";
                ErrorMessage.Visible = true;
            }
        }
        conn1.Close();
        conn2.Close();
        read_check.Close();
    }
}