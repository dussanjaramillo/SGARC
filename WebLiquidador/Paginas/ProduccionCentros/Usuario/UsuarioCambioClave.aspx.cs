using System;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using WebLiquidador.App_Code;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Usuario
{
    public partial class UsuarioCambioClave : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if (!this.IsPostBack)
            {
                HfTransaccion.Value = "0";
                LblNombreUsuario.Text = Session["_NombreUsuario"].ToString();
                LblNombreEntidad.Text = Session["_NombreRegionalUsuario"].ToString();
                txtCodigoUsuario.Text = Session["_CodigoUsuario"].ToString();
                txtClaveAnterior.Focus();
            }
        }

        protected void btnCambiarClave_Click(object sender, EventArgs e)
        {
            Hash_Csharp Encriptador = new Hash_Csharp();

            if (Encriptador.EncodePasswordToBase64(txtClaveAnterior.Text.Trim()) != Session["_ClaveUsuario"].ToString())
            {
                Alerta("Clave Anterior Incorrecta");
                txtClaveAnterior.Focus();
                return;
            }

            if (txtNuevaClave.Text.Length < 7 )
            {
                Alerta("La Clave Nueva debe tener cómo Mínimo 7 caracteres");
                txtNuevaClave.Focus();
                return;
            }

            if (txtNuevaClave.Text.Length > 20)
            {
                Alerta("La Clave Nueva debe tener cómo Máximo 20 caracteres");
                txtNuevaClave.Focus();
                return;
            }


            if (txtNuevaClave.Text != txtConfirmaClave.Text)
            {
                Alerta("La Clave Nueva y La Clave de Confirmación no Coinciden");
                txtNuevaClave.Focus();
                return;
            }
            if (txtNuevaClave.Text == txtClaveAnterior.Text)
            {
                Alerta("Las Claves Anterior y la Nueva son Iguales");
                return;
            }

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection Con = new SqlConnection(CadenaConexion))
            {
                var TextoCmd = "[dbo].[Usp_UsuarioUpdateClave]";
                SqlCommand cmd = new SqlCommand(TextoCmd, Con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = Session["_IdUsuario"];
                cmd.Parameters.Add("@Clave", SqlDbType.Text).Value = Encriptador.EncodePasswordToBase64(txtNuevaClave.Text.Trim());

                try
                {
                    int vResultado = 0;
                    Con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    Con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }

            Session["_NombreUsuario"] = null;
            btnCambiarClave.Visible = false;
            btnReiniciar.Visible = true;
            Alerta("Clave Actualizada, Por favor Inicie Sesión");
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

        protected void btnReiniciar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Inicio.aspx", false);
        }
    }
}