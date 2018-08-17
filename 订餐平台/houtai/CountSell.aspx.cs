using System;

public partial class CountSell : System.Web.UI.Page
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
                
                if (FoodType.Text == "全部")
                {
                    PlaceHolder1.Visible = true;
                    PlaceHolder2.Visible = false;
                    PlaceHolder3.Visible = false;
                }
                else
                {
                    PlaceHolder1.Visible = false;
                    PlaceHolder2.Visible = false;
                    PlaceHolder3.Visible = false;
                }
            }
            else
            {
                PlaceHolder1.Visible = false;
                PlaceHolder2.Visible = false;
                PlaceHolder3.Visible = true;
            }
        }
    }

    protected void Search_Click(object sender, EventArgs e)
    {
        if (FoodName.Text == "")
        {
            if (FoodType.Text == "1")
            {
                PlaceHolder1.Visible = true;
                PlaceHolder2.Visible = false;
                PlaceHolder3.Visible = false;
            }
            else
            {
                PlaceHolder1.Visible = false;
                PlaceHolder2.Visible = true;
                PlaceHolder3.Visible = false;
            }
        }
        else
        {
            PlaceHolder1.Visible = false;
            PlaceHolder2.Visible = false;
            PlaceHolder3.Visible = true;
        }
    }

    protected void FoodType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (FoodType.Text == "1")
        {
            PlaceHolder1.Visible = true;
            PlaceHolder2.Visible = false;
            PlaceHolder3.Visible = false;
        }
        else
        {
            PlaceHolder1.Visible = false;
            PlaceHolder2.Visible = true;
            PlaceHolder3.Visible = false;
        }

    }


    protected void FoodType_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (FoodType.Text == "全部")
        {
            PlaceHolder1.Visible = true;
            PlaceHolder2.Visible = false;
            PlaceHolder3.Visible = false;
        }
        else
        {
            PlaceHolder1.Visible = false;
            PlaceHolder2.Visible = true;
            PlaceHolder3.Visible = false;
        }
    }
}