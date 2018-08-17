using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddAddress : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null)
        {
            Response.Redirect("Login");
        }
    }

    public int UpdateAddressId;
    public int DeleteAddressId;

    public void GetAddress(int id)
    {           
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = "Data Source=ASUS;Initial Catalog=订餐;Integrated Security=True";
        conn.Open();
        String CommandText = "select * from 收货人表 where Id = " + id;
        SqlCommand command = new SqlCommand(CommandText, conn);
        SqlDataReader read = command.ExecuteReader();
        if (read.Read())
        {
            newName.Text = read["姓名"].ToString();
            newAddress.Text = read["位置"].ToString();
            newDetaAddress.Text = read["详细地址"].ToString();
            newPhone.Text = read["联系电话"].ToString();
            if (read["性别"].ToString() == "先生")
            {
                newRadSex.Checked = true;
                newRadSex2.Checked = false;
            }
            else
            {
                newRadSex.Checked = false;
                newRadSex2.Checked = true;
            }
        }
        read.Close();
        conn.Close();
    }

    protected void Add_Click(object sender, EventArgs e)
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
        String CommandText = "insert into 收货人表 (姓名,性别,位置,详细地址,联系电话,用户id) values('" + Name.Text + "','" + sex + "','" + Address.Text+ "','" +
            DetaAddress.Text+ "','" + Phone.Text + "'," + int.Parse(Session["Id"].ToString())+")";
        SqlCommand command = new SqlCommand(CommandText,conn);
        int i = command.ExecuteNonQuery();
        if (i > 0)
        {
            Name.Text = null;
            Address.Text = null;
            DetaAddress.Text = null;
            Phone.Text = null;
            this.Response.Write("<script>window.alert('添加成功！');window.location='AddAddress.aspx'</script>");           
        }
        else
        {
            Name.Text = null;
            Address.Text = null;
            DetaAddress.Text = null;
            Phone.Text = null;
            this.Response.Write("<script>window.alert('添加失败！');window.location='AddAddress.aspx' %></script>");           
        }
        conn.Close();
    }

    protected void Update_Click(object sender, EventArgs e)
    {
        string a = ((LinkButton)sender).ToString();
        Response.Write(a);
    }

    protected void Delete_Click(object sender, EventArgs e)
    {

    }


    protected void AddressList_ItemCommand(object source, DataListCommandEventArgs e)
    {
        AddressList.SelectedIndex = e.Item.ItemIndex;
        int id = AddressList.SelectedIndex + 1;
        Label Labelid = (Label)AddressList.SelectedItem.FindControl("AddressId");
        //Label1.Text = Labelid.Text;
        int AddressId = int.Parse(Labelid.Text);
        switch (e.CommandName)
        {
            case "Manage":
                Session["AddressId"] = AddressId;
                Response.Redirect("AddressManage");
                break;
            case "delete":
                break;

        }
    }

    protected void AddressList_ItemDataBound(object sender, DataListItemEventArgs e)
    {

    }

    protected void Update_Click1(object sender, EventArgs e)
    {
        Response.Redirect("Register");
    }
}