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
using WebLiquidador.App_Code;
using System.Drawing;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.CuponPago
{
    public partial class DevolucionCuponPagoConfirmar : System.Web.UI.Page
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
            Response.Redirect("~/Paginas/ProduccionCentros/CuponPago/DevolucionCuponPagoConfirmar.aspx", false);
        }

        protected void grvDevolucionCuponPago_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfIdDevolucionCuponPago.Value = grvDevolucionCuponPago.SelectedRow.Cells[1].Text;
            hfPagado.Value = grvDevolucionCuponPago.SelectedRow.Cells[10].Text;
            if (hfPagado.Value == "Si")
            {
                grvDevolucionCuponPago.SelectedIndex = -1;
                Alerta("Atención: Esta Devolución ya se Efectúo");
                return;
            }
            txtFechaPago.Enabled = true;
            btnConfirmar.Enabled = true;
            txtFechaPago.Focus();

        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_DevolucionCuponPagoUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();
                    cmd.Parameters.Add("@IdDevolucionCuponPago", SqlDbType.BigInt).Value = Convert.ToInt64(hfIdDevolucionCuponPago.Value);
                    cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());
                    cmd.Parameters.Add("@FechaModifica", SqlDbType.Date).Value = Convert.ToDateTime(txtFechaPago.Text);
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Alerta("Atención: Se Actualizó la fecha de Pago de la Devolucion");
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                    return;
                }
            }

            btnConfirmar.Enabled = false;
            txtFechaPago.Text = "";
            txtFechaPago.Enabled = false;
         }

    }
}