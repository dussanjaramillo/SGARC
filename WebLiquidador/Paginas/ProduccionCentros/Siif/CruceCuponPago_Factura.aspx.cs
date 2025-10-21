using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Collections.Generic;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Siif
{
    public partial class CruceCuponPago_Factura : System.Web.UI.Page
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
            //7 Coordinador DMP
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

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
 
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

        protected void btn_Limpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Siif/CruceCuponPago_Factura.aspx", false);
        }

        protected void grvIngresosXCentro_DataBound(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (grvIngresosXCentro.Rows.Count == 0)
                {
                    Alerta("Todos los Cupones de Pago ya están asociados al Documento Equivalente");
                    return;
                }
            }
        }

        protected void grvIngresosXCentro_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfIdCuponPago.Value =  grvIngresosXCentro.SelectedRow.Cells[1].Text;
            txtNumeroFacturaNew.Enabled = true;
            btnGuardar.Enabled = true;
            txtNumeroFacturaNew.Focus();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            hfFacturaExiste.Value = "0";
            BuscarNumeroFacturaXIdCentroFormacion();
            if (hfFacturaExiste.Value == "0")
            {
                txtNumeroFacturaNew.Focus();
                Alerta("Alerta!!! El Número de Documento Equivalente Suministrado No es de su Centro o No Existe");
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

                    Alerta("Listo!!! se Actualizó el Número del Documento Equivalente en el Cupón de Pago");
                    grvIngresosXCentro.SelectedIndex = -1;

                    btnGuardar.Enabled = false;
                    txtNumeroFacturaNew.Enabled = false;
                    grvIngresosXCentro.DataSource = null;

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
            var CadenaConexion = ConfigurationManager.ConnectionStrings["LiquidadorConnectionString"].ToString();
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

        }
    }
}