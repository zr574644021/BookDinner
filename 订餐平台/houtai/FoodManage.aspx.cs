using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FoodManage : System.Web.UI.Page
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


    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("AddCai");
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("AddType");
    }
}