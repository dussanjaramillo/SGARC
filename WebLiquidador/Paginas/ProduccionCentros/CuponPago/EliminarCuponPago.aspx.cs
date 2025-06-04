using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.CuponPago
{
    public partial class EliminarCuponPago : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if ((new List<string> { "1", "2", "3", "4", "6", "7", "8", "9" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }

            if (!IsPostBack)
            {
                txtCuponPago.Focus();
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

        protected void BuscarCuponPagoCentroFormacion()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarCuponPagoActivoXNroInternodeTransaccion]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@NroInternodeTransaccion", SqlDbType.Text).Value = txtCuponPago.Text.ToString();
                
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfIdCuponPago.Value = reader[0].ToString();
                            txtRegional.Text = reader[1].ToString();
                            txtCodigoCentroFormacion.Text = reader[2].ToString();
                            txtNombreCentroFormacion.Text = reader[3].ToString();
                            txtNroInternodeTransaccion.Text = reader[4].ToString();
                            txtValorPago.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(reader[5].ToString()));
                            txtFechaPago.Text = Convert.ToDateTime(reader[6]).ToShortDateString(); 
                            
                            if (Convert.ToInt64(reader[5].ToString()) == 0)
                            {
                                btnEliminarCuponPago.Enabled = false; 
                            }
                        }
                        txtCuponPago.Enabled = false;
                        btnBuscar.Enabled = false;
                        btnEliminarCuponPago.Visible = true; 
                        con.Close();
                    }
                    else
                    {
                        Alerta("El Cupón de Pago No Existe");
                        txtCuponPago.Focus(); 
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/CuponPago/EliminarCuponPago.aspx", false);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscarCuponPagoCentroFormacion();
        }

        protected void btnEliminarCuponPago_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_EliminarCuponPagoDelete]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdCuponPago", SqlDbType.Int).Value = Convert.ToInt32(hfIdCuponPago.Value);
                    cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                    btnEliminarCuponPago.Visible = false;

                    Alerta("Cupón de Pago Eliminado");
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }

        }
    }
}