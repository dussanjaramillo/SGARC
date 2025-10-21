using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebLiquidador.Paginas.ProduccionCentros.Factura
{
    public partial class FacturasXRegionalXMesAñoXCentro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if ((new List<string> { "1", "2", "3", "4", "6", "7", "8" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }

            if (!IsPostBack)
            {
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
            }
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            if (grvFacturasXRegionalXMesAñoXCentro0.Rows.Count == 0)
            {
                Alerta("Atención, No Hay Facturas");
                return;
            }
            grvFacturasXRegionalXMesAñoXCentro0.Visible = true;
            grvFacturasXRegionalXMesAñoXCentro0.Caption = "FacturasXRegionalXMesAñoXCentro_" + lblEstado.Text;

            //grvFacturasXRegionalXMesAñoXCentro0.GridLines = GridLines.Both;

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvFacturasXRegionalXMesAñoXCentro0.AllowPaging = false;
            grvFacturasXRegionalXMesAñoXCentro0.AllowSorting = false;
            grvFacturasXRegionalXMesAñoXCentro0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvFacturasXRegionalXMesAñoXCentro0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "FacturasXRegionalXMesAñoXCentro_" + lblEstado.Text + ".xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvFacturasXRegionalXMesAñoXCentro0.Visible = false;
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