using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddressManage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["Id"] == null)
            {
                Response.Redirect("Login");
            }
            /*SqlConnection conn = new SqlConnection();
            conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
            conn.Open();
            String CommandText = "select * from 收货人表 where Id = " + int.Parse(Session["AddressId"].ToString());
            SqlDataAdapter command = new SqlDataAdapter(CommandText, conn);
            DataSet dataSet = new DataSet();
            command.Fill(dataSet);
            AddressList.DataSource = dataSet;
            AddressList.DataKeyField = "Id";//设置数据表的主键
            AddressList.DataBind();
            conn.Close();*/
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
            conn.Open();
            String CommandText = "select * from 收货人表 where Id = " + int.Parse(Session["AddressId"].ToString());
            SqlCommand command = new SqlCommand(CommandText, conn);
            SqlDataReader read = command.ExecuteReader();
            if (read.Read())
            {
                Name.Text = read["姓名"].ToString();
                WeiZhi.Text = read["位置"].ToString();
                JTWeiZhi.Text = read["详细地址"].ToString();
                Phone.Text = read["联系电话"].ToString();
                if (read["性别"].ToString() == "先生")
                {
                    radSex.Checked = true;
                    radSex2.Checked = false;
                }
                else
                {
                    radSex.Checked = false;
                    radSex2.Checked = true;
                }
            }
            read.Close();
            conn.Close();
        }
    }

    protected void Save(object sender, EventArgs e)
    {
        String sex = null;
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        if (radSex.Text == "")
        {
            sex = radSex2.Text;
        }
        else
        {
            sex = radSex.Text;
        }
        String Text = "update 收货人表 set 姓名 = '" + Name.Text + "', 性别 = '"+ sex +"',位置='"+ WeiZhi.Text +"',详细地址='"+ JTWeiZhi.Text +"'," +
            "联系电话='"+Phone.Text+"' where Id=" + int.Parse(Session["AddressId"].ToString());
        SqlCommand command = new SqlCommand(Text, conn);
        int i = command.ExecuteNonQuery();
        if (i > 0)
        {
            Response.Write("<script>alert('修改成功！');window.location.href='AddAddress.aspx';</script>");
        }
    }

    protected void Delete(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String text = "delete from 收货人表 where Id=" + int.Parse(Session["AddressId"].ToString());
        SqlCommand command = new SqlCommand(text, conn);
        int i = command.ExecuteNonQuery();
        //Response.Write(i);
        if (i > 0)
        {
            Response.Write("<script>alert('删除成功！');window.location.href='AddAddress.aspx';</script>");
        }
        conn.Close();
    }


   /* protected void AddressList_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "Save")
        {
            string sex = null;
            AddressList.SelectedIndex = e.Item.ItemIndex;
            int id = AddressList.SelectedIndex + 1;
            TextBox Name = (TextBox)AddressList.SelectedItem.FindControl("Name");
            RadioButton Sex1 = (RadioButton)AddressList.SelectedItem.FindControl("radSex");
            RadioButton Sex2 = (RadioButton)AddressList.SelectedItem.FindControl("radSex2");
            TextBox WeiZhi = (TextBox)AddressList.SelectedItem.FindControl("WeiZhi");
            TextBox JTWeiZhi = (TextBox)AddressList.SelectedItem.FindControl("JTWeiZhi");
            TextBox Phone = (TextBox)AddressList.SelectedItem.FindControl("Phone");
            if (Sex1.Text == "")
            {
                sex = "女士";
            }
            else
            {
                sex = "先生";
            }

        }
    }*/
}