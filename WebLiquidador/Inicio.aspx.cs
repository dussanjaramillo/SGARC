using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using WebLiquidador.App_Code;
using System.Text;
using System.DirectoryServices;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Text;
using System.Drawing.Imaging;
using System.IO;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador
{
    public partial class Inicio : System.Web.UI.Page
    {
        string codeCaptcha;
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("_IdUsuario");
            Session.Remove("_CodigoUsuario");
            Session.Remove("_NombreUsuario");
            Session.Remove("_NombreRegionalUsuario");
            Session.Remove("_NombreRol");
            Session.Remove("_IdRol");
            Session.Remove("_CodigoRegionalUsuario");
            Session.Remove("_ClaveUsuario");
            Session.Remove("_IdRegional");
            Session.Remove("_CambioClave");
            Session.Remove("_IdCentroFormacion");
            Session.Remove("_NombreCentroFormacion");
            Session.Remove("_CodigoCentroFormacion");
            Session.Remove("_Pensamiento");
            Session.Remove("_DireccionCentroFormacion");
            Session.Remove("_TelefonoCentroFormacion");
            Session.Remove("_IdMunicipioCentroFormacion");
            Session.Remove("_IdDepartamentoCentroFormacion");
            Session.Remove("_Seguimiento");
            Session.Remove("_AñoMesSeguimiento");
            Session.Remove("_IpTelefono");

            Response.AppendHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("es-CO");

            if (!IsPostBack)
            {
                txtCaptcha.Attributes.Add("autocomplete", "off");
                GetRandomText();
                txtCaptcha.Focus();
                ViewState["_Contador"] = 0;
            }
        }

        private void BuscarMantenimiento()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_BuscarMantenimientoApp]";
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
                            hfSgarc.Value = reader[0].ToString().Trim();
                            hfSgPc.Value = reader[1].ToString().Trim();
                            hfSgIn.Value = reader[2].ToString().Trim();
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

        private void BuscarUsuarioCentroFormacionSinIpTelefono()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarUsuarioCentroFormacionSinIpTelefono]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfIpTelefono.Value = reader[0].ToString().Trim();
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

        protected void BtnIniciar_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtCaptcha.Text == "")
                {
                    Alerta("Atención, escribir e Código Captcha");
                    txtCaptcha.Focus();
                    return;
                }

                hfErrorValidacion.Value = "0";
                ValidarIniciar();
                if (hfErrorValidacion.Value == "1")
                { return; }

                if (ConectarBasedatos())
                {
                    if (hdEsActivo.Value == "False") 
                    {
                        Alerta("Alerta, Usuario está Inactivo, Contáctese con el Administrador");
                        txtUsuario.Focus();
                        return;
                    }

                    BuscarMantenimiento();

                    /// ROL
                    //1	01	Administrador
                    //2	02	Costas Procesales
                    //3	03	Producción de Centros
                    //4	04	Atención al Ciudadano
                    //5	05	Dirección General
                    //6	06	Doble Mesada Pensional

                    //Costas Procesales
                    if (Session["_IdRol"].ToString() == "2") 
                    {
                        if (hfSgIn.Value == "True" && Session["_IdCargo"].ToString() != "5")
                        {
                            Alerta("Alerta, Costas Procesales Se Encuenta en Mantenimiento, por favor Inténtelo Más Tarde");
                            return;
                        }

                        if (txtClave.Text.Substring(0, 5) == "LSeNa")
                        {
                            Session["_CambioClave"] = "1";
                            Response.Redirect("~/Paginas/CostasProcesales/Usuario/UsuarioCambioClave.aspx", false);
                            return;
                        }
                        else
                        {
                            Response.Redirect("~/DefaultCp.aspx", false);
                            return;
                        }
                    }
                    
                    //Producción de Centros
                    if (Session["_IdRol"].ToString() == "3") 
                    {
                        if (hfSgPc.Value == "True" && Session["_IdCargo"].ToString() != "5")
                        {
                            Alerta("Alerta, Producción de Centros Se Encuenta en Mantenimiento, por favor Inténtelo Más Tarde");
                            return;
                        }

                        if (txtClave.Text.Substring(0, 5) == "LSeNa")
                        {
                            Session["_CambioClave"] = "1";
                            Response.Redirect("~/Paginas/ProduccionCentros/Usuario/UsuarioCambioClave.aspx", false);
                            return;
                        }
                        else
                        {
                            BuscarSeguimientoCf();
                            if (hfNoRespuesta.Value == "1")
                            {
                                Session["_Seguimiento"] = "1";
                                Response.Redirect("~/Paginas/ProduccionCentros/Seguimiento/ResponderSeguimiento.aspx", false);
                                return;
                            }

                            BuscarUsuarioCentroFormacionSinIpTelefono();
                            if (hfIpTelefono.Value == "No")
                            {
                                Session["_IpTelefono"] = "1";
                                Response.Redirect("~/Paginas/ProduccionCentros/Usuario/UsuarioUpdate.aspx", false);
                                return;
                            }

                            Response.Redirect("~/DefaultCf.aspx", false);
                            return;
                        }
                    }

                    //Atención al Ciudadano
                    if (Session["_IdRol"].ToString() == "4")
                    {
                        if (hfSgarc.Value == "True" && Session["_IdCargo"].ToString() != "5")
                        {
                            Alerta("Alerta, Atención al Ciudadano Se Encuenta en Mantenimiento, por favor Inténtelo Más Tarde");
                            return;
                        }

                        if (txtClave.Text.Substring(0, 5) == "LSeNa")
                        {
                            Session["_CambioClave"] = "1";
                            Response.Redirect("~/Paginas/AtencionCiudadano/Usuario/UsuarioCambioClave.aspx", false);
                            return;
                        }
                        else
                        {
                            Response.Redirect("~/Default.aspx", false);
                            return;
                        }
                    }
                }
                else
                {
                    ViewState["_Contador"] = (int)ViewState["_Contador"] + 1;
                    Alerta("Alerta, Usuario o Clave Incorrecta: Intento Número: " + ViewState["_Contador"] + " de 3");
                    txtUsuario.Focus();

                    if ((int)ViewState["_Contador"] == 3)
                    {
                        txtUsuario.Enabled = false;
                        txtClave.Enabled = false;
                        BtnIniciar.Visible = false;
                    }
                    return;
                }
            }
            catch (Exception ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }

        private void BuscarSeguimientoCf()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarCentroFormacionCumplimientoMetaSeguimiento]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                try
                {
                    hfNoRespuesta.Value = "";
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfNoRespuesta.Value = reader[0].ToString();
                            Session["_AñoMesSeguimiento"] = reader[1].ToString().Trim();
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

        private void BuscarPensamiento()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_BuscarPensamiento]";
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
                            Session["_Pensamiento"] = reader[1].ToString().Trim() + " - " + reader[2].ToString().Trim();
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

        private void BuscarCentroFormacion()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarDatosBasicosCentroFormacion]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Session["_DireccionCentroFormacion"] = reader[0].ToString().Trim();
                            Session["_TelefonoCentroFormacion"] = reader[1].ToString().Trim();
                            Session["_IdMunicipioCentroFormacion"] = reader[2].ToString().Trim();
                            Session["_IdDepartamentoCentroFormacion"] = reader[3].ToString().Trim();
                            Session["_CodigoCentroFormacion"] = reader[4].ToString().Trim();
                            //Session["_ApoyoEE"] = "0";
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

        private bool ConectarBasedatos()
        {
            var tieneDatos = false;
            //string IpUsuario = Request.UserHostAddress;
            //string UsuarioRed = System.Net.Dns.GetHostEntry(IpUsuario).HostName;
            //var UsuarioRed = Dns.GetHostName();
            //string UsuarioRed = Request.ServerVariables["LOGON_USER"].ToString();
            var UsuarioRed = Request.UserHostName;
            //var UsuarioRed = Environment.UserName; 
            //UsuarioRed = User.Identity.Name;

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            Hash_Csharp Encriptador = new Hash_Csharp();
            var Textocmd = "[dbo].[Usp_BuscarUsuario]";
            SqlConnection con = new SqlConnection(CadenaConexion);
            SqlCommand cmd = new SqlCommand(Textocmd, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("@Codigo", SqlDbType.Text).Value = txtUsuario.Text.Trim();
            cmd.Parameters.Add("@Clave", SqlDbType.Text).Value = Encriptador.EncodePasswordToBase64(txtClave.Text.Trim());
            cmd.Parameters.Add("@UsuarioRed", SqlDbType.Text).Value = UsuarioRed;
            try
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        Session["_IdUsuario"] = reader[0].ToString();
                        Session["_CodigoUsuario"] = reader[1].ToString();
                        Session["_NombreUsuario"] = reader[2].ToString();
                        Session["_IdRegional"] = reader[3].ToString();
                        hdEsActivo.Value = reader[4].ToString();
                        Session["_NombreRegionalUsuario"] = reader[9].ToString();
                        Session["_NombreRol"] = reader[8].ToString();
                        Session["_IdRol"] = reader[7].ToString();
                        Session["_CodigoRegionalUsuario"] = reader[10].ToString();
                        Session["_ClaveUsuario"] = reader[11].ToString();
                        Session["_IdCargo"] = reader[12].ToString();
                        Session["_IdCentroFormacion"] = reader[13].ToString();
                        Session["_NombreCentroFormacion"] = reader[14].ToString();
                        Session["_NombreCargo"] = reader[15].ToString();
                        tieneDatos = true;
                        Session["_Liquidacion"] = "0";
                    }
                    if (Session["_IdCentroFormacion"].ToString() != "")
                    {
                        BuscarCentroFormacion();
                    }
                    BuscarPensamiento();
                }
                con.Close();
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
            }
            return tieneDatos;
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

        protected void ValidarIniciar()
        {
            if (txtUsuario.Text.ToString().Trim() == String.Empty)
            {
                Alerta("Error, debe Escribir el Codigo del Usuario");
                txtUsuario.Focus();
                txtUsuario.Text = String.Empty;
                hfErrorValidacion.Value = "1";
                return;
            }

            if ((txtUsuario.Text.ToString().Trim().Length < 4))
            {
                Alerta("Error, el Codigo del Usuario debe tener Mínimo 4 caracteres");
                txtUsuario.Focus();
                txtUsuario.Text = String.Empty;
                hfErrorValidacion.Value = "1";
                return;
            }

            if (txtClave.Text.ToString().Trim() == String.Empty)
            {
                Alerta("Error, debe Escribir la Clave del Usuario");
                txtClave.Focus();
                txtClave.Text = String.Empty;
                hfErrorValidacion.Value = "1";
                return;
            }
        }

        private void BuscarActivo()
        {
            //cmd echo %logonserver%  VSDADC06 
            //Un servidor se mostrará, que será el nombre del controlador de dominio que la máquina utiliza para autenticar.

            string path = @"LDAP://172.16.2.61";      //VSDADC06 CAMBIAR POR VUESTRO PATH (URL DEL SERVICIO DE DIRECTORIO LDAP)
                                                      //Por ejemplo: 'LDAP://ejemplo.lan.es'
            string dominio = @"sena.edu.co";          //CAMBIAR POR VUESTRO DOMINIO
            string usu = txtUsuario.Text.Trim();      //USUARIO DEL DOMINIO
            //string pass = "Sena6127*";              //txtClave.Text.Trim();//PASSWORD DEL USUARIO

            string pass = txtClave.Text.Trim();

            string domUsu = dominio + @"\" + usu;           //CADENA DE DOMINIO + USUARIO A COMPROBAR

            bool permiso = AutenticaUsuario(path, domUsu, pass);
            if (permiso)
            {
                //permitido.BackColor = Color.Green;
                //permitido.ForeColor = Color.White;
                LblError.Text = "Acceso permitido";
            }
            else
            {
                //permitido.BackColor = Color.Red;
                //permitido.ForeColor = Color.Black;
                LblError.Text = "Acceso denegado";
            }
        }

        private bool AutenticaUsuario(String path, String user, String pass)
        {
            //Los datos que hemos pasado los 'convertimos' en una entrada de Active Directory para hacer la consulta
            DirectoryEntry de = new DirectoryEntry(path, user, pass, AuthenticationTypes.Secure);
            try
            {
                //Inicia el chequeo con las credenciales que le hemos pasado
                //Si devuelve algo significa que ha autenticado las credenciales
                DirectorySearcher ds = new DirectorySearcher(de);
                ds.FindOne();
                return true;
            }
            catch
            {
                //Si no devuelve nada es que no ha podido autenticar las credenciales
                //ya sea porque no existe el usuario o por que no son correctas
                return false;
            }
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            if (txtCaptcha.Text != hfCaptcha.Value)
            {
                Alerta("Alerta, el Captcha No es Igual, Intente de Nuevo");
                txtCaptcha.Focus();
                txtCaptcha.Text = "";
                GetRandomText();
                return;
            }
            txtUsuario.Text = "";
            txtClave.Text = "";
            txtCaptcha.Enabled = false;
            btnAceptar.Enabled = false;
            txtUsuario.Visible = true;
            txtClave.Visible = true;
            BtnIniciar.Visible = true;
            txtUsuario.Enabled = true;
            txtClave.Enabled = true;
            BtnIniciar.Enabled = true;
            txtUsuario.Focus();
        }

        protected void Convertir_Grafico(string codeCaptcha)
        {
            BorrarImagenes();

            hfCaptcha.Value = codeCaptcha;
            string text = codeCaptcha.ToString();
            Bitmap bitmap = new Bitmap(1, 1);
            Font font = new Font("Arial", 25, FontStyle.Bold, GraphicsUnit.Pixel);
            Graphics graphics = Graphics.FromImage(bitmap);
            int width = (int)graphics.MeasureString(text, font).Width;
            int height = (int)graphics.MeasureString(text, font).Height;
            bitmap = new Bitmap(bitmap, new Size(width, height));
            graphics = Graphics.FromImage(bitmap);
            graphics.Clear(Color.DarkGray);
            graphics.SmoothingMode = SmoothingMode.AntiAlias;
            graphics.TextRenderingHint = TextRenderingHint.AntiAlias;
            graphics.DrawString(text, font, new SolidBrush(Color.Red), 0, 0);
            graphics.Flush();
            graphics.Dispose();
            string fileName = Path.GetFileNameWithoutExtension(Path.GetRandomFileName()) + ".jpg";
            bitmap.Save(Server.MapPath("~/Captcha/") + fileName, ImageFormat.Jpeg);
            Image5.ImageUrl = "~/Captcha/" + fileName;
            Image5.Visible = true;
        }

        private void BorrarImagenes()
        {
            foreach (var item in Directory.GetFiles("C:/inetpub/wwwroot/WebLiquidador/Captcha", "*.*"))
            {
                File.SetAttributes(item, FileAttributes.Normal);
                File.Delete(item);
            }
        }

        private string GetRandomText()
        {
            StringBuilder randomText = new StringBuilder();
            if (String.IsNullOrEmpty(codeCaptcha))
            {
                string alfabeto = "abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                Random r = new Random();
                for (int j = 0; j <= 4; j++)
                {
                    randomText.Append(alfabeto[r.Next(alfabeto.Length)]);
                }
                codeCaptcha = randomText.ToString();
            }
            Convertir_Grafico(codeCaptcha);
            return codeCaptcha;
        }
    }
}