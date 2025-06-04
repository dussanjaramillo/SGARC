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

namespace WebLiquidador.Paginas.CostasProcesales.Reportes
{
    public partial class AccesoUsuario : System.Web.UI.Page
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
                txtFechaInicial_CalendarExtender.StartDate = Convert.ToDateTime("2022-05-01");
                txtFechaInicial_CalendarExtender.EndDate = DateTime.Now;
                txtFechaInicial.Text = DateTime.Now.ToString("yyyy-MM-dd");

                txtFechaFinal_CalendarExtender.StartDate = Convert.ToDateTime("2022-05-01");
                txtFechaFinal_CalendarExtender.EndDate = DateTime.Now;
                txtFechaFinal.Text = DateTime.Now.ToString("yyyy-MM-dd");
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
            //try
            //{
            //    var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            //    using (SqlConnection con = new SqlConnection(CadenaConexion))
            //    {
            //        var Textocmd = "[CostasProcesales].[Usp_BuscarAccesoUsuarios]";
            //        SqlCommand cmd = new SqlCommand(Textocmd, con);
            //        cmd.CommandType = System.Data.CommandType.StoredProcedure;
            //        cmd.Parameters.AddWithValue("@FechaInicial", txtFechaInicial.Text.Trim());
            //        cmd.Parameters.AddWithValue("@FechaFinal", txtFechaFinal.Text.Trim());
            //        cmd.CommandTimeout = 0;
            //        SqlDataAdapter da = new SqlDataAdapter(cmd);
            //        DataTable dt = new DataTable();
            //        da.Fill(dt);
            //        grvUsuariosCostas.DataSource = dt;
            //        grvUsuariosCostas.DataBind();
            //        con.Close();
            //    }
            //}
            //catch (SqlException ex)
            //{
            //    Alerta("Error: " + ex.Message);
            //    return;
            //}

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
            Response.Redirect("~/Paginas/CostasProcesales/Reportes/AccesoUsuario.aspx", false);
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
                grvUsuariosCostas.Visible = true;
                grvUsuariosCostas.Caption = "AccesoAbogados" + "_Desde:_" + txtFechaInicial.Text.Replace("-", "_") + "_Hasta:_" + txtFechaFinal.Text.Replace("-", "_"); 
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                System.IO.StringWriter sw = new System.IO.StringWriter(sb);
                HtmlTextWriter htw = new HtmlTextWriter(sw);

                Page page = new Page();
                System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

                grvUsuariosCostas.AllowPaging = false;
                grvUsuariosCostas.AllowSorting = false;
                grvUsuariosCostas.EnableViewState = false;

                // Deshabilitar la validación de eventos, sólo asp.net 2
                page.EnableEventValidation = false;

                // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
                page.DesignerInitialize();

                page.Controls.Add(form);
                form.Controls.Add(grvUsuariosCostas);

                page.RenderControl(htw);

                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("Content-Disposition", "attachment;filename=" + "AccesoAbogados"+"_Desde:_" + txtFechaInicial.Text.Replace("-", "_") + "_Hasta:_" + txtFechaFinal.Text.Replace("-", "_") + ".xls");
                Response.Charset = "UTF-8";
                Response.ContentEncoding = System.Text.Encoding.Default;
                Response.Write(sb.ToString());
                Response.End();
                grvUsuariosCostas.Visible = false;
        }

        protected void grvUsuariosCostas_DataBound(object sender, EventArgs e)
        {
            if (grvUsuariosCostas.Rows.Count > 0)
            {
                btnExportar.Visible = true;
            }
        }
    }
}