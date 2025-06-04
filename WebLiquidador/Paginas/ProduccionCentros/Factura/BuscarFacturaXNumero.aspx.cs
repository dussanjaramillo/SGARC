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
    public partial class BuscarFacturaXNumero : System.Web.UI.Page
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
                if (Request.QueryString.Get("id") != null)
                {
                    txtNumeroFactura.Text = Request.QueryString.Get("id");
                }
                hfExiste.Value = "0";
                txtNumeroFactura.Focus();
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
            }
        }

        protected void BuscarDocumentoXCentro()
        {
            hfExiste0.Value = "0";
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarDocumentoXCentro]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                cmd.Parameters.Add("@NumeroFactura", SqlDbType.Int).Value = Convert.ToInt32(txtNumeroFactura.Text);
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfExiste0.Value = reader[0].ToString().Trim();
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
            Response.Redirect("~/Paginas/ProduccionCentros/Factura/BuscarFacturaXNumero.aspx", false);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            if (grvFacturaXCentro.Rows.Count == 0 && hfExiste.Value == "1")
            {
                Alerta("Atención!!!! la Prefactura: " + txtNumeroFactura.Text.Trim() + " No Existe en La Base de Datos");
            }
            txtNumeroFactura.Enabled = false;
            btnBuscar.Enabled = false;
        }

        protected void grvFacturaXCentro_DataBound(object sender, EventArgs e)
        {
            if (grvFacturaXCentro.Rows.Count == 0  && IsPostBack)
            {
                Alerta("El Número de la Prefactura No Existe");
            }
        }
    }
}