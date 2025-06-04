using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Text;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.DireccionGeneral
{
    public partial class Reciprocos : System.Web.UI.Page
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
                CargarDatos();
            }
        }

        public DateTime? ValidaFecha(String Fecha)
        {
            DateTime oFecha;
            if (DateTime.TryParse(Fecha, out oFecha))
            {
                var hoy = DateTime.Now;

                if (oFecha > hoy)
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
            Response.Redirect("~/Paginas/DireccionGeneral/Reciprocos.aspx", false);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {

            if (txtFechaInicial.Text == string.Empty)
            {
                Alerta("Error, en la Fecha Inicial");
                txtFechaInicial.Focus();
                return;
            }

            if (ValidaFecha(txtFechaFinal.Text) == null)
            {
                Alerta("Error, en la Fecha Final");
                txtFechaFinal.Focus();
                return;
            }

            if (txtFechaInicial.Text == txtFechaFinal.Text)
            {
                Alerta("Atención, la Fecha Inicial y Final son Iguales");
                return;
            }

            IniciarEjecutarReciprocos();
            btnBuscar.Enabled = false ;
            btnExportar.Enabled = false;
        }

        private void IniciarEjecutarReciprocos()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[dbo].[Usp_IniciarEjecutarGenerarReciprocas]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@FechaInicial", SqlDbType.Text).Value = txtFechaInicial.Text.Trim().Replace("-", "");
                    cmd.Parameters.Add("@FechaFinal", SqlDbType.Text).Value = txtFechaFinal.Text.Trim().Replace("-", "");

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                    Alerta("Atención, se programó la Generación de los Reciprocos");
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
                var Textocmd = "[dbo].[Usp_BuscarControlReciprocas]";
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
                            txtMensaje.Text = reader[0].ToString();
                            hdfEstadoProceso.Value = reader[1].ToString();
                            hdFechaInicial.Value = reader[2].ToString();
                            hdFechaFinal.Value = reader[3].ToString();
                        }
                        con.Close();

                        if (hdfEstadoProceso.Value == "1")
                        {
                            btnBuscar.Enabled = false;
                            txtFechaInicial.Enabled = false;
                            txtFechaFinal.Enabled = false;
                            txtFechaInicial.Text = hdFechaInicial.Value.Substring(0, 4) + "-" + hdFechaInicial.Value.Substring(4, 2) + "-" + hdFechaInicial.Value.Substring(6, 2);
                            txtFechaFinal.Text = hdFechaFinal.Value.Substring(0, 4) + "-" + hdFechaFinal.Value.Substring(4, 2) + "-" + hdFechaFinal.Value.Substring(6, 2);
                        }

                        if (hdfEstadoProceso.Value == "2")
                        {
                            btnBuscar.Enabled = false;
                            txtFechaInicial.Enabled = false;
                            txtFechaFinal.Enabled = false;
                            txtFechaInicial.Text = hdFechaInicial.Value.Substring(0, 4) + "-" + hdFechaInicial.Value.Substring(4, 2) + "-" + hdFechaInicial.Value.Substring(6, 2);
                            txtFechaFinal.Text = hdFechaFinal.Value.Substring(0, 4) + "-" + hdFechaFinal.Value.Substring(4, 2) + "-" + hdFechaFinal.Value.Substring(6, 2);
                        }

                        if (hdfEstadoProceso.Value == "3")
                        {
                            btnExportar.Visible = true;
                            btnBuscar.Enabled = true;
                            txtFechaInicial.Enabled = true;
                            txtFechaFinal.Enabled = true;
                        }
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }

            }
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            try
            {
                string PathArchivo = "EntidadPublicaReciprocas_" + hdFechaInicial.Value.Trim() + "_" + hdFechaFinal.Value.Trim() + ".txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[dbo].[Usp_BuscarPagosReciprocas]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
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
                            Alerta("Alerta: No hay Registros");
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