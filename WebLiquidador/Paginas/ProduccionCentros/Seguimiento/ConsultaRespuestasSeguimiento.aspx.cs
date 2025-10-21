using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Seguimiento
{
    public partial class ConsultaRespuestasSeguimiento : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            if (grvRespuestaCentro0.Rows.Count == 0)
            {
                Alerta("Atención, No hay Respuestas de Seguimiento para su Centro");
                return;
            }
            grvRespuestaCentro0.Visible = true;
            grvRespuestaCentro0.Caption = "Respuesta Seguimiento "+ Session["_NombreCentroFormacion"].ToString();
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvRespuestaCentro0.AllowPaging = false;
            grvRespuestaCentro0.AllowSorting = false;
            grvRespuestaCentro0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvRespuestaCentro0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "RespuestasSeguimiento_"+ Session["_NombreCentroFormacion"].ToString()+".xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvRespuestaCentro0.Visible = false;
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

        protected void grvRespuestaCentro_SelectedIndexChanged(object sender, EventArgs e)
        {
            hdId.Value = grvRespuestaCentro.SelectedRow.Cells[1].Text;
            grvRespuestas.Visible = true;
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Seguimiento/ConsultaRespuestasSeguimiento.aspx", false);
        }

        protected void grvRespuestaCentro_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvRespuestaCentro.SelectedIndex = -1;
            grvRespuestas.Visible = false; 
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            btnExportar.Enabled = true;
        }
    }
}