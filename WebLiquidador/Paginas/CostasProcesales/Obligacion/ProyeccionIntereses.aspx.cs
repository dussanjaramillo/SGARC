using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace WebLiquidador.Paginas.CostasProcesales.Obligacion
{
    public partial class ProyeccionIntereses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            //if ((new List<string> { "1", "2", "3", "4", "6", "7", "8", "9" }).Contains(Session["_IdCargo"].ToString()))
            //{
            //    Response.Redirect("~/DefaultCf.aspx");
            //}

            if (!IsPostBack)
            {
                txtIdentificacion.Focus();
                BuscarTasaInteresMax();
            }
            lblEstado.Text = Session["_NombreRegionalUsuario"].ToString();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscarDeudor(txtIdentificacion.Text, 0);
        }

        protected void BuscarDeudor(string Identificacion, Int32 IdDeudor)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CostasProcesales].[Usp_BuscarDeudor]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdDeudor", SqlDbType.Int).Value = IdDeudor;
                cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Identificacion.ToString();
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfIdDeudor.Value = reader[0].ToString();
                            txtNombre.Text = reader[2].ToString();
                        }
                        btnBuscar.Enabled = false;
                        txtIdentificacion.Enabled = false;
                        con.Close();
                    }
                    else
                    {
                        Alerta("La Identificacion del Deudor No Existe");
                        txtIdentificacion.Focus();
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

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/CostasProcesales/Obligacion/ProyeccionIntereses.aspx", false);
        }

        protected void btnCalcular_Click(object sender, EventArgs e)
        {
            DateTime FechaUno = DateTime.Parse(txtFechaInicial.Text);
            DateTime FechaDos = DateTime.Parse(txtFechaFinal.Text);

            txtFechaInicial.Text = FechaUno.ToString("dd/MM/yyyy");
            txtFechaFinal.Text = FechaDos.ToString("dd/MM/yyyy");
            BuscarTasaInteres(txtFechaFinal.Text);

            DateTime oldDate = FechaUno;
            DateTime newDate = FechaDos;

            // Diferencia en dias, horas y minutos.
            TimeSpan ts = newDate - oldDate;
            int differenceInDays = ts.Days + 1;
            txtNumeroDias.Text = differenceInDays.ToString();
            
            Decimal TasaDiaria = Convert.ToDecimal(txtTasa.Text) / 365;
            Int64 Intereses = (long)(Convert.ToInt64(txtSaldoCapital.Text) * Convert.ToInt16(txtNumeroDias.Text) * TasaDiaria) / 100;
            txtIntereses.Text = Convert.ToString(Intereses);
            txtTotalCancelacion.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(Convert.ToString(Convert.ToDecimal(txtSaldoCapital.Text) + Intereses)));
            btnImprimir.Enabled = true;
        }

        protected void btnImprimir_Click(object sender, EventArgs e)
        {
            Session["_IdObligacion"] = hfIdObligacion.Value;
            Session["_FechaFinal"] = txtFechaFinal.Text;
            Session["_Identificacion"] = txtIdentificacion.Text;
            string _open = "window.open('VisorProyeccionIntereses.aspx', '_blank');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), _open, true);
            grvObligaciones.SelectedIndex = -1;
            btnImprimir.Enabled = false;
        }

        protected void grvObligaciones_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfIdObligacion.Value = grvObligaciones.SelectedRow.Cells[1].Text;
            txtSaldoCapital.Text = grvObligaciones.SelectedRow.Cells[9].Text.Replace(".","");
            txtFechaInicial.Text = grvObligaciones.SelectedRow.Cells[10].Text;

            DateTime nuevaFecha = Convert.ToDateTime(txtFechaInicial.Text);
            nuevaFecha = nuevaFecha.AddDays(1);
            txtFechaInicial.Text = Convert.ToString(nuevaFecha);    
            grvObligaciones.Enabled = false;
            
            txtFechaFinal.Text = DateTime.Now.ToString("dd/MM/yyyy");
            BuscarTasaInteres(txtFechaFinal.Text);
            if (hfTasaInteres.Value == "")
            {
                Alerta("La Tasa de Interes no Existe, Consulte al Administrador del Sistema");
                return;
            }
            txtTasa.Text = hfTasaInteres.Value;
            btnCalcular_Click(sender, e);
        }

        protected void BuscarTasaInteres(string Fecha)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CostasProcesales].[Usp_TasaInteresBancarioBuscar]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@Fecha", SqlDbType.Date).Value = Fecha.ToString();
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfTasaInteres.Value = reader[0].ToString();
                        }
                        con.Close();
                    }
                    else
                    {
                        btnImprimir.Enabled = false;
                        Alerta("La Tasa de Interes no Existe, Consulte al Administrador del Sistema");
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void BuscarTasaInteresMax()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CostasProcesales].[Usp_BuscarTasaInt​eresBancarioMaxima]";
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
                            hfVigenciaMaxima.Value = reader[0].ToString();
                            txtFechaFinal_CalendarExtender.EndDate = Convert.ToDateTime(hfVigenciaMaxima.Value);
                        }
                        con.Close();
                    }
                    else
                    {
                        btnImprimir.Enabled = false;
                        Alerta("La Tasa de Interes no Existe, Consulte al Administrador del Sistema");
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void grvObligaciones_DataBound(object sender, EventArgs e)
        {
            if (grvObligaciones.Rows.Count == 0)
            {
                btnImprimir.Enabled = false;
            }
        }

        protected void txtFechaFinal_TextChanged(object sender, EventArgs e)
        {
            btnCalcular_Click(sender, e);
        }
    
    }
}