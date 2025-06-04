using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.Ugpp
{
    public partial class CarteraRealCalcularMorosos : System.Web.UI.Page
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
        }

        protected void ddlFechaCalculo_DataBound(object sender, EventArgs e)
        {
            ddlPeriodo_CarteraRealUgpp.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnCalcular_Click(object sender, EventArgs e)
        {
            hfValidacionFecha.Value = "0";
            BuscarMorososUgppReal();
            if (hfValidacionFecha.Value == "1")
            {
                Alerta("Atención, el Periodo " + ddlPeriodo_CarteraRealUgpp.SelectedValue + " Ya fue Procesado");
                ddlPeriodo_CarteraRealUgpp.Focus(); 
                return; 
            }

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[Ugpp].[Usp_EjecutarMorososUgppReal_New]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@Periodo", ddlPeriodo_CarteraRealUgpp.SelectedValue));
                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                    Alerta("Archivo Procesado para el Periodo "+ ddlPeriodo_CarteraRealUgpp.SelectedValue);
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                    return;
                }
            }
        }

        protected void BuscarMorososUgppReal()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            var Textocmd = "[Ugpp].[Usp_BuscarMorososUgppReal]";
            SqlConnection con = new SqlConnection(CadenaConexion);
            SqlCommand cmd = new SqlCommand(Textocmd, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@Periodo", ddlPeriodo_CarteraRealUgpp.SelectedValue));
            try
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        hfValidacionFecha.Value = "1";
                    }
                    con.Close();
                }
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
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

        protected void ddlFechaCalculo_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnCalcular.Enabled = true; 
        }
    }
}