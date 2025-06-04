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

namespace WebLiquidador.Paginas.ProduccionCentros.Seguimiento
{
    public partial class ResponderSeguimiento : System.Web.UI.Page
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
                txtRespuesta1.Focus();
                BuscarPreguntaSeguimientoCf();
                BuscarCentroFormacionCumplimientoMetaSeguimiento();
                lblAñoMes.Text = Session["_AñoMesSeguimiento"].ToString();
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
            }
        }

        private void BuscarPreguntaSeguimientoCf()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarPresuntaSeguimientoInCumplimientoMeta]";
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
                            lblPregunta1.Text = reader[0].ToString();
                            lblPregunta2.Text = reader[1].ToString();
                            lblPregunta3.Text = reader[2].ToString();
                            lblPregunta4.Text = reader[3].ToString();
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


        private void BuscarCentroFormacionCumplimientoMetaSeguimiento()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarCentroFormacionCumplimientoMetaSeguimiento_]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                cmd.Parameters.Add("@AñoMes", SqlDbType.Text).Value = Session["_AñoMesSeguimiento"].ToString();
                //[Meta],[Ingresos],[CumplimientoMeta],[ProyeccionMes],[PorcentajeCumplimientoMes]
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfIdCumplimientoMetaSeguimiento.Value = reader[0].ToString();
                            lblMeta.Text = string.Format("{0:###,###,###,###,##0.00}", Convert.ToDouble(reader[1].ToString()));
                            hfMeta.Value = reader[1].ToString();
                            lblIngresos.Text = string.Format("{0:###,###,###,###,##0.00}", Convert.ToDouble(reader[2].ToString()));
                            hfIngresos.Value = reader[2].ToString();
                            lblCumplimientoMeta.Text = string.Format("{0:##0.00}", Convert.ToDouble(reader[3].ToString()));
                            lblProyeccionMes.Text = string.Format("{0:###,###,###,###,##0.00}", Convert.ToDouble(reader[4].ToString()));
                            lblPorcentajeCumplimientoMes.Text = string.Format("{0:##0.00}", Convert.ToDouble(reader[5].ToString()));
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

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Convert.ToInt64(txtRespuesta4.Text) < Convert.ToDecimal(hfIngresos.Value))
            {
                Alerta("Lo Siento, el Valor Estimado de los Ingresos de la Vigencia: " + txtRespuesta4.Text + " deben ser Mayor a los Ingresos: "+ lblIngresos.Text);
                return; 
            }
            //if (Convert.ToInt64(txtRespuesta4.Text) > Convert.ToDecimal(hfMeta.Value)*2)
            //{
            //    Alerta("Lo Siento, el Valor Estimado de los Ingresos de la Vigencia " + txtRespuesta4.Text + " no pueden ser Mayor al Doble de la Meta: " + lblMeta.Text);
            //    return;
            //}
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_CumplimientoMetaSeguimientoUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdCumplimientoMetaSeguimiento", SqlDbType.Int).Value = Convert.ToInt32(hfIdCumplimientoMetaSeguimiento.Value);
                    cmd.Parameters.Add("@Respuesta1", SqlDbType.Text).Value = txtRespuesta1.Text.Trim();   
                    cmd.Parameters.Add("@Respuesta2", SqlDbType.Text).Value = txtRespuesta2.Text.Trim();
                    cmd.Parameters.Add("@Respuesta3", SqlDbType.Text).Value = txtRespuesta3.Text.Trim();
                    cmd.Parameters.Add("@Respuesta4", SqlDbType.Decimal).Value = Convert.ToDecimal(txtRespuesta4.Text.Trim());
                    cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    int vResultado;
                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                    btnGuardar.Enabled = false;
                    btnContinuar.Enabled = true;
                    Alerta("Listo. Gracias Por Sus Respuestas, Haga Clic En Continuar Por Favor....");
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                }
            }
        }

        protected void btnContinuar_Click1(object sender, EventArgs e)
        {
            Session["_Seguimiento"] = "0";
            Response.Redirect("~/DefaultCf.aspx", false);
        }
    }
}