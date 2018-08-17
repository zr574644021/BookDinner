using Microsoft.AspNet.Identity;
using System;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using 订餐平台;

public partial class Account_Register : Page
{
    protected void CreateUser_Click(object sender, EventArgs e)
    {
        SqlConnection conn1 = new SqlConnection();
        SqlConnection conn2 = new SqlConnection();
        conn1.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn1.Open();
        String Check = "select * from 用户表 where 用户名='" + UserName.Text + "'";
        SqlCommand command_check = new SqlCommand(Check, conn1);
        SqlDataReader read_check = command_check.ExecuteReader();
        //read_check.Read()
        if (read_check.Read())
        {
            FailureText.Text = "用户名已存在！";
            ErrorMessage.Visible = true;
        }
        else
        {
            String Insert = "insert into 用户表 (用户名,密码) values('" + UserName.Text + "','"+Password.Text+"')";
            conn2.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
            conn2.Open();
            SqlCommand command_insert = new SqlCommand(Insert, conn2); 
            int i = command_insert.ExecuteNonQuery();
            if (i > 0)
            {
                this.Response.Write("<script>window.alert('注册成功！');window.location='Login.aspx'</script>");
                //Response.Redirect("Login.aspx");
            }
            else
            {
                FailureText.Text = "注册失败！";
                ErrorMessage.Visible = true;
            }
        }
        conn1.Close();
        conn2.Close();
        read_check.Close();
    }
}