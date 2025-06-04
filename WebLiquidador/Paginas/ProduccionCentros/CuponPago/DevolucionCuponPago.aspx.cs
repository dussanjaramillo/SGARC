using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.CuponPago
{
    public partial class DevolucionCuponPago : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if ((new List<string> { "1", "2", "3", "4", "6", "7", "8", "9" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }

            if (!IsPostBack)
            {
                txtCuponPago.Focus();
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
            Response.Redirect("~/Paginas/ProduccionCentros/CuponPago/DevolucionCuponPago.aspx", false);
        }

        protected void btnDevolverCuponPago_Click(object sender, EventArgs e)
        {
            Int64 Saldo = (Convert.ToInt64(hfValorCupon.Value) - Convert.ToInt64(txtValorTotalDevolucion.Text));

            if (Convert.ToInt64(txtValorCuponDevolver.Text) > Saldo)
            {
                Alerta("Atención: El Valor a Devolver debe ser menor o igual a: " + string.Format("{0:$##,###,###,##0}", Convert.ToInt64(hfValorCupon.Value.ToString())));
                txtValorCuponDevolver.Focus();
                return;
            }

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_DevolucionCuponPagoInsert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();
                    cmd.Parameters.Add("@IdCuponPago", SqlDbType.BigInt).Value = Convert.ToInt64(hfIdCuponPago.Value);
                    cmd.Parameters.Add("@IdMotivoDevolucion", SqlDbType.Int).Value = Convert.ToInt32(ddlMotivoDevolucion.SelectedValue);
                    cmd.Parameters.Add("@ValorDevolucion", SqlDbType.BigInt).Value = Convert.ToInt64(txtValorCuponDevolver.Text);
                    cmd.Parameters.Add("@ValorTotaldelPago", SqlDbType.BigInt).Value = Convert.ToInt64(hfValorCupon.Value);
                    cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());
                    cmd.Parameters.Add("@Observacion", SqlDbType.Text).Value = txtObservacion.Text.Trim();

                    cmd.ExecuteNonQuery();
                    con.Close();
                    btnDevolverCuponPago.Enabled = false;
                    ddlMotivoDevolucion.SelectedIndex = -1;
                    txtValorCuponDevolver.Text = "";
                    Alerta("Listo: La Devolución del Cupón fué Satisfactoria");
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                    return;
                }
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscarValorTotalDevolucionCuponPago();
            txtCuponPago.Enabled = false;
            btnBuscar.Enabled = false; 
        }

        protected void BuscarValorTotalDevolucionCuponPago()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            var Textocmd = "[CentroFormacion].[Usp_BuscarValorTotalDevolucionCuponPago]";
            SqlConnection con = new SqlConnection(CadenaConexion);
            SqlCommand cmd = new SqlCommand(Textocmd, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@NroInternodeTransaccion", txtCuponPago.Text.Trim());
            try
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        if (reader[0].ToString() != "")
                        {
                            txtValorTotalDevolucion.Text = string.Format("{0:###,###,###,##0}", Convert.ToInt64(reader[0].ToString()));
                        }
                        else
                        {
                            txtValorTotalDevolucion.Text = "0";
                        }
                    }
                    con.Close();
                }
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }

        protected void grvPagosDisponibles_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfValorCupon.Value = grvPagosDisponibles.SelectedRow.Cells[5].Text;
            hfValorCupon.Value = hfValorCupon.Value.Replace(",", "");
            hfValorCupon.Value = hfValorCupon.Value.Replace(".", "");

            txtValorTotalDevolucion.Text = txtValorTotalDevolucion.Text.Replace(",", "");
            txtValorTotalDevolucion.Text = txtValorTotalDevolucion.Text.Replace(".", "");

            if (Convert.ToInt64(hfValorCupon.Value) == 0)
            {
                txtValorCuponDevolver.Visible = false;
                txtObservacion.Visible = false;
                Alerta("Atención: El Cupón Seleccionado Tiene un Valor de Cero");
                return;
            }
            if ((Convert.ToInt64(hfValorCupon.Value) - Convert.ToInt64(txtValorTotalDevolucion.Text)) <= 0)
            {
                Alerta("Atención: Ya Fué Devuelto el Total del Valor del Cupón de Pago");
                grvPagosDisponibles.SelectedIndex = -1;
                txtValorCuponDevolver.Focus();
                return;
            }

            hfIdCuponPago.Value = grvPagosDisponibles.SelectedRow.Cells[1].Text;
            txtValorCuponDevolver.Enabled = true;
            txtObservacion.Enabled = true;
            ddlMotivoDevolucion.Enabled = true;
            btnDevolverCuponPago.Enabled = true;
            txtValorCuponDevolver.Focus();
        }

        protected void ddlMotivoDevolucion_DataBound(object sender, EventArgs e)
        {
            ddlMotivoDevolucion.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

    }
}