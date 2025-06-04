using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using WebLiquidador.App_Code;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Usuario
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

            if (!(new List<string> { "5" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }

            if (!IsPostBack)
            {
                if (Request.QueryString.Get("id") != null)
                {
                    txtCodigoUsuario.Text = Request.QueryString.Get("id");
                }

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
                            if (reader[9].ToString() == "")
                            {
                                ddlCentroFormacion.SelectedIndex = -1;
                                btnGuardar.Enabled = false;
                                Alerta("Este Usuario es de Atención Al Ciudadano");
                                return;
                            }
                            else
                            {
                                ddlCentroFormacion.SelectedValue = reader[9].ToString();
                            }
                            txtCodigoUsuario.Focus();
                            HfTransaccion.Value = "1";
                        }
                        txtCodigoUsuario.Enabled = false;
                        btnBuscar.Enabled = false;
                        btnGuardar.Enabled = true;
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
                    var mensaje = "Sr(a) " + txtNombreUsuario.Text.ToString().Trim() + "; Bienvenido(a) nuevamente al Sistema Nacional de Producción de Centros de Formación, su clave del sistema es: "
                                           + hfClaveUSR.Value.ToString() + ". Para tal efecto usted debe ingresar a la página https://sgarc.sena.edu.co/Inicio.aspx, para continuar con el proceso de cambio de clave del usuario. Recuerde que el Usuario y la Clave son intransferibles. Después de 31 días de inactividad en el Sistema Nacional de Producción de Centros, su Usuario será Inactivado. <br /> <br /> Se Recomienda consultar los siguientes link http://compromiso.sena.edu.co/mapa/descarga.php?id=1510 (Sena Proveedor Sena), http://compromiso.sena.edu.co/documentos/doc_referencia/Manual_de_Usuario_Sistema_Nacional_de_Produccion_de_Centros.pdf (Manual de Usuario), http://compromiso.sena.edu.co/mapa/descarga.php?id=1603, (Recaudo Producción)<br /> " +
                                           "<br /> Cordial Saludo, <br /> <br /> <b>Sistema Nacional de Producción de Centros de Formación</b>";

                    var asunto = "Reactivación de Usuario y/o Reenvío Clave Acceso - Sistema Nacional de Producción de Centros de Formación";
                    bool importante = true;

                    var archivo = Server.MapPath(@"\Imagenes\ComiteDePrecios.pdf");

                    oCorreo.oEnviarCorreo(enviadoA, conCopiaA, mensaje, asunto, importante, archivo);

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
            Response.Redirect("~/Paginas/ProduccionCentros/Usuario/UsuariosReeviarClave.aspx", false);
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
            //txtCodigoUsuario.Text = grvUsuarios.SelectedRow.Cells[1].Text;

            txtCodigoUsuario.Enabled = false;

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[UsuarioBuscarXIdUsuario]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = Convert.ToInt32(grvUsuarios.SelectedRow.Cells[1].Text);

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
                            ddlCentroFormacion.SelectedValue = reader[9].ToString();
                            txtCodigoUsuario.Focus();
                            HfTransaccion.Value = "1";
                        }
                        con.Close();
                    }
                    btnBuscar.Enabled = false;
                    txtCodigoUsuario.Enabled = false;
                    btnGuardar.Enabled = true;
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

        protected void ddlCentroFormacion_DataBound(object sender, EventArgs e)
        {
            ddlCentroFormacion.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }
    }
}