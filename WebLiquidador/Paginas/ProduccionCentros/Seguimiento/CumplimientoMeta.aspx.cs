using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Seguimiento
{
    public partial class CumplimientoMeta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }
            lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
            ddlAñoMesCuponPago.Focus();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            btnExportar.Enabled = true;
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            grvCumpliminetoMeta0.Visible = true;
            grvCumpliminetoMeta0.Caption = "Cumplimiento_Metas_" + ddlAñoMesCuponPago.SelectedValue;

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvCumpliminetoMeta0.AllowPaging = false;
            grvCumpliminetoMeta0.AllowSorting = false;
            grvCumpliminetoMeta0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvCumpliminetoMeta0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "Cumplimiento_Metas_" + ddlAñoMesCuponPago.SelectedValue + ".xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvCumpliminetoMeta0.Visible = false;
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Seguimiento/CumplimientoMeta.aspx", false);
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

        protected void grvCumpliminetoMeta_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (grvCumpliminetoMeta.Rows.Count == 0)
                {
                    Alerta("No Hay Registros");
                    btnBuscar.Enabled = false;
                    return;
                }
            }
        }

        protected void grvCumpliminetoMeta_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {

                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    string _Valor = DataBinder.Eval(e.Row.DataItem, "PorcentajeCumplimientoMes").ToString();
                    string _Meta = DataBinder.Eval(e.Row.DataItem, "Meta").ToString();

                    if (_Valor != String.Empty)
                    {
                        if (Convert.ToDecimal(_Valor) >= 0 && Convert.ToDecimal(_Valor) <= 35)
                        {
                            e.Row.Cells[7].BackColor = Color.Crimson;
                            e.Row.Cells[7].Font.Bold = true;

                            if (Convert.ToDecimal(_Meta) == 0)
                            {
                                e.Row.Cells[7].BackColor = Color.Empty;
                            }
                        }

                        if (Convert.ToDecimal(_Valor) > 35 && Convert.ToDecimal(_Valor) <= 70)
                        {
                            e.Row.Cells[7].BackColor = Color.Yellow;
                            e.Row.Cells[7].Font.Bold  = true;
                        }

                        if (Convert.ToDecimal(_Valor) > 70 && Convert.ToDecimal(_Valor) <= 100)
                        {
                            e.Row.Cells[7].BackColor = Color.LightGreen;
                            e.Row.Cells[7].Font.Bold = true;
                        }

                        if (Convert.ToDecimal(_Valor) > 100)
                        {
                            e.Row.Cells[7].BackColor = Color.LightBlue;
                            e.Row.Cells[7].Font.Bold = true;
                        }    
                    }
                }
            }
            catch (Exception err)
            {
                string error = err.Message.ToString() + " - " + err.Source.ToString();
            }
        }

        protected void grvCumpliminetoMeta0_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {

                if (e.Row.RowType == DataControlRowType.DataRow)
                {

                    string _Valor = DataBinder.Eval(e.Row.DataItem, "PorcentajeCumplimientoMes").ToString();
                    string _Meta = DataBinder.Eval(e.Row.DataItem, "Meta").ToString();

                    if (_Valor != String.Empty)
                    {
                        if (Convert.ToDecimal(_Valor) >= 0 && Convert.ToDecimal(_Valor) <= 35)
                        {
                            e.Row.Cells[7].BackColor = Color.Crimson;
                            e.Row.Cells[7].Font.Bold = true;

                            if (Convert.ToDecimal(_Meta) == 0)
                            {
                                e.Row.Cells[7].BackColor = Color.Empty;
                            }
                        }

                        if (Convert.ToDecimal(_Valor) > 35 && Convert.ToDecimal(_Valor) <= 70)
                        {
                            e.Row.Cells[7].BackColor = Color.Yellow;
                            e.Row.Cells[7].Font.Bold = true;
                        }

                        if (Convert.ToDecimal(_Valor) > 70 && Convert.ToDecimal(_Valor) <= 100)
                        {
                            e.Row.Cells[7].BackColor = Color.LightGreen;
                            e.Row.Cells[7].Font.Bold = true;
                        }

                        if (Convert.ToDecimal(_Valor) > 100)
                        {
                            e.Row.Cells[7].BackColor = Color.LightBlue;
                            e.Row.Cells[7].Font.Bold = true;
                        }
                    }
                }
            }
            catch (Exception err)
            {
                string error = err.Message.ToString() + " - " + err.Source.ToString();
            }
        }
    }
}