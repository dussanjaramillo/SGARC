using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using System.Text;
using System.Drawing;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Factura
{
    public partial class AsociarCuponFactura : System.Web.UI.Page
    {
        static ArrayList Id = new ArrayList();
        static ArrayList ValorPago = new ArrayList();
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
                Id.Clear();
                ValorPago.Clear();
            }
        }

        protected void grvFacturaXCentro_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfNumeroFactura.Value = grvFacturaXCentro.SelectedRow.Cells[1].Text;
            hfValorFactura.Value = grvFacturaXCentro.SelectedRow.Cells[4].Text;
            hfValorFactura.Value = hfValorFactura.Value.Replace(",", "");
            hfValorFactura.Value = hfValorFactura.Value.Replace(".", "");
            hfFechaFactura.Value = grvFacturaXCentro.SelectedRow.Cells[5].Text;

            grvCupones.DataSource = SdsCuponPagoXCentro;
            grvCupones.DataBind();

            if (grvCupones.Rows.Count == 0)
            {
                Alerta("Atención!!! No hay Pagos");
                grvFacturaXCentro.SelectedIndex = -1;
                return; 
            }
            else
            {
                grvCupones.Caption = "Seleccione el o los Cupones a Asociar a la Prefactura";
            }
        }

        protected void SumarValorSeleccionado()
        {
            GlobalData.ValorPagado = 0;
            for (int c = 0; c < ValorPago.Count; c++)
            {
                GlobalData.ValorPagado = GlobalData.ValorPagado + Convert.ToInt64(ValorPago[c]);
            }
            if ((GlobalData.ValorPagado == Convert.ToInt64(hfValorFactura.Value)))
            {
                btnAsociarCupon.Enabled = true;
            }
        }

        public static class GlobalData
        {
            public static Int64 ValorPagado;
        }

        protected void btnAsociarCupon_Click(object sender, EventArgs e)
        {
            SumarValorSeleccionado();

            if ((GlobalData.ValorPagado != Convert.ToInt64(hfValorFactura.Value)))
            {
                Alerta("Alerta: El Valor de los Cupones debe ser Igual al valor de la Prefactura");
                return;
            }
            Asociar_CuponPago();
        }

        protected void BuscarValorTotaldelPagoCuponPagoAsociado()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarValorTotaldelPagoAsociado]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@NumeroFactura", SqlDbType.BigInt).Value = Convert.ToInt64(hfNumeroFactura.Value);
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfValorTotaldelPagoAsociado.Value = reader[0].ToString();
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

        protected void Asociar_CuponPago()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    btnAsociarCupon.Visible = false;
                    var Textocmd = "[CentroFormacion].[Usp_AsociarCuponPagoAFactura]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    for (int c = 0; c < Id.Count; c++)
                    {
                        int vResultado;
                        cmd.Parameters.Add("@IdCuponPago", SqlDbType.BigInt).Value = Convert.ToInt64(Id[c].ToString());
                        cmd.Parameters.Add("@NumeroFactura", SqlDbType.BigInt).Value = Convert.ToInt64(hfNumeroFactura.Value);
                        cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());
                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();
                    }

                    Alerta("Listo !!!!!! Cupones de Pago Asociados a la Prefactura");
                    grvFacturaXCentro.SelectedIndex = -1;

                    grvCupones.SelectedIndex = -1;
                    grvCupones.DataSource = null;
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                    return;
                }
            }
        }

        protected void Asociar_Factura()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_FacturaAsociadoUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@NumeroFactura", SqlDbType.BigInt).Value = Convert.ToInt64(hfNumeroFactura.Value);
                    cmd.Parameters.Add("@IdCuponPago", SqlDbType.Int).Value = Convert.ToInt32(hfIdCuponPago.Value.Trim());
                    cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
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
            Id.Clear();
            ValorPago.Clear();
            Response.Redirect("~/Paginas/ProduccionCentros/Factura/AsociarCuponFactura.aspx", false);
        }

        protected void grvCuponPagoXCentro_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (grvCupones.Rows.Count == 0)
                {
                    Alerta("No Hay Pagos para su Centro");
                    //grvFacturaXCentro.Enabled = false;
                    Panel2.Visible = false;
                    btnAsociarCupon.Visible = false;
                    return;
                }
            }
        }

        protected void grvFacturaXCentro_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (grvFacturaXCentro.Rows.Count == 0)
                {
                    grvCupones.Enabled = false;
                    btnAsociarCupon.Visible = false;
                    txtValorSeleccionado.Visible = false;
                    Alerta("No Hay Prefactura para su Centro");
                    return;
                }
            }
        }

        protected void grvCupones_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvCupones.SelectedIndex = -1;
            grvCupones.PageIndex = e.NewPageIndex;
            grvCupones.DataSource = SdsCuponPagoXCentro;
            grvCupones.DataBind();
        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            btnAsociarCupon.Visible = true;

            CheckBox cbi = (CheckBox)(sender);
            GridViewRow row = (GridViewRow)cbi.NamingContainer;

            if (cbi.Checked)
            {
                grvCupones.Rows[row.RowIndex].BackColor = Color.Aqua;
                Id.Add(grvCupones.Rows[row.RowIndex].Cells[1].Text);
                string Valor = grvCupones.Rows[row.RowIndex].Cells[6].Text.Replace(",","");
                Valor = Valor.Replace(".", "");
                ValorPago.Add(Valor);
                SumarValorSeleccionado();
                txtValorSeleccionado.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(GlobalData.ValorPagado.ToString()));
                if (hfNumeroFactura.Value != grvCupones.Rows[row.RowIndex].Cells[5].Text)
                {
                    Alerta("El Número de la Prefactura Seleccionado es Diferente al del Cupón de Pago, Debe cambiar primero el número de la Prefactura en el Cupón de Pago");
                    return;
                }
            }
            else
            {
                grvCupones.Rows[row.RowIndex].BackColor = Color.Empty; 
                Id.Remove(grvCupones.Rows[row.RowIndex].Cells[1].Text);
                string Valor = grvCupones.Rows[row.RowIndex].Cells[6].Text.Replace(",", "");
                Valor = Valor.Replace(".", "");
                ValorPago.Remove(Valor);
                SumarValorSeleccionado();
                txtValorSeleccionado.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(GlobalData.ValorPagado.ToString()));
            }

        }

        protected void grvCupones_PageIndexChanged(object sender, EventArgs e)
        {
            int count = 0;
            for (int c = 0; c < Id.Count; c++)
            {
                foreach (GridViewRow gvr in grvCupones.Rows)
                {
                    CheckBox chi = (CheckBox)(gvr.FindControl("CheckBox1"));
                    if (Id[c].ToString() == gvr.Cells[1].Text)
                    {
                        chi.Checked = true;
                        count += 1;
                    }
                }
                if (count == grvCupones.PageSize)
                {
                    CheckBox cbh = (CheckBox)grvCupones.HeaderRow.FindControl("CheckBox2");
                    cbh.Checked = true;
                }
            }
        }

        protected void grvFacturaXCentro_PageIndexChanged(object sender, EventArgs e)
        {
            grvFacturaXCentro.SelectedIndex = -1;
        }
    }
}