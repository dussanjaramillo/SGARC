using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebLiquidador.Paginas.ProduccionCentros.CuponPago
{
    public partial class ConsultaCuponPago : System.Web.UI.Page
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
                if (Request.QueryString.Get("id") != null)
                {
                    txtCuponPago.Text = Request.QueryString.Get("id");
                }
                txtCuponPago.Focus();
                hfExiste.Value = "0";
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
            }
        }


        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            if (grvCuponDePago.Rows.Count == 0 && hfExiste.Value == "1")
            {
                Alerta("Atención!!!! el Cupón de Pago: "+ txtCuponPago.Text.Trim()+ " No Existe en La Base de Datos");
            }
            txtCuponPago.Enabled = false;
            btnBuscar.Enabled = false;
        }
        protected void Alerta(string Mensaje)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("alert('");
            sb.Append(Mensaje.Replace("'", "").Replace("\r\n", ""));
            sb.Append("')};");
            sb.Append("</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/CuponPago/ConsultaCuponPago.aspx", false);
        }

        protected void grvCuponDePago_DataBound(object sender, EventArgs e)
        {
            if (grvCuponDePago.Rows.Count == 0 && IsPostBack)
            {
                Alerta("Atención!!!! el Cupón de Pago: " + txtCuponPago.Text.Trim() + " No Existe en La Base de Datos");
                hfExiste.Value = "1";
            }
        }
    }
}