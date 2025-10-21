using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebLiquidador.App_Code;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Globalization;
using System.Threading;
using System.IO;
using System.Text;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.Ugpp
{
    public partial class AvisoIncumplimiento : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            //Cargos
            //1   01  Coordinador
            //2   02  Abogado
            //3   03  Fiscalizador
            //4   04  Técnico
            //5   05  Administrador
            //6   06  Profesional
            //7   07  Siif - Nación
            //8   08  Subdirector
            //9   09  Producción
            //10  10  Control Interno

            if (!(new List<string> { "5" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/Default.aspx");
            }

            if (!IsPostBack)
            {
                CargarDatos();
            }
        }

        private void CargarDatos()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_BuscaControlUgpp]";
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
                            txtFechaCalculo.Text = Convert.ToDateTime(reader[1]).ToShortDateString();
                            hfFechaCalculada.Value = Convert.ToDateTime(reader[1]).ToShortDateString();
                            txtCodigoAdministradora.Text = reader[4].ToString();
                            txtNombreAdministradora.Text = reader[5].ToString();
                            txtMensaje.Text = reader[6].ToString();
                            hdfEstadoProceso.Value = reader[7].ToString();
                            txtVigencia.Text = reader[14].ToString();

                            if (reader[15].ToString() == "1")
                            {
                                ddlGenerarAportantes.SelectedValue = "Si";
                            }
                            else
                            {
                                ddlGenerarAportantes.SelectedValue = "No";
                            }
                        }
                        con.Close();

                        if (hdfEstadoProceso.Value == "0")
                        {
                            btnCalcular.Enabled = true;
                            txtFechaCalculo.Enabled = true;
                            //txtVigencia.Enabled = true;
                            //ddlGenerarAportantes.Enabled = true;
                            btnDesagregadoDiario.Enabled = false;
                        }
                        if (hdfEstadoProceso.Value == "1")
                        {
                            btnCalcular.Enabled = false;
                            txtFechaCalculo.Enabled = false;
                            //txtVigencia.Enabled = false;
                            //ddlGenerarAportantes.Enabled = false;
                            btnDesagregadoDiario.Enabled = false;
                        }
                        if (hdfEstadoProceso.Value == "2")
                        {
                            btnCalcular.Enabled = false;
                            txtFechaCalculo.Enabled = false;
                            //txtVigencia.Enabled = false;
                            //ddlGenerarAportantes.Enabled = false;
                            btnDesagregadoDiario.Enabled = true;
                        }
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }

            }
        }

        private void BuscarFechaCalculo()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_BuscaFechaCalculoUgpp]";
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
                            hfFechaCalculada.Value = Convert.ToDateTime(reader[0]).ToShortDateString();
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

        public DateTime? ValidaFecha(String Fecha)
        {
            DateTime oFecha;
            if (DateTime.TryParse(Fecha, out oFecha))
            {
                if (oFecha > DateTime.Now)
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

        protected void btnCalcular_Click(object sender, EventArgs e)
        {
            if (ValidaFecha(txtFechaCalculo.Text) == null)
            {
                Alerta("La Fecha es Incorrecta");
                txtFechaCalculo.Focus();
                return;
            }

            BuscarFechaCalculo();

            if (hfFechaCalculada.Value == txtFechaCalculo.Text)
            {
                Alerta("Error La Fecha Seleccionada ya fue Calculada");
                txtFechaCalculo.Focus();
                return;
            }

            //var FechaInicial =  "01/" + txtFechaCalculo.Text.Substring(3, 2)+"/"+ txtFechaCalculo.Text.Substring(6, 4);
            //DiasLaborales DiasLaborales = new DiasLaborales();
            //int NumeroDiasLaborables = DiasLaborales.DiasDisfrute(Convert.ToDateTime(FechaInicial), Convert.ToDateTime(txtFechaCalculo.Text));

            hfPeriodoEvaluarDesde.Value = "";
            hfPeriodoEvaluarHasta.Value = "";
            int Mes = Convert.ToDateTime(txtFechaCalculo.Text).Date.Month;

            switch (Mes)
            {
                case 1:
                    hfPeriodoEvaluarDesde.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year - 1) + "10";
                    hfPeriodoEvaluarHasta.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year - 1) + "11";
                    break;
                case 2:
                    hfPeriodoEvaluarDesde.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year - 1) + "11";
                    hfPeriodoEvaluarHasta.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year - 1) + "12";
                    break;
                case 3:
                    hfPeriodoEvaluarDesde.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year - 1) + "12";
                    hfPeriodoEvaluarHasta.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "01";
                    break;
                case 4:
                    hfPeriodoEvaluarDesde.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "01";
                    hfPeriodoEvaluarHasta.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "02";
                    break;
                case 5:
                    hfPeriodoEvaluarDesde.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "02";
                    hfPeriodoEvaluarHasta.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "03";
                    break;
                case 6:
                    hfPeriodoEvaluarDesde.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "03";
                    hfPeriodoEvaluarHasta.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "04";
                    break;
                case 7:
                    hfPeriodoEvaluarDesde.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "04";
                    hfPeriodoEvaluarHasta.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "05";
                    break;
                case 8:
                    hfPeriodoEvaluarDesde.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "05";
                    hfPeriodoEvaluarHasta.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "06";
                    break;
                case 9:
                    hfPeriodoEvaluarDesde.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "06";
                    hfPeriodoEvaluarHasta.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "07";
                    break;
                case 10:
                    hfPeriodoEvaluarDesde.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "07";
                    hfPeriodoEvaluarHasta.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "08";
                    break;
                case 11:
                    hfPeriodoEvaluarDesde.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "08";
                    hfPeriodoEvaluarHasta.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "09";
                    break;
                case 12:
                    hfPeriodoEvaluarDesde.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "09";
                    hfPeriodoEvaluarHasta.Value = Convert.ToString(Convert.ToDateTime(txtFechaCalculo.Text).Date.Year) + "10";
                    break;
                default:
                    Alerta("Error en el Mes");
                    return;
            }
            btnCalcular.Enabled = false;
            txtFechaCalculo.Enabled = false;
            txtVigencia.Enabled = false;
            ddlGenerarAportantes.Enabled = false;
            btnDesagregadoDiario.Enabled = false;

            if (ddlGenerarAportantes.Text == "Si")
            {
                hfGenerarAportantes.Value = "1";
            }
            else
            {
                hfGenerarAportantes.Value = "0";
            }
            ControlUgppUpdate();
            IniciarEjecutarMorososUgpp();
        }

        private void ControlUgppUpdate()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[dbo].[Usp_ControlUgppUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add(new SqlParameter("@GenerarAportantes", Convert.ToInt32(hfGenerarAportantes.Value)));
                    cmd.Parameters.Add(new SqlParameter("@FechaCalculo", Convert.ToDateTime(txtFechaCalculo.Text.ToString())));
                    cmd.Parameters.Add(new SqlParameter("@PeriodoEvaluarDesde", hfPeriodoEvaluarDesde.Value));
                    cmd.Parameters.Add(new SqlParameter("@PeriodoEvaluarHasta", hfPeriodoEvaluarHasta.Value));
                    cmd.Parameters.Add(new SqlParameter("@Vigencia", txtVigencia.Text));

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

        private void IniciarEjecutarMorososUgpp()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var FechaInicio = System.DateTime.Now;
                    FechaInicio = FechaInicio.AddMinutes(2);
                    var HoraInicio = FechaInicio.ToString("HHmmss");

                    int vResultado;
                    var Textocmd = "[dbo].[Usp_IniciarEjecutarMorososUgpp]";
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

        protected void btnRefrescar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/Ugpp/AvisoIncumplimiento.aspx", false);
        }

        protected void btnDesagregadoDiario_Click(object sender, EventArgs e)
        {
            try
            {
                string PathArchivo = "PASENA_" + txtFechaCalculo.Text.Replace("/", "_") + "_Desagregado.txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[dbo].[Usp_LeerDesagregadoUgpp]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    con.Close();

                    if (dt.Rows.Count > 0)
                    {
                        using (SqlConnection con1 = new SqlConnection(CadenaConexion))
                        {
                            Textocmd = "[dbo].[Usp_DesagregadoACumuladoUgpp]";
                            SqlCommand cmd1 = new SqlCommand(Textocmd, con1);
                            cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                            con1.Open();
                            cmd1.ExecuteNonQuery();
                            con1.Close();
                        }
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
                    }
                    else
                    {
                        Alerta("Atención No Hay Morosos para la Fecha: "+ txtFechaCalculo.Text);
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