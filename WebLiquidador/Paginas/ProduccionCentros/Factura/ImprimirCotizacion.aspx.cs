using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using WebLiquidador.App_Code;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Factura
{
    public partial class ImprimirCotizacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if ((new List<string> { "1", "2", "3", "4", "6", "7", "8" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }

            if (!IsPostBack)
            {
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString(); 
            }
        }

        protected void grvCotizacionXCentro_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["_NumeroCotizacion"] = grvCotizacionXCentro.SelectedRow.Cells[1].Text;
            Session["_IdCentroFormacion1"] = grvCotizacionXCentro.SelectedRow.Cells[2].Text;
            Session["_Opcion"] = "1";
            BuscarValorCotizacion(Convert.ToInt64(Session["_NumeroCotizacion"].ToString()));
            grvCotizacionXCentro.SelectedIndex = -1;
            Response.Redirect("~/Paginas/ProduccionCentros/Factura/Reportes/VisorCotizacion.aspx", false);
        }

        protected void BuscarValorCotizacion(decimal NumeroCotizacion)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarValorCotizacion]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@NumeroCotizacion", SqlDbType.Int).Value = NumeroCotizacion;
                cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32((Session["_IdCentroFormacion1"].ToString()));
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfValorTotalCotizacion.Value = reader[0].ToString();
                        }
                        con.Close();
                        Conversion EnLetras = new Conversion();
                        string Monto = EnLetras.enletras(Convert.ToString(hfValorTotalCotizacion.Value));
                        Session["_ValorTotalLetras"] = Monto + " Pesos M/Cte";
                    }
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

        protected void grvCotizacionXCentro_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (grvCotizacionXCentro.Rows.Count == 0)
                {
                    Panel1.Visible = false;
                    Alerta("No Hay Cotizaciones para su Centro");
                    return;
                }
            }
        }

    }
}