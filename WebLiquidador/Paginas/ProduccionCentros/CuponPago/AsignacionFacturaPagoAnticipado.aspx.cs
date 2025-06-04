using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.CuponPago
{
    public partial class AsignacionFacturaPagoAnticipado : System.Web.UI.Page
    {
        public static class GlobalData
        {
            public static Int64 TotalFactura;
        }
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
                txtCuponPago.Focus();
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            txtCuponPago.Enabled = false;
            btnBuscar.Enabled = false; 
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

        protected void SumarFacturas()
        {
            GlobalData.TotalFactura = 0;
            int i = 0;
            for (i = 0; i < grvFacturasAsignadas.Rows.Count; i++)
            {
                GlobalData.TotalFactura = GlobalData.TotalFactura + Int64.Parse(grvFacturasAsignadas.Rows[i].Cells[5].Text);
            }
            txtValorFactura.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(GlobalData.TotalFactura.ToString()));
            txtSaldo.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(hfValorCupon.Value) - Convert.ToInt64(GlobalData.TotalFactura.ToString()));
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/CuponPago/AsignacionFacturaPagoAnticipado.aspx", false);
        }

        protected void grvCuponPago_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtCuponPago.Enabled = false;
            hfIdCuponPago.Value = grvCuponPago.SelectedRow.Cells[1].Text;
            hfValorCupon.Value = grvCuponPago.SelectedRow.Cells[3].Text;
            Label1.Visible = true;
            Label2.Visible = true;
            txtValorFactura.Visible = true;
            txtSaldo.Visible = true;
            grvFacturasCentro.Visible = true;
            grvFacturasAsignadas.DataSource = SdsFacturasAsignadas;
            grvFacturasAsignadas.DataBind();

            grvFacturasCentro.DataSource = SdsFacturaNoAsociadaXCentro;
            grvFacturasCentro.DataBind();
        }

        protected void grvCuponPago_DataBound(object sender, EventArgs e)
        {
            if (grvCuponPago.Rows.Count == 0 && IsPostBack)
            {
                Alerta("El Cupón de Pago Anticipado No Existe Para Su Centro");
                return;
            }
        }


        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Int64 SaldoCupon = Convert.ToInt64(hfValorCupon.Value) - Convert.ToInt64(GlobalData.TotalFactura.ToString());

            if (SaldoCupon - Convert.ToInt64(hfValorFactura.Value) < 0 )
           {
               Alerta("El Valor Total Asignado No Puede Ser Mayor al Saldo del Cupón");
               return;
           }

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_PagosAnticipadosInsert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdCuponPago", SqlDbType.Int).Value = Convert.ToInt32(hfIdCuponPago.Value);
                    cmd.Parameters.Add("@IdFactura", SqlDbType.BigInt).Value = Convert.ToInt64(hfIdFactura.Value);
                    int vResultado = 0;
                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                    Alerta("Factura Asociada al Cupón de Pagos Anticipados");
                    grvFacturasAsignadas.DataSource = SdsFacturasAsignadas;
                    grvFacturasAsignadas.DataBind();

                    grvFacturasAsignadas.Enabled = true;
 
                    grvFacturasCentro.SelectedIndex = -1;
                    btnAgregar.Visible = false;
                    btnCancelar0.Visible = false;

                    grvFacturasCentro.DataSource = SdsFacturaNoAsociadaXCentro;
                    grvFacturasCentro.DataBind();

                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                }
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_PagosAnticipadosDelete]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdPagosAnticipados", SqlDbType.Int).Value = Convert.ToInt32(hfIdPagosAnticipados.Value);
                    int vResultado = 0;
                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                    Alerta("Factura Eliminada de Pagos Anticipados");
                    grvFacturasAsignadas.DataSource = SdsFacturasAsignadas;
                    grvFacturasAsignadas.DataBind();
                    btnEliminar.Visible = false;
                    btnCancelar.Visible = false;

                    grvFacturasCentro.DataSource = SdsFacturaNoAsociadaXCentro;
                    grvFacturasCentro.DataBind();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                }
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            btnEliminar.Visible = false;
            btnCancelar.Visible = false;
            grvFacturasAsignadas.SelectedIndex = -1;
            grvFacturasCentro.Enabled = true;
            hfIdPagosAnticipados.Value = "";
        }

        protected void grvFacturasCentro_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnAgregar.Visible = true;
            btnCancelar0.Visible = true;
            grvFacturasAsignadas.Enabled = false;
            hfIdFactura.Value = grvFacturasCentro.SelectedRow.Cells[1].Text;
            hfValorFactura.Value = grvFacturasCentro.SelectedRow.Cells[5].Text;
        }

        protected void btnCancelar0_Click(object sender, EventArgs e)
        {
            btnAgregar.Visible = false;
            btnCancelar0.Visible = false;
            grvFacturasCentro.SelectedIndex = -1;
            grvFacturasAsignadas.Enabled = true; 
        }

        protected void grvFacturasAsignadas_DataBound(object sender, EventArgs e)
        {
            if (grvFacturasAsignadas.Rows.Count > 0)
            {
                SumarFacturas();
            }
            else
            {
                txtValorFactura.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(0));
                txtSaldo.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(hfValorCupon.Value));
                Alerta("Atención: No hay Facturas Asociadas al Cupón de Pago Anticipado" );
            }
        }

        protected void grvFacturasAsignadas_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnEliminar.Visible = true;
            btnCancelar.Visible = true;
            grvFacturasCentro.Enabled = false;
            hfIdPagosAnticipados.Value = grvFacturasAsignadas.SelectedRow.Cells[1].Text;
        }
    }
}