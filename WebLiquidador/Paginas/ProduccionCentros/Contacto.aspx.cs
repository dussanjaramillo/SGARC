using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebLiquidador.Paginas.ProduccionCentros
{
    //--- Autor: Ingeniero Ricardo Vanegas Ricci
    //--- Celular 314 35 65 719 
    //--- Derechos de Autor: Ricardo Vanegas Ricci
    public partial class Contacto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }
        }
    }
}