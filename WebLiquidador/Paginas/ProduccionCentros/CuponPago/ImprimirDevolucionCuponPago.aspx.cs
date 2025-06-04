using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebLiquidador.App_Code;
using System.Configuration;
using System.IO;
using System.Text;
using System.Data.SqlClient;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.CuponPago
{
    public partial class ImprimirDevolucionCuponPago : System.Web.UI.Page
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

            if (!IsPostBack)
            {
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();

                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                var Textocmd = "[dbo].[Usp_BuscarCoordinador]";
                SqlConnection con = new SqlConnection(CadenaConexion);
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
                            Session["_Coordinador"] = reader[0].ToString();
                            Session["_Cargo"] = reader[1].ToString();
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
        protected void grvDevolucionCuponPago_SelectedIndexChanged(object sender, EventArgs e)
        {
            Conversion EnLetras = new Conversion();
            var ValorMonto = grvDevolucionCuponPago.SelectedRow.Cells[9].Text;
            ValorMonto = ValorMonto.Replace("$", "");
            ValorMonto = ValorMonto.Replace(",", "");
            ValorMonto = ValorMonto.Replace(".", "");
            string Monto = EnLetras.enletras(Convert.ToString(ValorMonto));
            Session["_ValorTotalLetras"] = Monto + " Pesos M/Cte";
            
            if (grvDevolucionCuponPago.SelectedRow.Cells[10].Text=="Si")
            {
                Session["_Pagado"] = "La Devolución del Cupón de Pago fue Efectuada el: "; 
            }
            else
            {
                Session["_Pagado"] = "La Devolución del Cupón de Pago No se ha Efectuado"; 
            }
            Session["_IdDevolucionCuponPago"] = grvDevolucionCuponPago.SelectedRow.Cells[1].Text;
            Session["_Opcion"] = "1";
            string _open = "window.open('Reportes/VisorDevolucionCuponPago.aspx', '_blank');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), _open, true);

            //Response.Redirect("~/Paginas/ProduccionCentros/CuponPago/Reportes/VisorDevolucionCuponPago.aspx", false);
        }
    }
}