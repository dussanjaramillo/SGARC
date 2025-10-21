using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;


//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Siif
{
    public partial class CorregirNumeroFactura : System.Web.UI.Page
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

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            hfFacturaExiste.Value = "0";
            BuscarNumeroFacturaXIdCentroFormacion();
            if (hfFacturaExiste.Value == "0")
            {
                txtNumeroFacturaNew.Enabled = true;
                txtNumeroFacturaNew.Focus();
                Alerta("Alerta!!! El Número de la Prefactura Suministrado No Está Asignado a su Centro");
                grvValorFactura.SelectedIndex = -1;
                btnGuardar.Enabled = false;
                btnBuscar.Enabled = true;
                return;
            }

            if (Convert.ToInt64(hfValorDocumento.Value.Replace(".", "")) != Convert.ToInt64(hfValorCupon.Value.Replace(".","")))
            {
                txtNumeroFacturaNew.Enabled = true;
                txtNumeroFacturaNew.Focus();
                Alerta("Alerta!!! El Valor de la Prefactura es Diferente al del Cupón de Pago");
                grvValorFactura.SelectedIndex = -1;
                btnGuardar.Enabled = false;
                btnBuscar.Enabled = true;
                return;
            }

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_NumeroFacturaCuponPagoUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@NumeroFactura", SqlDbType.BigInt).Value = Convert.ToInt64(txtNumeroFacturaNew.Text);
                    cmd.Parameters.Add("@IdCuponPago", SqlDbType.Int).Value = Convert.ToInt64(hfIdCuponPago.Value);
                    cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();

                    Alerta("Listo!!! se Actualizó el Número de la Prefactura");
                    grvCupoPago.SelectedIndex = -1;

                    btnGuardar.Enabled = false;
                    txtNumeroFacturaNew.Enabled = false;
                    grvCupoPago.DataSource = null;
                    
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                    return;
                }
            }
        }

        private void BuscarNumeroFacturaXIdCentroFormacion()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[Aportes].[Usp_BuscarNumeroFacturaXIdCentroFormacion]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                cmd.Parameters.Add("@NumeroFactura", SqlDbType.BigInt).Value = Convert.ToInt64(txtNumeroFacturaNew.Text);
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfFacturaExiste.Value = reader[0].ToString();
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

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Siif/CorregirNumeroFactura.aspx", false);
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

        protected void grvCupoPago_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfIdCuponPago.Value = grvCupoPago.SelectedRow.Cells[1].Text;
            txtNumeroCupon.Text = grvCupoPago.SelectedRow.Cells[6].Text;
            hfValorCupon.Value = grvCupoPago.SelectedRow.Cells[5].Text;
            btnBuscar.Enabled = true;
            txtNumeroFacturaNew.Enabled = true; 
            txtNumeroFacturaNew.Focus();
        }

        private void BuscarValorDocumentoEquivalente()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarValorFactura_]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                cmd.Parameters.Add("@NumeroFactura", SqlDbType.BigInt).Value = Convert.ToInt64(txtNumeroFacturaNew.Text);
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfFacturaExiste.Value = reader[0].ToString();
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

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            
        }

        protected void grvValorFactura_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfValorDocumento.Value = grvValorFactura.SelectedRow.Cells[5].Text;
            txtNumeroFacturaNew.Enabled = false;
            btnBuscar.Enabled = false;
            btnGuardar.Enabled = true;
        }

        protected void grvValorFactura_DataBound(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (grvValorFactura.Rows.Count == 0)
                {
                    Alerta("Atención!!! El Número de la Prefactura No Existe");
                    txtNumeroFacturaNew.Focus();
                    return;
                }
            }
        }

        protected void grvCupoPago_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (grvValorFactura.Rows.Count == 0)
                {
                    Alerta("Atención!!! No Hay Error en el Número de la Prefactura en el Cupón de Pago");
                    return;
                }
            }
        }
    }
}