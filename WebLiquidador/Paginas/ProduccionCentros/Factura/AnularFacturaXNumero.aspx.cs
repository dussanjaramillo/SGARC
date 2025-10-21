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

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Factura
{
    public partial class AnularFacturaXNumero : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if (!(new List<string> { "5" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }

            if (!IsPostBack)
            {
                txtNumeroFactura.Focus();
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
            }
        }

        protected void Alerta(string Mensaje)
        {
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
            Response.Redirect("~/Paginas/ProduccionCentros/Factura/AnularFacturaXNumero.aspx", false);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            txtNumeroFactura.Enabled = false;
            btnBuscar.Enabled = false;
        }

        protected void grvFacturaXCentro_DataBound(object sender, EventArgs e)
        {
            if (grvFacturaXCentro.Rows.Count == 0  && IsPostBack)
            {
                Alerta("El Número de la Prefactura No Existe");
                btnEjecutar.Enabled = false;
            }
        }

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {
            if (grvFacturaXCentro.SelectedRow.Cells[9].Text == "No")
            {
                Alerta("Atención!!!! La Prefactura aún no se ha Pagado");
                return;
            }
            hfNumeroCuponPago.Value = grvFacturaXCentro.SelectedRow.Cells[10].Text;
            Ejecutar();
        }

        protected void Ejecutar()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_LiberarCuponAnularFactura]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    ///cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                    cmd.Parameters.Add("@NumeroFactura", SqlDbType.Int).Value = Convert.ToInt64(txtNumeroFactura.Text.Trim());
                    cmd.Parameters.Add("@NumeroCuponPago", SqlDbType.Text).Value = hfNumeroCuponPago.Value.Trim();
                    cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }



        protected void grvFacturaXCentro_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (grvFacturaXCentro.SelectedRow.Cells[9].Text == "No")
            {
                Alerta("Atención!!!! La Prefactura aún no se ha Pagado");
                return;
            }
            btnEjecutar.Enabled = true;
        }
    }
}