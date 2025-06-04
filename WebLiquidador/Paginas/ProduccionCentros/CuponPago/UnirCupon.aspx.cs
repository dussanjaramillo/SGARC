using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;


//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci


namespace WebLiquidador.Paginas.ProduccionCentros.CuponPago
{
    public partial class UnirCupon : System.Web.UI.Page
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
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/CuponPago/UnirCupon.aspx", false);
        }

        protected void grvFacturaXCentro_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //if (grvFacturaXCentro.Rows.Count == 0)
                //{
                //    Alerta("No Hay Documentos Equivalentes para su Centro");
                //    return;
                //}
            }
        }

        protected void grvFacturaXCentro_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfNumeroFactura.Value = grvFacturaXCentro.SelectedRow.Cells[3].Text;
            hfValorDocumento.Value = grvFacturaXCentro.SelectedRow.Cells[6].Text.Replace(".","");
            Label1.Text = grvFacturaXCentro.SelectedRow.Cells[6].Text.Replace(".", "");
        }

        protected void ddlRegional_DataBound(object sender, EventArgs e)
        {
            ddlRegional.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlCentroFormacion_DataBound(object sender, EventArgs e)
        {
            ddlCentroFormacion.Items.Insert(0, new ListItem("Seleccione...", "-1"));
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

        protected void grvPagos_DataBound(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                //if (grvPagos.Rows.Count == 0)
                //{
                //    Alerta("Constructor Sin Pagos");
                //}
            }
        }

        protected void chkSel_CheckedChanged(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                Int64 ValorCupon = 0;
                CuponesPago.Value = "";
                Int32 NumeroCuponesSeleccionados = 0;

                foreach (GridViewRow row in grvPagos.Rows)
                {
                    CheckBox chkSel = (CheckBox)row.FindControl("chkSel");
                    if (chkSel.Checked)
                    {
                        ValorCupon = ValorCupon + Convert.ToInt64(grvPagos.Rows[row.RowIndex].Cells[5].Text.Replace(".",""));
                        CuponesPago.Value = CuponesPago.Value + HttpUtility.HtmlDecode(grvPagos.Rows[row.RowIndex].Cells[1].Text) + "|";
                        NumeroCuponesSeleccionados ++;
                    }
                }
                Label2.Text = Convert.ToString(ValorCupon);
                if (ValorCupon == 0)
                {
                    Alerta("Error: No Ha Seleccionado Ningún Pago");
                    return;
                }

                if ((Label1.Text == Label2.Text) && (NumeroCuponesSeleccionados > 1))
                {
                    int Longitud = CuponesPago.Value.Length;
                    CuponesPago.Value = CuponesPago.Value.Substring(0, Longitud - 1);
                    btnUnirCupones.Enabled = true;
                    grvPagos.Enabled = false;
                }
            }
        }

        protected void ddlRegional_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                grvPagos.DataSource = null;
                grvFacturaXCentro.DataSource = null;
            }
        }

        protected void ProcesarUnirCupon()
        {
            if (!IsValid)
            {
                return;
            }

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_UnirCuponesPago]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    
                    cmd.Parameters.Add("@NumeroFactura", SqlDbType.BigInt).Value = Convert.ToInt32(hfNumeroFactura.Value);
                    cmd.Parameters.Add("@CuponesPago", SqlDbType.Text).Value = CuponesPago.Value;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                    return;
                }
            }
            btnUnirCupones.Enabled = false;
            Alerta("Atención!!! Cupones de Pagos Unidos y Procesados");
        }

        protected void btnUnirCupones_Click(object sender, EventArgs e)
        {
           ProcesarUnirCupon();
        }
    }
}