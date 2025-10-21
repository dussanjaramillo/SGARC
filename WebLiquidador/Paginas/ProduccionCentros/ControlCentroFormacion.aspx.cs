using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros
{
    public partial class ControlCentroFormacion : System.Web.UI.Page
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
                BuscarControlCentroFormacion();
                txtPrecioMinimo.Focus();
            }
            lblEstado.Text = "Modificando";
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Convert.ToInt32(txtPrecioMinimo.Text) <= 0)
            {
                Alerta("Atención: El Precio Mínimo debe ser Mayor que Cero");
                txtPrecioMinimo.Focus(); 
                return; 
            }
            
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_ControlCentroFormacionUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@PrecioMinimo", SqlDbType.Int).Value = Convert.ToInt32(txtPrecioMinimo.Text);
                    cmd.Parameters.Add("@PrecioMaximo", SqlDbType.Int).Value = Convert.ToInt32(txtPrecioMaximo.Text);
                    cmd.Parameters.Add("@PlazoMaximo", SqlDbType.Int).Value = Convert.ToInt32(txtPlazoMaximo.Text);
                    cmd.Parameters.Add("@CantidadMaxima", SqlDbType.Int).Value = Convert.ToInt32(txtCantidadMaxima.Text);
                    cmd.Parameters.Add("@CantidadInventario", SqlDbType.Int).Value = Convert.ToInt32(txtCantidadInventario.Text);
                    cmd.Parameters.Add("@NombreCoordinadorRecaudoCartera", SqlDbType.Text).Value = txtNombreCoordinadorRecaudoCartera.Text.Trim();
                    cmd.Parameters.Add("@AñoVigencia", SqlDbType.Int).Value = Convert.ToInt32(txtAñoVigencia.Text); 
                    cmd.Parameters.Add("@AñoVigenciaSirec", SqlDbType.Int).Value = Convert.ToInt32(txtAñoVigenciaSirec.Text); 
                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();

                    Alerta("Valores Actualizados");
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/ControlCentroFormacion.aspx", false);
        }

        protected void BuscarControlCentroFormacion()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarControlCentroFormacion]";
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
                            txtPrecioMinimo.Text = reader[0].ToString();
                            txtPrecioMaximo.Text = reader[1].ToString();
                            txtPlazoMaximo.Text = reader[2].ToString();
                            txtCantidadMaxima.Text = reader[3].ToString();
                            txtCantidadInventario.Text = reader[4].ToString();
                            txtNombreCoordinadorRecaudoCartera.Text = reader[5].ToString();
                            txtAñoVigencia.Text = reader[6].ToString();
                            txtAñoVigenciaSirec.Text = reader[7].ToString();
                        }
                        btnGuardar.Enabled = true;
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
    }
}