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

namespace WebLiquidador.Paginas.AtencionCiudadano.Usuario
{
    public partial class Rol : System.Web.UI.Page
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
                txtCodigoRol.Focus();
                HfTransaccion.Value = "0";
           }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                HfTransaccion.Value = "0";
                var Textocmd = "[dbo].[Usp_RolBuscarXCodigo]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@CodigoRol", SqlDbType.Text).Value = txtCodigoRol.Text.Trim();

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfIdRol.Value = reader[0].ToString();
                            txtCodigoRol.Text = reader[1].ToString();
                            txtNombreRol.Text = reader[2].ToString();
                            chbEsActivo.Checked = Convert.ToBoolean(reader[3].ToString());
                            HfTransaccion.Value = "1";
                        }
                        con.Close();
                        txtCodigoRol.Focus();
                        txtCodigoRol.Enabled = false;
                        btnBuscar.Enabled = false;
                     }
                    else
                    {
                        Alerta("Codigo del Rol No Existe");
                        txtCodigoRol.Focus();
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            //Rol Existe se hace un Update
            if (HfTransaccion.Value == "1")
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        int vResultado;
                        var Textocmd = "[dbo].[Usp_RolUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdRol", SqlDbType.Int).Value = Convert.ToInt32(hfIdRol.Value);
                        cmd.Parameters.Add("@CodigoRol", SqlDbType.Text).Value = txtCodigoRol.Text.ToString().Trim();
                        cmd.Parameters.Add("@NombreRol", SqlDbType.Text).Value = txtNombreRol.Text.ToString().Trim();
                        if (chbEsActivo.Checked)
                        {cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true;}
                        else
                        {cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false;}
                        cmd.Parameters.Add("@UsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"]);

                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();
                        Alerta("Rol Actualizado");
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
                        var Textocmd = "[dbo].[Usp_RolInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdRol", SqlDbType.Int).Value = DbType.Int32;
                        cmd.Parameters.Add("@CodigoRol", SqlDbType.Text).Value = txtCodigoRol.Text.ToString().Trim();
                        cmd.Parameters.Add("@NombreRol", SqlDbType.Text).Value = txtNombreRol.Text.ToString().Trim();
                        if (chbEsActivo.Checked)
                        { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true; }
                        else
                        { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false; }
                        cmd.Parameters.Add("@UsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"]);

                        int vResultado = 0;
                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();

                        Alerta("Rol Agregado");
                    }
                    catch (SqlException ex)
                    {
                        if (ex.Number == 2627)
                        {
                            Alerta("Error: " + ex.Message.ToString());
                            return;
                        }
                        Alerta("Error: " + ex.Message.ToString());
                    }
                }
            }

        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/AtencionCiudadano/Usuario/Rol.aspx", false);
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

        protected void grvRol_SelectedIndexChanged(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_RolBuscarXIdRol]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdRol", SqlDbType.Int).Value = grvRol.SelectedRow.Cells[1].Text;

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfIdRol.Value = reader[0].ToString();
                            txtCodigoRol.Text = reader[1].ToString();
                            txtNombreRol.Text = reader[2].ToString();
                            chbEsActivo.Checked = Convert.ToBoolean(reader[3].ToString());
                            txtCodigoRol.Focus();
                            HfTransaccion.Value = "1";
                            btnBuscar.Enabled = false;
                        }
                    }
                    else
                    {
                        Alerta("Rol Incorrecto");
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }
    }
}