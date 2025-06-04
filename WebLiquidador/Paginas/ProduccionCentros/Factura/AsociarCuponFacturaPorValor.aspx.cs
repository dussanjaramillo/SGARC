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


namespace WebLiquidador.Paginas.ProduccionCentros.Factura
{
    public partial class AsociarCuponFacturaPorValor : System.Web.UI.Page
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

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            hfIdCentroFormación.Value = ddlCentroFormacion.SelectedValue;
            hfBuscar.Value = "1";
            btnAsociar.Enabled = false;
            BuscarFactura();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Factura/AsociarCuponFacturaPorValor.aspx", false);
        }

        protected void ddlRegional_DataBound(object sender, EventArgs e)
        {
            ddlRegional.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        private void BuscarFactura()
        {
            btnAsociar.Enabled = false;
            grvDocumento.DataSource = null;
            grvDocumento.DataBind();
        }

        protected void ddlCentroFormacion_DataBound(object sender, EventArgs e)
        {
            ddlCentroFormacion.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void grvCupones_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfBuscar.Value = "0";
            txtNumeroFactura.Text = grvCupones.SelectedRow.Cells[5].Text.Replace("&nbsp;", ""); 
            hfIdCuponPago.Value = grvCupones.SelectedRow.Cells[1].Text;
            btnAsociar.Enabled = false;
            txtMotivoAsociacion.Text = "";
            txtNumeroFactura.Enabled = true;
            btnBuscar.Enabled = true;
            txtNumeroFactura.Focus(); 
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

        protected void grvCupones_DataBound(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (grvCupones.Rows.Count == 0)
                {
                    Alerta("No Hay Cupones de Pago para el Centro");
                    return;
                }
            }
        }

        protected void grvDocumento_DataBound(object sender, EventArgs e)
        {
            if (hfBuscar.Value == "1")
            {
                if (grvDocumento.Rows.Count == 0)
                {
                    Alerta("El Número de la Prefactura No Existe para el Centro");
                    txtNumeroFactura.Focus(); 
                    return;
                }
                grvDocumento.SelectedIndex = 0;
                hfIdFactura.Value = grvDocumento.SelectedRow.Cells[0].Text;
                btnAsociar.Enabled = true;
                txtMotivoAsociacion.Enabled = true;
                txtMotivoAsociacion.Focus();
            }
        }

        protected void grvCupones_PageIndexChanged(object sender, EventArgs e)
        {
            grvCupones.SelectedIndex = -1;
            grvDocumento.Visible = false;
            txtNumeroFactura.Text = "";
        }

        protected void btnAsociar_Click(object sender, EventArgs e)
        {
            if (!IsValid)
            {
                return;
            }

            if (txtMotivoAsociacion.Text == "")
            {
                Alerta("El Motivo de Asociación es Obligatorio");
                txtMotivoAsociacion.Focus();
                return;
            }

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_AsociarCuponXDiferenteValor]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@IdCuponPago", SqlDbType.BigInt).Value = Convert.ToInt64(hfIdCuponPago.Value);
                    cmd.Parameters.Add("@IdFactura", SqlDbType.BigInt).Value = Convert.ToInt64(hfIdFactura.Value);
                    cmd.Parameters.Add("@NumeroFactura", SqlDbType.BigInt).Value = Convert.ToInt64(txtNumeroFactura.Text);

                    cmd.Parameters.Add("@MotivoAsociacion", SqlDbType.Text).Value = txtMotivoAsociacion.Text.Trim();  
                    cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();

                    Alerta("Listo!!! Prefactura Asociada al Cupón");
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                    return;
                }
            }
        }
    }
}