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

namespace WebLiquidador.Paginas.AtencionCiudadano
{
    public partial class DatosBasicosAportante : System.Web.UI.Page
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
             
                txtIdentificacion.Focus();
            }
            lblEstado.Text = "Agregando";
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            hfErrorValidacion.Value = "0";
            Validar_Datos();
            if (hfErrorValidacion.Value == "1")
            { return; }

            //Existe Registro se hace un Update
            if (hfTransaccion.Value == "1")
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        int vResultado;
                        var Textocmd = "[dbo].[Usp_DatosBasicosAportantesUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdDatosBasicosAportante", SqlDbType.Int).Value = Convert.ToInt32(hfDatosBasicosAportante.Value);
                        cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Convert.ToString(Convert.ToInt64(txtIdentificacion.Text.ToString().Trim()));
                        cmd.Parameters.Add("@Nombre", SqlDbType.Text).Value = txtNombre.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();
                        btnGuardar.Enabled = false;

                        Alerta("El Aportante Guardado");
                    }
                    catch (SqlException ex)
                    {
                        Alerta("Error: " + ex.Message);
                    }
                }
            }
            else
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        var Textocmd = "[dbo].[Usp_DatosBasicosAportantesInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdDatosBasicosAportante", SqlDbType.Int).Value = DbType.Int32;

                        cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Convert.ToString(Convert.ToInt64(txtIdentificacion.Text.ToString().Trim()));
                        cmd.Parameters.Add("@Nombre", SqlDbType.Text).Value = txtNombre.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        int vResultado = 0;
                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();
                        btnGuardar.Enabled = false;

                        Alerta("El Aportante Guardado");
                    }
                    catch (SqlException ex)
                    {
                        if (ex.Number == 2627)
                        {
                            //Alerta("Error: la Clave ya Existe");
                            Alerta("Error: " + ex.Message.ToString());
                            return;
                        }
                        Alerta("Error: " + ex.Message.ToString());
                    }
                }
            }
        }

        private void Validar_Datos()
        {
            if (txtIdentificacion.Text == String.Empty)
            {
                Alerta("Error, debe Escribir el numero de Identificacion");
                txtIdentificacion.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }

            if (txtNombre.Text == String.Empty)
            {
                Alerta("Error, debe Escribir el Numero Licencia o Contrato");
                txtNombre.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }

        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            if (txtIdentificacion.Text == String.Empty)
            {
                Alerta("Error, debe Escribir el numero de Identificacion");
                txtIdentificacion.Focus();
                return;
            }
            
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_BuscarDatosBasicosAportante]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Convert.ToString(Convert.ToInt64(txtIdentificacion.Text.ToString().Trim()));

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfDatosBasicosAportante.Value = reader[0].ToString();
                            txtNombre.Text = reader[1].ToString();
                            txtIdentificacion.Text = reader[2].ToString();
                            hfTransaccion.Value = "1";
                        }
                        txtIdentificacion.Enabled = false;
                        btnBuscar.Enabled = false;
                        con.Close();
                    }
                    else
                    {
                        Alerta("La Identificacion del Aportante No Existe");
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

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/AtencionCiudadano/DatosBasicosAportante.aspx", false);
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/AtencionCiudadano/Fic/RegistroAtencionFic.aspx", false);
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
    }
}