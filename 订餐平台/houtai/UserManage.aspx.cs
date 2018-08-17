using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserManage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["id"] == null)
            {
                Response.Redirect("Login");
            }
            if (FoodName.Text == "")
            {
                All.Visible = true;
                SearchName.Visible = false;
            }
            else
            {
                All.Visible = false;
                SearchName.Visible = true;
            }
        }
    }

    protected void Search_Click(object sender, EventArgs e)
    {
        if (FoodName.Text == "")
        {
            All.Visible = true;
            SearchName.Visible = false;
        }
        else
        {
            All.Visible = false;
            SearchName.Visible = true;
        }
    }
}