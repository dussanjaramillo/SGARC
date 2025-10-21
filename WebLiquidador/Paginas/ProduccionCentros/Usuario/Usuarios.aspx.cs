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
    public partial class Usuarios : System.Web.UI.Page
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
                ddlCentroFormacion.Items.Insert(0, new ListItem("Seleccione...", "-1"));
                txtCodigoUsuario.Focus();
                HfTransaccion.Value = "0";

                //var NombrePrograma = Request.Url.Segments[Request.Url.Segments.Length - 1];
                //BuscarPermiso oLeerPermisos = new BuscarPermiso();
                //Permisos oPermiso = oLeerPermisos.BuscarPermisoUsuario(Session["_CodigoUsuario"].ToString(), NombrePrograma); 
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscarUsuario();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (ddlRolUsuario.SelectedValue == "3" && ddlCentroFormacion.SelectedValue == "-1")
            {
                Alerta("Atención: debe Seleccionar el Centro de Formación");
                Label1.Visible = true;
                ddlCentroFormacion.Focus();
                return;
            }

            if (ddlCentroFormacion.SelectedValue != "-1" && ddlRolUsuario.SelectedValue != "3")
            {
                Alerta("Atención: debe Seleccionar el Rol de Producción de Centros");
                Label1.Visible = true;
                ddlCentroFormacion.Focus();
                return;
            }

            //Usuario Existe se hace un Update
            if (HfTransaccion.Value == "1")
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        int vResultado;
                        var Textocmd = "[dbo].[Usp_UsuarioUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = Convert.ToInt32(HfIdUsuario.Value);
                        cmd.Parameters.Add("@Codigo", SqlDbType.Text).Value = txtCodigoUsuario.Text.ToString().Trim();
                        cmd.Parameters.Add("@Nombre", SqlDbType.Text).Value = txtNombreUsuario.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdRegional", SqlDbType.Int).Value = Convert.ToInt32(ddlRegional.SelectedValue.ToString());
                        cmd.Parameters.Add("@IdRol", SqlDbType.Int).Value = Convert.ToInt32(ddlRolUsuario.SelectedValue.ToString());
                        cmd.Parameters.Add("@IdCargo", SqlDbType.Int).Value = Convert.ToInt32(ddlCargo.SelectedValue.ToString());

                        if (ddlCentroFormacion.SelectedValue == "-1")
                        { cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = System.DBNull.Value; }
                        else
                        { cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(ddlCentroFormacion.SelectedValue.ToString()); }

                        if (chbEsActivo.Checked)
                        { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true; }
                        else
                        { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false; }

                        if (txtIpTelefono.Text == "")
                        { cmd.Parameters.Add("@IpTelefono", SqlDbType.Int).Value = System.DBNull.Value; }
                        else
                        { cmd.Parameters.Add("@IpTelefono", SqlDbType.Int).Value = Convert.ToInt32(txtIpTelefono.Text); }

                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();
                        Alerta("Usuario Actualizado");
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
                EnviarCorreo oCorreo = new EnviarCorreo();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        var Textocmd = "[dbo].[Usp_UsuarioInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        String Clave = "LSeNa" + DateTime.Now.Date.ToString("yyyyMMdd");
                        hfClaveUSR.Value = Clave.ToString();
                        Hash_Csharp Encriptador = new Hash_Csharp();
                        Clave = Encriptador.EncodePasswordToBase64(Clave);

                        cmd.Parameters.Add("@Codigo", SqlDbType.Text).Value = txtCodigoUsuario.Text.ToString().Trim();
                        cmd.Parameters.Add("@Clave", SqlDbType.Text).Value = Clave;
                        cmd.Parameters.Add("@Nombre", SqlDbType.Text).Value = txtNombreUsuario.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdRegional", SqlDbType.Int).Value = ddlRegional.SelectedValue.ToString();
                        if (chbEsActivo.Checked)
                        { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true; }
                        else
                        { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false; }

                        cmd.Parameters.Add("@IdRol", SqlDbType.Int).Value = Convert.ToInt32(ddlRolUsuario.SelectedValue.ToString());
                        cmd.Parameters.Add("@IdCargo", SqlDbType.Int).Value = Convert.ToInt32(ddlCargo.SelectedValue.ToString());

                        if (ddlCentroFormacion.SelectedValue == "-1")
                        { cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = System.DBNull.Value; }
                        else
                        { cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(ddlCentroFormacion.SelectedValue.ToString()); }

                        if (txtIpTelefono.Text == "")
                        {
                            cmd.Parameters.Add("@IpTelefono", SqlDbType.Int).Value = System.DBNull.Value;
                        }
                        else
                        {
                            cmd.Parameters.Add("@IpTelefono", SqlDbType.Int).Value = Convert.ToInt32(txtIpTelefono.Text);
                        }

                        SqlParameter outputIdParam = new SqlParameter("@IdUsuario", SqlDbType.Int) { Direction = ParameterDirection.Output };
                        cmd.Parameters.Add(outputIdParam);
                        int vResultado;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        vResultado = Convert.ToInt32(cmd.Parameters["@IdUsuario"].Value);
                        con.Close();

                        var enviadoA = txtCodigoUsuario.Text.ToString().Trim() + "@sena.edu.co";
                        var conCopiaA = Session["_CodigoUsuario"].ToString() + "@sena.edu.co";

                        var mensaje = "";
                        var asunto = "";
                        var archivo = "";

                        mensaje = "Sr(a) " + txtNombreUsuario.Text.ToString().Trim() + "; Bienvenido(a) al Sistema Nacional de Producción de Centros de Formación, su usuario es: "
                                            + txtCodigoUsuario.Text.ToString().Trim() + " y su clave del sistema es: " + hfClaveUSR.Value.ToString()
                                            + ". Para tal efecto usted debe ingresar a la página https://sgarc.sena.edu.co/Inicio.aspx, para continuar con el proceso de cambio de clave del usuario. Recuerde que el Usuario y la Clave son intransferibles. Después de 31 días de inactividad en el Sistema Nacional de Producción de Centros, su Usuario será Inactivado. <br /> <br /> Se Recomienda consultar los siguientes link http://compromiso.sena.edu.co/mapa/descarga.php?id=1510 (Sena Proveedor Sena), http://compromiso.sena.edu.co/documentos/doc_referencia/Manual_de_Usuario_Sistema_Nacional_de_Produccion_de_Centros.pdf (Manual de Usuario), http://compromiso.sena.edu.co/mapa/descarga.php?id=1603, (Recaudo Producción), <br />  <br /> Cordial Saludo, <br /> <br /> <b>Sistema Nacional de Producción de Centros de Formación </b>";
                        asunto = "Nuevo Usuario y clave acceso - Sistema Nacional de Producción de Centros de Formación";
                        archivo = Server.MapPath(@"\Imagenes\CapacitacionProduccionCentros.pdf");

                        bool importante = true;
                        oCorreo.oEnviarCorreo(enviadoA, conCopiaA, mensaje, asunto, importante, archivo);

                        Alerta("Usuario Agregado, se Envio Correo");
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
            Response.Redirect("~/Paginas/ProduccionCentros/Usuario/Usuarios.aspx", false);
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

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                HfTransaccion.Value = "0";
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
                            ddlCargo.SelectedValue = reader[8].ToString();

                            BuscarCentroFormacion();
                            if (reader[9].ToString() == "")
                            {
                                ddlCentroFormacion.SelectedValue = "-1";
                            }
                            else
                            {
                                ddlCentroFormacion.SelectedValue = reader[9].ToString();
                            }

                            txtIpTelefono.Text = reader[10].ToString();
                        }
                        con.Close();
                        txtCodigoUsuario.Focus();
                        HfTransaccion.Value = "1";
                        btnBuscar.Enabled = false;
                        btnGuardar.Enabled = true;
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
                            ddlCargo.SelectedValue = reader[8].ToString();

                            if (reader[9].ToString() == "")
                            {
                                ddlCentroFormacion.SelectedValue = "-1";
                            }
                            else
                            {
                                BuscarCentroFormacion();
                                ddlCentroFormacion.SelectedValue = reader[9].ToString();
                            }

                            txtIpTelefono.Text = reader[10].ToString();

                            txtCodigoUsuario.Focus();
                            HfTransaccion.Value = "1";
                        }
                        con.Close();
                        txtCodigoUsuario.Enabled = false;
                        btnBuscar.Enabled = false;
                    }
                    else
                    {
                        Alerta("Codigo del Usuario No Existe");
                        txtCodigoUsuario.Focus();
                        con.Close();
                    }
                    btnGuardar.Enabled = true;
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void BuscarCentroFormacion()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            var Textocmd = "[dbo].[Usp_BuscarCentroFormacionXRegional]";
            SqlConnection con = new SqlConnection(CadenaConexion);
            SqlCommand cmd = new SqlCommand(Textocmd, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IdRegional", Convert.ToInt16(ddlRegional.SelectedValue.ToString()));

            SqlDataAdapter CentroFormacion = new SqlDataAdapter(cmd);
            DataSet dsCentroFormacion = new DataSet();
            CentroFormacion.Fill(dsCentroFormacion, "CentroFormacion");

            ddlCentroFormacion.DataSource = dsCentroFormacion.Tables["CentroFormacion"].DefaultView;
            ddlCentroFormacion.DataTextField = "NombreCentroFormacion";
            ddlCentroFormacion.DataValueField = "IdCentroFormacion";
            ddlCentroFormacion.DataBind();
            ddlCentroFormacion.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlCargo_DataBound(object sender, EventArgs e)
        {
            ddlCargo.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlRegional_SelectedIndexChanged(object sender, EventArgs e)
        {
            BuscarCentroFormacion();
        }

        protected void grvUsuarios_PageIndexChanged(object sender, EventArgs e)
        {
            grvUsuarios.SelectedIndex = -1;
            HfIdUsuario.Value = "";
            txtCodigoUsuario.Text = "";
            txtNombreUsuario.Text = "";
            txtIpTelefono.Text = "";
            ddlRegional.SelectedIndex = -1;
            ddlRolUsuario.SelectedIndex = -1;
            ddlCargo.SelectedIndex = -1;
        }

    }
}