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
using System.ComponentModel;
using WebLiquidador.App_Code;
using System.Globalization;
using System.Threading;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.AtencionCiudadano.Usuario
{
    public partial class UsuariosReeviarClave : System.Web.UI.Page
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
                txtCodigoUsuario.Focus();
                HfTransaccion.Value = "0";

                //var NombrePrograma = Request.Url.Segments[Request.Url.Segments.Length - 1];
                //BuscarPermiso oLeerPermisos = new BuscarPermiso();
                //Permisos oPermiso = oLeerPermisos.BuscarPermisoUsuario(Session["_CodigoUsuario"].ToString(), NombrePrograma); 
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                HfTransaccion.Value = "0";
                var Textocmd = "[dbo].[Usp_UsuarioBuscarXCodigo]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@Codigo", SqlDbType.Text).Value = txtCodigoUsuario.Text.Trim();

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            HfIdUsuario.Value = reader[0].ToString();
                            txtCodigoUsuario.Text = reader[1].ToString();
                            txtNombreUsuario.Text = reader[2].ToString();
                            ddlRegional.SelectedValue = reader[3].ToString();
                            chbEsActivo.Checked = Convert.ToBoolean(reader[4].ToString());
                            ddlRolUsuario.SelectedValue = reader[7].ToString();
                            txtCodigoUsuario.Focus();
                            HfTransaccion.Value = "1";
                        }
                        txtCodigoUsuario.Enabled = false;
                        btnBuscar.Enabled = false;
                        con.Close();
                    }
                    else
                    {
                        Alerta("Codigo del Usuario No Existe");
                        txtCodigoUsuario.Focus();
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
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            EnviarCorreo oCorreo = new EnviarCorreo();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[dbo].[Usp_UsuarioUpdateClave]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    String Clave = "LSeNa" + DateTime.Now.Date.ToString("yyyyMMdd");
                    hfClaveUSR.Value = Clave.ToString();
                    Hash_Csharp Encriptador = new Hash_Csharp();
                    Clave = Encriptador.EncodePasswordToBase64(Clave);

                    cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = Convert.ToInt32(HfIdUsuario.Value);
                    cmd.Parameters.Add("@Clave", SqlDbType.Text).Value = Clave;

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();

                    var enviadoA = txtCodigoUsuario.Text.ToString().Trim() + "@sena.edu.co";
                    var conCopiaA = Session["_CodigoUsuario"].ToString() + "@sena.edu.co";
                    var mensaje = "Sr(a) " + txtNombreUsuario.Text.ToString().Trim() + "; Bienvenido nuevamente al Sistema de Gestión de Atención al Ciudadano - Recaudo y Cartera, su clave del sistema es: " 
                                    + hfClaveUSR.Value.ToString() + ". Para tal efecto usted debe ingresar a la página https://sgarc.sena.edu.co/Inicio.aspx, para continuar con el proceso de cambio de clave del usuario. Recuerde que el Usuario y la Clave son intransferibles. Después de 31 días de inactividad en el Sistema de Gestión de Atención al Ciudadano - Recaudo y Cartera, su Usuario será Inactivado. " +
                                    "<br /> <br /> Cordial Saludo, <br /> <br /> <b>Sistema de Gestión de Atención al Ciudadano - Recaudo y Cartera </b>";
                    var asunto = "Reactivación de Usuario y/o Reenvío Clave Acceso - Sistema de Gestión de Atención al Ciudadano - Recaudo y Cartera";
                    bool importante = true;

                    var archivo = Server.MapPath(@"\Imagenes\Acercade.pdf");

                    oCorreo.oEnviarCorreo(enviadoA, conCopiaA, mensaje, asunto, importante, archivo);

                    //if (oCorreo.oEnviarCorreo(enviadoA, conCopiaA, mensaje, asunto, importante, archivo) == null)
                    //{
                    //    Alerta("Atención!! El servidor de Correo relay.sena.edu.co No Funciona Comuniquese con la Mesa de Servicio");
                    //}
                    //else
                    //{
                    //    Alerta("Usuario Reactivado y la Clave Fue Enviada");
                    //}

                    Alerta("Usuario Reactivado y la Clave Fue Enviada");

                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }

            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/AtencionCiudadano/Usuario/UsuariosReeviarClave.aspx", false);
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

        protected void ddlRegional_DataBound(object sender, EventArgs e)
        {
            ddlRegional.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlRolUsuario_DataBound(object sender, EventArgs e)
        {
            ddlRolUsuario.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void grvUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtCodigoUsuario.Text = grvUsuarios.SelectedRow.Cells[1].Text;
            //txtCodigoUsuario.Enabled = false;

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[UsuarioBuscarXIdUsuario]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = grvUsuarios.SelectedRow.Cells[1].Text;

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            HfIdUsuario.Value = reader[0].ToString();
                            txtCodigoUsuario.Text = reader[1].ToString();
                            txtNombreUsuario.Text = reader[2].ToString();
                            ddlRegional.SelectedValue = reader[3].ToString();
                            chbEsActivo.Checked = Convert.ToBoolean(reader[4].ToString());
                            ddlRolUsuario.SelectedValue = reader[7].ToString();
                            txtCodigoUsuario.Focus();
                            HfTransaccion.Value = "1";
                            btnBuscar.Enabled = false;
                        }
                    }
                    else
                    {
                        Alerta("Usuario o Clave Incorrecta");
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void BuscarUsuario()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_UsuarioBuscarXCodigo]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@Codigo", SqlDbType.Text).Value = txtCodigoUsuario.Text.Trim();

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            HfIdUsuario.Value = reader[0].ToString();
                            txtCodigoUsuario.Text = reader[1].ToString();
                            txtNombreUsuario.Text = reader[2].ToString();
                            ddlRegional.SelectedValue = reader[3].ToString();
                            chbEsActivo.Checked = Convert.ToBoolean(reader[4].ToString());
                            ddlRolUsuario.SelectedValue = reader[7].ToString();
                            txtCodigoUsuario.Focus();
                            HfTransaccion.Value = "1";
                        }
                        txtCodigoUsuario.Enabled = false;
                        btnBuscar.Enabled = false;
                        con.Close();
                        hdfUsuarioEncontrado.Value = "1";
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