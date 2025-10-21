using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebLiquidador.Paginas.ProduccionCentros.Catalogo
{
    public partial class CatalogoProductoNoUsados : System.Web.UI.Page
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
            if (grvProductosNoUsado0.Rows.Count == 0)
            {
                Alerta("Atención, No Hay Productos No Usados o Su Centro No Tiene Cátalogo de Productos");
                return;
            }
            grvProductosNoUsado0.Visible = true;
            grvProductosNoUsado0.Caption = "Productos No Usados";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvProductosNoUsado0.AllowPaging = false;
            grvProductosNoUsado0.AllowSorting = false;
            grvProductosNoUsado0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvProductosNoUsado0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "ProductosNoUsados.xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvProductosNoUsado0.Visible = false;
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

        protected void grvProductosNoUsado_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (grvProductosNoUsado.Rows.Count == 0)
                {
                    Alerta("Atención, No Hay Productos No Usados o Su Centro No Tiene Cátalogo de Productos");
                }
            }
        }
    }
}