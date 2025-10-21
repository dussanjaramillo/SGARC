using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebLiquidador.Paginas.ProduccionCentros.CuponPago
{
    public partial class UnirCuponMasivo : System.Web.UI.Page
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

        protected void btnEjecutarUnirCupones_Click(object sender, EventArgs e)
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
                    cmd.Parameters.Add("@Mes", SqlDbType.Int).Value = Convert.ToInt32(hfMes.Value);
                    cmd.Parameters.Add("@Año", SqlDbType.Int).Value = Convert.ToInt32(hfAño.Value);
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
            btnEjecutarUnirCupones.Enabled = false;
            Alerta("Listo!!! Cupones de Pagos Unidos y Procesados");
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
            Response.Redirect("~/Paginas/ProduccionCentros/CuponPago/UnirCuponMasivo.aspx", false);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarValorFacturaNoPagada]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@NumeroFactura", SqlDbType.BigInt).Value = Convert.ToInt64(txtDocumentoEquivalente.Text.ToString().Trim());
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            txtValorDocumento.Text = string.Format("{0:###,###,###,##0}", Convert.ToInt64(reader[0].ToString()));  
                        }
                        txtDocumentoEquivalente.Enabled = false;
                        btnBuscar.Enabled = false;
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }

            //txtValorDocumento.Text = "3968905";
            if (txtValorDocumento.Text == "")
            {
                Alerta("!!! Atención !! El Documento Equivalente Ya está Pagado o No existe");
                return;
            }

            if (hfValorCupones.Value == txtValorDocumento.Text)
            {
                btnEjecutarUnirCupones.Enabled = true;
                btnBuscar.Enabled = false;
                Panel1.Visible = false;
            }
            else
            {
                Panel1.Visible = true;
            }
        }


        protected void grvValorCupones_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //hfValorCupones.Value = e.Row.Cells[1].Text.Replace(",","") ;
                hfMes.Value = e.Row.Cells[3].Text;
                hfAño.Value = e.Row.Cells[4].Text;
            }
        }

    }
}