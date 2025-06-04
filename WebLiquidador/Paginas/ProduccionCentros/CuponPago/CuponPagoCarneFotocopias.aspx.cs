using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebLiquidador.Paginas.ProduccionCentros.CuponPago
{
    public partial class CuponPagoCarneFotocopias : System.Web.UI.Page
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
                txtFechaInicial.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtFechaInicial_CalendarExtender.StartDate = Convert.ToDateTime("2022-01-01");
                txtFechaInicial_CalendarExtender.EndDate = DateTime.Now; 

                txtFechaFinal.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtFechaFinal_CalendarExtender.StartDate = Convert.ToDateTime("2022-01-01");
                txtFechaFinal_CalendarExtender.EndDate = DateTime.Now;
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {

        }

        protected void btn_Limpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/CuponPago/CuponPagoCarneFotocopias.aspx", false);
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            grvCarneFotocopias0.Visible = true;
            grvCarneFotocopias0.Caption = "Ingresos_Carnet_Fotocopias"+ "_Desde:_" + txtFechaInicial.Text.Replace("-", "_") + "_Hasta:_" + txtFechaFinal.Text.Replace("-", "_");
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvCarneFotocopias0.AllowPaging = false;
            grvCarneFotocopias0.AllowSorting = false;
            grvCarneFotocopias0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvCarneFotocopias0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "Ingresos_Carnet_Fotocopias" + "_Desde:_" + txtFechaInicial.Text.Replace("-", "_") + "_Hasta:_" + txtFechaFinal.Text.Replace("-", "_") + ".xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvCarneFotocopias0.Visible = false;
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

        protected void grvCarneFotocopias_DataBound(object sender, EventArgs e)
        {
            if (grvCarneFotocopias.Rows.Count > 0 )
            {
                btnExportar.Visible = true;
            }
        }
    
    }
}