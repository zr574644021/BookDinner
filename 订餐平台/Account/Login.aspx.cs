using System;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Account_Login : Page
{
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void LogIn(object sender, EventArgs e)
        {            
            if (IsValid)
                {
                    // Validate the user password
                    SqlConnection conn = new SqlConnection();
                    conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
                    conn.Open();
                    String CommandText = "select * from 用户表 where 用户名='" + UserName.Text + "' and 身份='普通用户'";
                    SqlCommand command = new SqlCommand(CommandText, conn);                  
                    SqlDataReader read = command.ExecuteReader();
                    if (read.Read())
                    {
                        if ((this.UserName.Text.Trim() == read["用户名"].ToString().Trim()))
                        {
                            if ((this.Password.Text.Trim() == read["密码"].ToString().Trim()))
                            {
                                Session["ID"] = read["Id"];
                                Session["username"] = UserName.Text;
                                Response.Redirect("~/Default.aspx");                                                              
                            }
                            else
                            {
                                FailureText.Text = "用户名或密码错误!";
                                ErrorMessage.Visible = true;
                            }
                        }
                    }
                    else
                    {
                        FailureText.Text = "该用户名不存在!";
                        ErrorMessage.Visible = true;
                    }
                    conn.Close();
                    read.Close();
                }
        }

    protected void Register(object sender, EventArgs e)
    {
        Response.Redirect("Register.aspx");
    }
}