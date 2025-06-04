using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace WebLiquidador.Paginas.ProduccionCentros.Usuario
{
    public partial class UsuarioUpdate : System.Web.UI.Page
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
                lblEstado.Text = Session["_NombreUsuario"].ToString();
                txtIpTelefono.Focus();
            }
        }

        protected void txtIpTelefono_TextChanged(object sender, EventArgs e)
        {
            btnGuardar.Enabled = true;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (txtIpTelefono.Text.Length != 5)
            {
                Alerta("La Ip del Teléfono debe tener 5 dígitos");
                txtIpTelefono.Focus();
                btnGuardar.Enabled = false;
                return;
            }

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection Con = new SqlConnection(CadenaConexion))
            {
                var TextoCmd = "[Seguridad].[Usp_UsuarioXIpTelefonoUpdate]";
                SqlCommand cmd = new SqlCommand(TextoCmd, Con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = Session["_IdUsuario"];
                cmd.Parameters.Add("@IpTelefono", SqlDbType.Int).Value = Convert.ToInt32(txtIpTelefono.Text.Trim());

                try
                {
                    int vResultado = 0;
                    Con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    Con.Close();

                    txtIpTelefono.Enabled = false;
                    btnLimpiar.Enabled = false;
                    btnGuardar.Enabled = false;
                    btnContinuar.Enabled = true;
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
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/UsuarioUpdate.aspx", false);
        }

        protected void btnContinuar_Click1(object sender, EventArgs e)
        {
            Session["_IpTelefono"] = "0";
            Response.Redirect("~/DefaultCf.aspx", false);
        }
    }
}