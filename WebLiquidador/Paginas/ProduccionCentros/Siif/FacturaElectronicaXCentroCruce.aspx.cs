using System;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Text;
using System.Collections.Generic;

namespace WebLiquidador.Paginas.ProduccionCentros.Siif
{
    public partial class FacturaElectronicaXCentroCruce : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }
            //Cargo
            //1 Coordinador
            //2 Abogado
            //3 Fiscalizador
            //4 Técnico
            //5 Administrador
            //6 Profesional
            //7 Siif - Nación
            //8 Subdirector
            //9 Producción

            if ((new List<string> { "1", "2", "3", "4", "6", "7", "8" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
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

        protected void grvFacturaElectronica_SelectedIndexChanged(object sender, EventArgs e)
        {
            grvFacturaElectronica.Enabled = false;
            txtNumeroCupon.Enabled = true;
            btnBuscar.Enabled = true;
            hfIdPagosFacturaSiif.Value = grvFacturaElectronica.SelectedRow.Cells[1].Text;
            hfValorPagoSiif.Value = grvFacturaElectronica.SelectedRow.Cells[6].Text;
        }

        protected void BuscarCuponPago_Siif()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarCuponPago_Siif]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@NroInternodeTransaccion", SqlDbType.Text).Value = txtNumeroCupon.Text;
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            //hfValorTotalFactura.Value = reader[0].ToString();
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
            Response.Redirect("~/Paginas/ProduccionCentros/Siif/FacturaElectronicaXCentroCruce.aspx", false);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            if (txtNumeroCupon.Text.Length != 8)
            {
                Alerta("Atención!!!!, El Número de Cupón de Pago Debe ser de 8 Caracteres");
                txtNumeroCupon.Focus(); 
                return;
            }
        }

        protected void grvCuponPago_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfValorPagoSnpc.Value = "";
            hfCentroCuponPago.Value = "";

            if (grvCuponPago.SelectedRow.Cells[10].Text == "Si")
            {
                btnGuardar.Enabled = true;
                hfCentroCuponPago.Value = grvCuponPago.SelectedRow.Cells[4].Text;
                hfValorPagoSnpc.Value = grvCuponPago.SelectedRow.Cells[6].Text;
                hfIdCuponPago.Value = grvCuponPago.SelectedRow.Cells[1].Text;
                txtNumeroCupon.Enabled = false;
                btnBuscar.Enabled = false;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Session["_CodigoCentroFormacion"].ToString() != hfCentroCuponPago.Value.ToString())
            {
                Alerta("!!!Atención!!! El Cupón de Pago no es del Centro: " + Session["_NombreCentroFormacion"].ToString());
                return;
            }

            if (Convert.ToInt64(hfValorPagoSiif.Value.Replace(".","")) != Convert.ToInt64(hfValorPagoSnpc.Value))
            {
                Alerta("!!!Atención!!! El Valor de la Factura Electrónica es Diferente del Cupón de Pago, No se Puede Cambiar");
                return;
            }

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_FacturaElectronicaCuponPagoSiifUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@IdPagosFacturaSiif", SqlDbType.Int).Value = Convert.ToInt64(hfIdPagosFacturaSiif.Value);
                    cmd.Parameters.Add("@NumeroCuponPago", SqlDbType.Int).Value = txtNumeroCupon.Text;
                    cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();

                    Alerta("Listo!!! se Actualizó el Número del Cupón de Pago en la Factura Electrónica en Siif Nación");
                    btnGuardar.Enabled = false;
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                    return;
                }
            }
        }

        protected void grvFacturaElectronica_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (grvFacturaElectronica.Rows.Count == 0)
                {
                    Alerta("Atención!!! No Hay Error en la Factura Electrónica Por Centro Siif - Nación");
                    return;
                }
            }
        }
    }
}