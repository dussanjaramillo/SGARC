using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Threading;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.AtencionCiudadano
{
    public partial class EstadoCuenta : System.Web.UI.Page
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
                txtIdentificacion.Focus();
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            if (txtIdentificacion.Text == string.Empty)
            {
                Alerta("Error, Falta el Numero de Identificación");
                txtIdentificacion.Focus();
                return;
            }
            txtIdentificacion.Enabled = false;
            btnBuscar.Enabled = false;
        }

        protected void btn_Limpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/AtencionCiudadano/EstadoCuenta.aspx", false);
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

        protected void grvAportantes_DataBound(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (grvAportantes.Rows.Count == 0)
                {
                    Alerta("Atención, La Identificación No Se Encuentra Registrada en la Base de Datos de Cartera");
                    txtIdentificacion.Enabled = true;
                    btnBuscar.Enabled = true;
                    txtIdentificacion.Focus();
                }
                else
                {
                    btnReporte.Visible = true; 
                }
            }
        }

        protected void btnReporte_Click(object sender, EventArgs e)
        {
            Session["_Opcion"] = "1";
            Session["_Identificacion"] = txtIdentificacion.Text.Trim();
            //Response.Redirect("~/Paginas/AtencionCiudadano/VisorEstadoCuenta.aspx", false);

            string _open = "window.open('VisorEstadoCuenta.aspx', '_blank');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), _open, true);
        }

    }
}