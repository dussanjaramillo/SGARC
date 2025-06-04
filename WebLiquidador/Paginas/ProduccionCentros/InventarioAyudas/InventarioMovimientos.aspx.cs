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

namespace WebLiquidador.Paginas.ProduccionCentros.InventarioAyudas
{
    public partial class InventarioMovimientos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            //Cargo
            //1 Coordinador
            //2 Abogado
            //3 Fiscalizador
            //4 Técnico
            //5 Administrador
            //6 Profesional
            //7 Siif - Nación
            //8 Subdirector
            //9 Producción
            //10 Control Interno

            if (!(new List<string> { "5", "9", "10" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }

            if (!IsPostBack)
            {
                txtFechaInicial.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtFechaFinal.Text = DateTime.Now.ToString("yyyy-MM-dd");
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();

                hdEstadoEmergencia.Value = "0";
                BuscarEstadoEmergencia();

                if (hdEstadoEmergencia.Value == "0")
                {
                    txtFechaInicial.Enabled = false;
                    txtFechaFinal.Enabled = false;
                    btnBuscar.Enabled = false;
                    btnExportar.Enabled = false;
                    btnImprimir.Enabled = false;
                    Alerta("Atención!! Su Centro No está Difinido cómo Apoyo Emergencia Económica");
                    return;
                }

            }
        }

        private void BuscarEstadoEmergencia()
        {
            hdEstadoEmergencia.Value = "0";
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarCentroFormacionEstadoEmergencia]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hdEstadoEmergencia.Value = reader[0].ToString();
                        }
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }


        protected void btnBuscar_Click(object sender, EventArgs e)
        {
    
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

        protected void btn_Limpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/InventarioAyudas/InventarioMovimientos.aspx", false);
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            if (grvInventarioMovimientos0.Rows.Count == 0)
            {
                Alerta("Atención, No hay Registros");
                return; 
            }
            
            grvInventarioMovimientos0.Visible = true;
            grvInventarioMovimientos0.Caption = "InventarioMovimientos_" + Session["_NombreCentroFormacion"].ToString() + "_Desde:_" + txtFechaInicial.Text.Replace("-", "_") + "_Hasta:_" + txtFechaFinal.Text.Replace("-", "_");
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvInventarioMovimientos0.AllowPaging = false;
            grvInventarioMovimientos0.AllowSorting = false;
            grvInventarioMovimientos0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvInventarioMovimientos0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "InventarioMovimientosApoyoEmergencia_" + Session["_NombreCentroFormacion"].ToString() + "_Desde:_" + txtFechaInicial.Text.Replace("-", "_") + "_Hasta:_" + txtFechaFinal.Text.Replace("-", "_") + ".xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvInventarioMovimientos0.Visible = false;
        }

        protected void btnImprimir_Click(object sender, EventArgs e)
        {
            if (grvInventarioMovimientos0.Rows.Count == 0)
            {
                Alerta("Atención, No hay Registros");
                return;
            }

            Session["_FechaInicial"] = txtFechaInicial.Text;
            Session["_FechaFinal"] = txtFechaFinal.Text;
            Response.Redirect("~/Paginas/ProduccionCentros/InventarioAyudas/Reportes/VisorInventarioMovimientosXCentro.aspx", false);
        }
    }
}