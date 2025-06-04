using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using System.Text;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Siif
{
    public partial class ConsultaFacturaPdf : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            BuscarFacturaPdf(Convert.ToInt32(GridView1.SelectedRow.Cells[1].Text));
        }

        protected void BuscarFacturaPdf(int @IdFacturaElectronicaSiif)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarFacturaElectronicaSiifXId]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdFacturaElectronicaSiif", SqlDbType.Int).Value = IdFacturaElectronicaSiif;
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            txtNombreArchivo.Text = reader[3].ToString();
                        }
                        con.Close();

                        HyperLink1.Visible = true;
                        HyperLink1.Target = "_blank";
                        HyperLink1.Text = "Abrir Factura Electrónica: "+ txtNombreArchivo.Text;
                        HyperLink1.NavigateUrl = "~/Paginas/ProduccionCentros/Siif/FacturaPdf/" + txtNombreArchivo.Text;
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

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Siif/ConsultaFacturaPdf.aspx", false);
        }
    }
}