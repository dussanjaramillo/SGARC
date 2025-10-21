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
using WebLiquidador.App_Code;
using System.Globalization;
using System.Threading;

namespace WebLiquidador.Paginas.CostasProcesales.Usuario
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
                LblNombreUsuario.Text = Session["_NombreRol"].ToString() + ": " + Session["_NombreUsuario"].ToString();
                LblNombreEntidad.Text = "Regional: " + Session["_NombreRegionalUsuario"].ToString();
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
            if (txtNuevaClave.Text != txtConfirmaClave.Text)
            {
                Alerta("La Clave Nueva y La Clave de Confirmación no Coinciden");
                txtNuevaClave.Focus();
                return;
            }
            if (txtNuevaClave.Text == Session["_ClaveUsuario"].ToString())
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

            //Response.Redirect("~/Inicio.aspx", false);

            Alerta("Clave Actualizada, Por favor Inicie Sesión");
            Session["_NombreUsuario"] = null;
            btnCambiarClave.Visible = false;
            btnReiniciar.Visible = true; 
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