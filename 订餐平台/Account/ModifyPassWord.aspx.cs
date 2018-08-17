using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_ModifyPassWord : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null)
        {
            Response.Redirect("Login");
        }
    }

    protected void ChangePassword_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection();
        SqlConnection conn2 = new SqlConnection();
        conn2.ConnectionString = "Data Source=ASUS;Initial Catalog = 订餐; Integrated Security = True"; 
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        conn2.Open();
        String check = "select * from 用户表 where 用户名='"+ Session["username"].ToString() + "' and 密码='" +CurrentPassword.Text+ "'";
        String NewPassWord = "update 用户表 set 密码 = '"+ NewPassword.Text+ "' where 用户名='" + Session["username"].ToString() + "'";
        SqlCommand CheckPassword = new SqlCommand(check,conn2);
        SqlCommand UpPassword = new SqlCommand(NewPassWord, conn);
        SqlDataReader read = CheckPassword.ExecuteReader();
        int i = UpPassword.ExecuteNonQuery();
        if (read.Read())
        {
            if (i > 0)
            {
                Session.Clear();
                this.Response.Write("<script>window.alert('密码修改成功,请重新登录！');window.location='Login.aspx'</script>");               
            }
            else
            {
                FailureText.Text = "修改密码失败！";
                ErrorMessage.Visible = true;
            }

        }
        else
        {
            FailureText.Text = "原密码错误！";
            ErrorMessage.Visible = true;
        }
        conn.Close();
        conn2.Close();
        read.Close();
    }
}