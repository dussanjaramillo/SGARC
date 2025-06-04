using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.CuponPago
{
    public partial class CuponPagoDistribuido : System.Web.UI.Page
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

            }
        }

        protected void grvCuponPagoDistribuido_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfNumeroInterno.Value = grvCuponPagoDistribuido.SelectedRow.Cells[1].Text;
            grvCuponPagoDistribuidoDetalle.Visible = true; 
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/CuponPago/CuponPagoDistribuido.aspx", false);
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

        protected void grvCuponPagoDistribuido_PageIndexChanged(object sender, EventArgs e)
        {
            grvCuponPagoDistribuido.SelectedIndex = -1;
            grvCuponPagoDistribuidoDetalle.Visible = false;  

        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            grvCuponPagoDistribuidoDetalleExportar.Visible = true;
            grvCuponPagoDistribuidoDetalleExportar.Caption = "Cupon_Pago_Distribuido" ;
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvCuponPagoDistribuidoDetalleExportar.AllowPaging = false;
            grvCuponPagoDistribuidoDetalleExportar.AllowSorting = false;
            grvCuponPagoDistribuidoDetalleExportar.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvCuponPagoDistribuidoDetalleExportar);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "Cupon_Pago_Distribuido.xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvCuponPagoDistribuidoDetalleExportar.Visible = false;
        }
    }
}