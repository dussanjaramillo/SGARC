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

namespace WebLiquidador.Paginas.ProduccionCentros.Seguimiento
{
    public partial class GeneraSeguimiento : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if ((new List<string> { "1", "2", "3", "4", "6", "7", "8", "9" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }
        }

        protected void btnGenerar_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_BuscarCumplimientoMetaSeguimiento]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@AñoMes", SqlDbType.Text).Value = ddlAñoMes.Text;
                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();

                    ddlAñoMes.Enabled = false;
                    btnGenerar.Enabled = false;

                    Alerta("Listo: Se Generó Archivo de Seguimiento Cumplimiento Meta");
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                    return;
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
            Response.Redirect("~/Paginas/ProduccionCentros/Seguimiento/GeneraSeguimiento.aspx", false);
        }

        protected void ddlAñoMesCuponPago_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnGenerar.Enabled = true;
            BuscarAñoMesSeguimiento(ddlAñoMes.Text);
            if (hfExiste.Value == "1")
            {
                btnGenerar.Enabled = false;
                Alerta("Atención el Año y Mes Ya Existe " + ddlAñoMes.Text);
            }
        }


        private void BuscarAñoMesSeguimiento(string ddlAñoMes)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarAñoMesCumplimientoMetaSeguimiento]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@AñoMes", SqlDbType.Text).Value = ddlAñoMes;
                try
                {
                    con.Open();
                    hfExiste.Value = "";
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfExiste.Value = reader[0].ToString();
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



        protected void ddlAñoMesCuponPago_DataBound(object sender, EventArgs e)
        {
            ddlAñoMes.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }
    }
}