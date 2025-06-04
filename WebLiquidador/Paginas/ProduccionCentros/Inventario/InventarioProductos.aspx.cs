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
    public partial class InventarioProductos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if ((new List<string> {"1", "2", "3", "4", "6", "7", "8", "9" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }
            lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            //    using (SqlConnection con = new SqlConnection(CadenaConexion))
            //    {
            //        var Textocmd = "[CentroFormacion].[Usp_BuscarInventarioProductos]";
            //        SqlCommand cmd = new SqlCommand(Textocmd, con);
            //        cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //        cmd.Parameters.AddWithValue("@IdCentroFormacion", Convert.ToInt32(Session["_IdCentroFormacion"].ToString()));
            //        cmd.Parameters.AddWithValue("@FechaInicial", txtFechaInicial.Text.Trim());
            //        cmd.Parameters.AddWithValue("@FechaFinal", txtFechaFinal.Text.Trim());

            //        cmd.CommandTimeout = 0;
            //        SqlDataAdapter da = new SqlDataAdapter(cmd);
            //        DataTable dt = new DataTable();
            //        da.Fill(dt);
            //        grvMovimientos.DataSource = dt;
            //        grvMovimientos.DataBind();
            //        con.Close();
            //    }
            //}
            //catch (SqlException ex)
            //{
            //    Alerta("Error: " + ex.Message);
            //    return;
            //}

            //if (grvMovimientos.Rows.Count > 0)
            //{
            //    btnExportar.Visible = true;
            //}
            //else
            //{
            //    Alerta("Atención, No hay Registros");
            //    btnExportar.Visible = false;
            //}

        }

        protected void btn_Limpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Inventario/Movimientos.aspx", false);
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            grvMovimientos0.Visible = true;
            grvMovimientos0.Caption = "InventarioProductos_" + Session["_NombreCentroFormacion"].ToString() + "_Fecha_" + DateTime.Now.ToString("yyyy_MMM_dd_HH_mm_ss"); 
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvMovimientos0.AllowPaging = false;
            grvMovimientos0.AllowSorting = false;
            grvMovimientos0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvMovimientos0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "InventarioProductos_" + Session["_NombreCentroFormacion"].ToString() + "_Fecha_" + DateTime.Now.ToString("yyyy_MMM_dd_HH_mm_ss") + ".xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvMovimientos0.Visible = false;

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