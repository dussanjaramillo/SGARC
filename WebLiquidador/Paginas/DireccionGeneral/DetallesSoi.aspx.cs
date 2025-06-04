using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using System.Text;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.DireccionGeneral
{
    public partial class DetallesSoi : System.Web.UI.Page
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
                CargarDatos();
            }
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            if (Convert.ToDecimal(txtFechaInicial.Text) > Convert.ToDecimal(txtFechaFinal.Text))
            {
                Alerta("Error: en la Fecha Inicial");
                btnExportar.Enabled = false;
                txtFechaInicial.Focus();
                return;
            }

            try
            {
                string PathArchivo = "DetallesSoi_" + txtFechaInicial.Text.Trim() + "_" + txtFechaFinal.Text.Trim() + ".txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[dbo].[Usp_BuscarDetallesSoi]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandTimeout = 0;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    con.Close();

                    if (dt.Rows.Count > 0)
                    {
                        StringBuilder sb = new StringBuilder();
                        IEnumerable<string> columnNames = dt.Columns.Cast<DataColumn>().Select(column => column.ColumnName);
                        sb.AppendLine(string.Join("|", columnNames));

                        foreach (DataRow row in dt.Rows)
                        {
                            IEnumerable<string> fields = row.ItemArray.Select(field => field.ToString());
                            sb.AppendLine(string.Join("|", fields));
                        }

                        if (sb.Length > 0)
                        {
                            Response.Clear();
                            Response.Buffer = true;
                            Response.ContentType = "application/text/plain";
                            Response.AddHeader("Content-Disposition", "attachment;filename=" + PathArchivo);
                            Response.Charset = "UTF-8";
                            Response.ContentEncoding = System.Text.Encoding.Default;
                            Response.Write(sb.ToString());
                            Response.End();
                        }
                        else
                        {
                            Alerta("Alerta: No Hay Registros");
                            return;
                        }
                    }
                }

            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }
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

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/DireccionGeneral/DetallesSoi.aspx", false);
        }

        protected void txtFechaFinal_TextChanged(object sender, EventArgs e)
        {
            btnCalcular.Enabled = true;
            btnExportar.Enabled = false;
            btnExportarError.Enabled = false;
        }

        protected void btnCalcular_Click(object sender, EventArgs e)
        {
            if (Convert.ToInt64(txtFechaFinal.Text) < Convert.ToInt64(txtFechaInicial.Text))
            {
                Alerta("Alerta, la fecha Final debe ser Igual o Mayor a la Fecha Inicial: " );
                txtFechaFinal.Focus(); 
                return;
            }
           
            btnCalcular.Enabled = false;
            txtFechaInicial.Enabled = false;
            txtFechaFinal.Enabled = false;
            btnExportar.Enabled = false;
            ControlDetallesSoiUpdate();
            IniciarEjecutarDetallesSoi();
        }

        private void ControlDetallesSoiUpdate()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[dbo].[Usp_ControlDetallesSoiUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add(new SqlParameter("@FechaInicial", txtFechaInicial.Text.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@FechaFinal", txtFechaFinal.Text.ToString()));

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                    return;
                }
            }
        }

        private void IniciarDetallesSoiUpdate()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[dbo].[Usp_ControlDetallesSoiInicioUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                    return;
                }
            }
        }

        private void IniciarEjecutarDetallesSoi()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    //var FechaInicio = System.DateTime.Now;
                    //FechaInicio = FechaInicio.AddMinutes(2);
                    //var HoraInicio = FechaInicio.ToString("HHmmss");

                    int vResultado;
                    var Textocmd = "[dbo].[Usp_IniciarEjecutarDetallesSoi]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                    return;
                }
            }
        }

        private void CargarDatos()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_BuscaControlDetallesSoi]";
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
                            txtFechaInicial.Text = reader[0].ToString();
                            txtFechaFinal.Text = reader[1].ToString();
                            txtMensaje.Text = reader[2].ToString();
                            hdfEstado.Value = reader[3].ToString();
                        }
                        con.Close();

                        if (hdfEstado.Value == "0")
                        {
                            btnCalcular.Enabled = true;
                            txtFechaInicial.Enabled = true;
                            txtFechaFinal.Enabled = true;
                            txtFechaInicial.Text = "";
                            txtFechaFinal.Text = "";
                            txtFechaInicial.Focus();
                            btnExportar.Enabled = true;  
                        }

                        if (hdfEstado.Value == "1")
                        {
                            txtFechaInicial.Enabled = false;
                            txtFechaFinal.Enabled = false;
                            btnExportarError.Enabled = false;
                            btnExportar.Enabled = false;
                            btnCalcular.Enabled = false;
                        }

                        if (hdfEstado.Value == "2")
                        {
                            txtFechaInicial.Enabled = false;
                            txtFechaFinal.Enabled = false;
                            btnExportarError.Enabled = true;
                            btnExportar.Enabled = false;
                            btnCalcular.Enabled = false;
                        }

                        if (hdfEstado.Value == "3")
                        {
                            txtFechaInicial.Enabled = true;
                            txtFechaFinal.Enabled = true;
                            btnExportarError.Enabled = false;
                            btnExportar.Enabled = true;
                            btnCalcular.Enabled = true;
                        }
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }

            }
        }

        protected void btnExportarError_Click(object sender, EventArgs e)
        {
            try
            {
                IniciarDetallesSoiUpdate();

                string PathArchivo = "DetallesSoi_Error_" + txtFechaInicial.Text.Trim() + "_" + txtFechaFinal.Text.Trim() + ".txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[dbo].[Usp_BuscarDetallesSoiError]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandTimeout = 0;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    con.Close();

                    if (dt.Rows.Count > 0)
                    {
                        StringBuilder sb = new StringBuilder();
                        IEnumerable<string> columnNames = dt.Columns.Cast<DataColumn>().Select(column => column.ColumnName);
                        sb.AppendLine(string.Join("|", columnNames));

                        foreach (DataRow row in dt.Rows)
                        {
                            IEnumerable<string> fields = row.ItemArray.Select(field => field.ToString());
                            sb.AppendLine(string.Join("|", fields));
                        }

                        if (sb.Length > 0)
                        {
                            Response.Clear();
                            Response.Buffer = true;
                            Response.ContentType = "application/text/plain";
                            Response.AddHeader("Content-Disposition", "attachment;filename=" + PathArchivo);
                            Response.Charset = "UTF-8";
                            Response.ContentEncoding = System.Text.Encoding.Default;
                            Response.Write(sb.ToString());
                            Response.End();
                        }
                        else
                        {
                            Alerta("Alerta: No Hay Registros");
                            return;
                        }
                    }
                }

            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }

        }
    }
}