using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebLiquidador.Paginas.ProduccionCentros.Sirec
{
    public partial class PagosHoySirec : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            LblHoy.Text = DateTime.Now.ToString("dd-MM-yyyy");
        }

        protected void grvPagosRecibidosHoy_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (grvPagosRecibidosHoy.Rows.Count == 0)
                {
                    Alerta("No Hay Pagos en el Dia de Hoy para su Centro");
                    return;
                }
            }
        }

        protected void Alerta(string Mensaje)
        {
            //string message = "Hello! Mudassar.";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("alert('");
            sb.Append(Mensaje.Replace("'", "").Replace("\r\n", ""));
            sb.Append("')};");
            sb.Append("</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        }
    }
}