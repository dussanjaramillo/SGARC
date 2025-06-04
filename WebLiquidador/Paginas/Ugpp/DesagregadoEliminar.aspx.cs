using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebLiquidador.App_Code;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Globalization;
using System.Threading;
using System.IO;
using System.Text;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.Ugpp
{
    public partial class DesagregadoEliminar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            //Cargos
            //1   01  Coordinador
            //2   02  Abogado
            //3   03  Fiscalizador
            //4   04  Técnico
            //5   05  Administrador
            //6   06  Profesional
            //7   07  Siif - Nación
            //8   08  Subdirector
            //9   09  Producción
            //10  10  Control Interno
            if (!(new List<string> { "5" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/Default.aspx");
            }

            if (!IsPostBack)
            {
                txtVigenciaMes.Focus();
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
                
       
        protected void btnDesagregadoEliminar_Click(object sender, EventArgs e)
        {
            if (txtVigenciaMes.Text == string.Empty)
            {
                txtVigenciaMes.Focus();
                Alerta("Error: La Vigencia - Mes no puede estar Vacia");
                return;
            }

            try
            {
                //var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
                //using (SqlConnection con = new SqlConnection(CadenaConexion))
                //{
                //    int vResultado;
                //    var Textocmd = "[dbo].[Usp_DesagregadoMensualEliminarUgpp]";
                //    SqlCommand cmd = new SqlCommand(Textocmd, con);
                //    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                //    cmd.Parameters.Add(new SqlParameter("@FechaMes", txtVigenciaMes.Text.Trim()));
                //    con.Open();
                //    vResultado = cmd.ExecuteNonQuery();
                //    con.Close();
                    Alerta("Atención, Desagregado Mensual Eliminado:" + txtVigenciaMes.Text.Trim());
                //}
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }
        }
    }
}