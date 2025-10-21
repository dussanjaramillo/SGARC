using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using System.Text;
using System.Drawing;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Catalogo
{
    public partial class ConsultaProductoXCodigo : System.Web.UI.Page
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
                txtCodigoProducto.Focus();
                hfExiste.Value = "0";
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            if (grvNombreProducto.Rows.Count == 0 && hfExiste.Value == "1")
            {
                Alerta("Atención!!!! No hay Productos con el Código Especificado");
            }
            txtCodigoProducto.Text = txtCodigoProducto.Text.Trim();
            if (txtCodigoProducto.Text.Trim().Length < 3)
            {
                Alerta("Alerta el Codigo del Producto a Buscar debe tener Mínimo 10 Caracteres");
                txtCodigoProducto.Text = "";
                txtCodigoProducto.Focus();
                return;
            }
            btnBuscar.Enabled = false;
            txtCodigoProducto.Enabled = false;
        }


        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Catalogo/ConsultaProductoXCodigo.aspx", false);
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

        protected void grvNombreProducto_DataBound(object sender, EventArgs e)
        {
            if (grvNombreProducto.Rows.Count == 0 && IsPostBack)
            {
                Alerta("Atención!!!! No hay Productos con el Código Especificado");
                hfExiste.Value = "1";
            }
        }
    }
}