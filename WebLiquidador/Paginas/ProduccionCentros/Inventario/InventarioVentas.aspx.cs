using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Globalization;
using System.Threading;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Inventario
{
    public partial class InventarioVentas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if ((new List<string> { "1", "2", "3", "4", "6", "7", "8", "9" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }

            if (!IsPostBack)
            {
                txtFechaInicial.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtFechaFinal.Text = DateTime.Now.ToString("yyyy-MM-dd");
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
            }
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            if (grvInventarioVentas.Rows.Count == 0)
            {
                Alerta("Atención, No hay Registros");
                return; 
            }
            
            
            grvInventarioVentas0.Visible = true;
            grvInventarioVentas0.Caption = "InventarioMovimientosVentas_" + Session["_NombreCentroFormacion"].ToString() + "_Desde:_" + txtFechaInicial.Text.Replace("-", "_") + "_Hasta:_" + txtFechaFinal.Text.Replace("-", "_");
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvInventarioVentas0.AllowPaging = false;
            grvInventarioVentas0.AllowSorting = false;
            grvInventarioVentas0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvInventarioVentas0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "InventarioMovimientosVentas_" + Session["_NombreCentroFormacion"].ToString() + "_Desde:_" + txtFechaInicial.Text.Replace("-", "_") + "_Hasta:_" + txtFechaFinal.Text.Replace("-", "_") + ".xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvInventarioVentas0.Visible = false;

        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {

        }

        protected void btn_Limpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Inventario/InventarioVentas.aspx", false);
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

    }
}