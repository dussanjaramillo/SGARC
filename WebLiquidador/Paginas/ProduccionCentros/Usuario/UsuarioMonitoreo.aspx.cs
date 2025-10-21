using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Threading;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Usuario
{
    public partial class UsuarioMonitoreo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            grvMonitoreo.Visible = true;
            grvMonitoreo.Caption = "MonitoreoUsuario";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvMonitoreo.AllowPaging = false;
            grvMonitoreo.AllowSorting = false;
            grvMonitoreo.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvMonitoreo);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "MonitoreoUsuario.xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvMonitoreo.Visible = false;
        }

        protected void grvMonitoreoUsuario_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (Session["_IdCargo"].ToString() != "5")
            {
                if (e.Row.RowType == DataControlRowType.Header)
                {
                    e.Row.Cells[0].Enabled = false;
                }
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Cells[0].Enabled = false;
                }
            }
        }

        protected void ddlRegional_DataBound(object sender, EventArgs e)
        {
            ddlRegional.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlCentroFormacion_DataBound(object sender, EventArgs e)
        {
            ddlCentroFormacion.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Usuario/UsuarioMonitoreo.aspx", false);
        }

        protected void ddlCentroFormacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            grvMonitoreoUsuario.Visible = false; 
        }
    }
}