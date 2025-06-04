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

namespace WebLiquidador.Paginas.ProduccionCentros.CuponPago
{
    public partial class IngresosXCentro : System.Web.UI.Page
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
                txtFechaFinal.Text = DateTime.Now.ToString("yyyy-MM-dd");
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
                //BuscarFechaFinal();
            }
        }

        public DateTime? ValidaFecha(String Fecha)
        {
            DateTime oFecha;
            if (DateTime.TryParse(Fecha, out oFecha))
            {
                var hoy = DateTime.Now;
                int yhoy = hoy.Year;
                int yFecha = oFecha.Year;

                if (oFecha > hoy)
                {
                    return null;
                }
                if (yFecha < yhoy)
                {
                    return null;
                }
                return oFecha;
            }
            else
            {
                return null;
            }
        }

        private void BuscarFechaFinal()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarFechaMinMaxCuponPago]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            txtFechaFinal.Text = Convert.ToDateTime(reader[1]).ToShortDateString().Replace("/", "-");
                            //txtFechaFinal.Text = Convert.ToDateTime(reader[1]["DateField"]).ToString("dd/MM/yyyy");
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
            try
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[CentroFormacion].[Usp_BuscarIngresosXCentro]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FechaInicial", txtFechaInicial.Text.Trim());
                    cmd.Parameters.AddWithValue("@FechaFinal", txtFechaFinal.Text.Trim());
                    cmd.Parameters.AddWithValue("@IdCentroFormacion", Convert.ToInt32(Session["_IdCentroFormacion"].ToString()));
                    cmd.CommandTimeout = 0;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    grvIngresosXCentro.DataSource = dt;
                    grvIngresosXCentro.DataBind();
                    con.Close();
                }
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }

            if (grvIngresosXCentro.Rows.Count > 0)
            {
                btnExportar.Visible = true;
            }
            else
            {
                Alerta("Atención, No hay Registros");
                btnExportar.Visible = false;
            }
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
            Response.Redirect("~/Paginas/ProduccionCentros/CuponPago/IngresosXCentro.aspx", false);
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
                grvIngresosXCentro.Visible = true;
                grvIngresosXCentro.Caption = "Ingresos_" + Session["_NombreCentroFormacion"].ToString() + "_Desde:_" + txtFechaInicial.Text.Replace("-", "_") + "_Hasta:_" + txtFechaFinal.Text.Replace("-", "_"); 
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                System.IO.StringWriter sw = new System.IO.StringWriter(sb);
                HtmlTextWriter htw = new HtmlTextWriter(sw);

                Page page = new Page();
                System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

                grvIngresosXCentro.AllowPaging = false;
                grvIngresosXCentro.AllowSorting = false;
                grvIngresosXCentro.EnableViewState = false;

                // Deshabilitar la validación de eventos, sólo asp.net 2
                page.EnableEventValidation = false;

                // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
                page.DesignerInitialize();

                page.Controls.Add(form);
                form.Controls.Add(grvIngresosXCentro);

                page.RenderControl(htw);

                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("Content-Disposition", "attachment;filename=" + "Ingresos_" + Session["_NombreCentroFormacion"].ToString() + "_Desde:_" + txtFechaInicial.Text.Replace("-", "_") + "_Hasta:_" + txtFechaFinal.Text.Replace("-", "_") + ".xls");
                Response.Charset = "UTF-8";
                Response.ContentEncoding = System.Text.Encoding.Default;
                Response.Write(sb.ToString());
                Response.End();
                grvIngresosXCentro.Visible = false;
        }
    }
}