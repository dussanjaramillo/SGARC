using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Presupuesto
{
    public partial class PresupuestoXRegional : System.Web.UI.Page
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
                hfLote.Value = "";
            }
        }

        protected void btnInicial_Click(object sender, EventArgs e)
        {
            hfLote.Value = "1";
            btnExportar.Enabled = true;
        }

        protected void btnActual_Click(object sender, EventArgs e)
        {
            hfLote.Value = "2";
            btnExportar.Enabled = true;
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            grvPresupuestoXRegional0.Visible = true;
            string TipoPresupuesto = "";
            
            if (hfLote.Value == "1")
            {
                TipoPresupuesto = "Presupuesto_Inicial_Regional_" + Session["_NombreRegionalUsuario"].ToString();
            }
            if (hfLote.Value == "2")
            {
                TipoPresupuesto = "Presupuesto_Actual_Regional_" + Session["_NombreRegionalUsuario"].ToString() ;
            }
            grvPresupuestoXRegional0.Caption = TipoPresupuesto;
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvPresupuestoXRegional0.AllowPaging = false;
            grvPresupuestoXRegional0.AllowSorting = false;
            grvPresupuestoXRegional0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvPresupuestoXRegional0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + TipoPresupuesto + ".xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvPresupuestoXRegional0.Visible = false;

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

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Presupuesto/PresupuestoXRegional.aspx", false);
        }

    }
}