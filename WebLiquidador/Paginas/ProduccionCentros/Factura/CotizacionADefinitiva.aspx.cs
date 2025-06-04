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
    public partial class CotizacionADefinitiva : System.Web.UI.Page
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
           if (grvCotizacionXCentro.SelectedRow.Cells[10].Text == "Si")
            {
                grvCotizacionXCentro.SelectedIndex = -1;
                Alerta("La Cotización Seleccionada ya está como Prefactura Definitiva");
                return;
            }
            hfIdc.Value = grvCotizacionXCentro.SelectedRow.Cells[1].Text;
            btnEjecutar.Enabled = true;
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

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {
            btnEjecutar.Enabled = false;
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_CotizacionAFacturaDefinitivaInsert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdCotizacion", SqlDbType.BigInt).Value = Convert.ToInt64(hfIdc.Value);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Alerta("Listo!!!!! la Cotización se Pasó a Prefactura Definitiva");
                    grvCotizacionXCentro.DataSource = null;
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Factura/CotizacionADefinitiva.aspx", false);
        }
    }
}