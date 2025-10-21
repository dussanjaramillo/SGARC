using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace WebLiquidador.Paginas.ProduccionCentros.Wompi
{
    public partial class ImprimirQr : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
                if (System.IO.File.Exists(Server.MapPath("~/Paginas/ProduccionCentros/Wompi/QrPagosRapidos/" + Session["_CodigoCentroFormacion"].ToString() + ".jpg")))
                {
                    btnImprimirQr.Enabled = true;
                }
            }
        }

        protected void btnImprimirQr_Click(object sender, EventArgs e)
        {
                string _open = "window.open('VisorQrWompi.aspx', '_blank');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), _open, true);
        }
    }
}