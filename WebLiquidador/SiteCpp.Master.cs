using System;

namespace WebLiquidador
{
    public partial class SiteCpp : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            var CambioClave = (string)Session["_CambioClave"];

            if (CambioClave == "1")
            {
                NavigationMenu.Enabled = false;
            }

            if (!IsPostBack)
            {
                try
                {
                    LblNombreUsuario.Text = Session["_NombreUsuario"].ToString() + " - " + Session["_NombreCargo"].ToString(); ;
                    LblNombreEntidad.Text = Session["_NombreRegionalUsuario"].ToString() ;
                    LblFecha.Text = DateTime.Now.ToString("dddd, dd MMMM yyyy");
                }
                catch (Exception ex)
                {
                    LblNombreUsuario.Text = ex.Message;
                    return;
                }
            }
        }
    }
}