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
    public partial class DistribucionCuponPago : System.Web.UI.Page
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
                GlobalData.ItemCupon = 0;
                GlobalData.TotalDistribucion = 0;
                Session.Remove("_DistribucionCuponPago");
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

        protected void ddlRegional_DataBound(object sender, EventArgs e)
        {
            ddlRegional.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlRegional_SelectedIndexChanged(object sender, EventArgs e)
        {
            BuscarCentroFormacionD();
        }

        protected void BuscarCentroFormacionD()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            var Textocmd = "[dbo].[Usp_BuscarCentroFormacionXRegional]";
            SqlConnection con = new SqlConnection(CadenaConexion);
            SqlCommand cmd = new SqlCommand(Textocmd, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IdRegional", Convert.ToInt16(ddlRegional.SelectedValue.ToString()));

            SqlDataAdapter CentroFormacion = new SqlDataAdapter(cmd);
            DataSet dsCentroFormacion = new DataSet();
            CentroFormacion.Fill(dsCentroFormacion, "CentroFormacion");

            ddlCentroFormacion.DataSource = dsCentroFormacion.Tables["CentroFormacion"].DefaultView;
            ddlCentroFormacion.DataTextField = "NombreCentroFormacion";
            ddlCentroFormacion.DataValueField = "IdCentroFormacion";
            ddlCentroFormacion.DataBind();
            ddlCentroFormacion.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/CuponPago/DistribucionCuponPago.aspx", false);
        }

        public static class GlobalData
        {
            public static int ItemCupon;
            public static Int64 TotalDistribucion;
        }

        protected void btnAgregarCentro_Click(object sender, EventArgs e)
        {
            btnDistribuirCuponPago.Visible = true; 

            List<Distribucion> CuponPago = (List<Distribucion>)Session["_DistribucionCuponPago"];

            if (CuponPago == null)
            {
                CuponPago = new List<Distribucion>();
                GlobalData.ItemCupon = 1;
                GlobalData.TotalDistribucion = 0;
            }
            GlobalData.TotalDistribucion = GlobalData.TotalDistribucion + Convert.ToInt64(txtValorCupon.Text);

            if (GlobalData.TotalDistribucion > Convert.ToInt64(hfValorCupon.Value.Replace(".", "")))
            {
                Alerta("Alerta: La Suma de los Valores a Distribuir debe ser Menor o Igual al Valor del Cupón: " + hfValorCupon.Value);
                txtValorCupon.Focus();
                return;
            }

            btnDistribuirCuponPago.Enabled = true;
            CuponPago.Insert(GlobalData.ItemCupon-1, new Distribucion() { Item = GlobalData.ItemCupon - 1, IdCentroProduccion = Convert.ToInt32(ddlCentroFormacion.SelectedValue), NombreCentroProduccion = ddlCentroFormacion.SelectedItem.ToString(), ValorCupon = Convert.ToInt64(txtValorCupon.Text) });

            Session.Add("_DistribucionCuponPago", CuponPago);
            grvDistribucionCuponPago.DataSource = CuponPago;
            grvDistribucionCuponPago.DataBind();

            GlobalData.ItemCupon = GlobalData.ItemCupon + 1;
            
            decimal SumaTotalDistribucion = CuponPago.Sum(Tf => Tf.ValorCupon);
            txtTotalDistribucion.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(SumaTotalDistribucion.ToString()));

            txtValorCupon.Text = "";
            ddlRegional.SelectedIndex = -1;
            ddlCentroFormacion.SelectedIndex = -1;

            if (SumaTotalDistribucion == 0)
            {
                btnDistribuirCuponPago.Visible = false; 
            }
        }

        protected void btnDistribuirCuponPago_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_DistribucionCuponPago]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    con.Open();
                    foreach (GridViewRow row in grvDistribucionCuponPago.Rows)
                    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@IdCuponPago", SqlDbType.Int).Value = Convert.ToInt32(hfIdCuponPago.Value);
                        cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(row.Cells[2].Text);
                        cmd.Parameters.Add("@ValorDistribuido", SqlDbType.BigInt).Value = Convert.ToInt64(row.Cells[4].Text.Replace(".",""));
                        cmd.ExecuteNonQuery();
                    }
                    con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                    return;
                }
            }
            ActualizarDistribucionCuponPago();

            btnDistribuirCuponPago.Visible = false;
            btnAgregarCentro.Enabled = false;
            btnBorrar.Enabled = false;
            txtTotalDistribucion.Text = "";
            txtValorCupon.Enabled = false;
            ddlRegional.Enabled = false;
            ddlCentroFormacion.Enabled = false;
 
            Alerta("Atención: La Distribución se Efectuó Correctamente" );

        }

        protected void ActualizarDistribucionCuponPago()
        {
            var Diferencia = Convert.ToInt64(hfValorCupon.Value.Replace(".", "")) - GlobalData.TotalDistribucion;

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_DistribucionCuponPagoUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();
                    cmd.Parameters.Add("@IdCuponPago", SqlDbType.Int).Value = Convert.ToInt32(hfIdCuponPago.Value);
                    cmd.Parameters.Add("@Diferencia", SqlDbType.BigInt).Value = Convert.ToInt64(Diferencia);
                    cmd.ExecuteNonQuery();
                    con.Close();
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

        }

        protected void btnBorrar_Click(object sender, EventArgs e)
        {
            List<Distribucion> CuponPago = (List<Distribucion>)Session["_DistribucionCuponPago"];
            
            CuponPago.RemoveAt(Convert.ToInt16(hfItem.Value));
            grvDistribucionCuponPago.DataSource = CuponPago;
            grvDistribucionCuponPago.DataBind();

            btnBorrar.Enabled = false;
            btnBorrar.ForeColor = Color.Empty;
            btnBorrar.BackColor = Color.Empty;

            grvDistribucionCuponPago.SelectedIndex = -1;

            decimal SumaTotalDistribucion = CuponPago.Sum(Tf => Tf.ValorCupon);

            txtTotalDistribucion.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(SumaTotalDistribucion.ToString()));
            btnBorrar.Enabled = false;
            btnAgregarCentro.Enabled = true;

            if (CuponPago.Count == 0)
            {
                Session.Remove("_DistribucionCuponPago");
                btnDistribuirCuponPago.Visible = false; 
            }

        }

        protected void grvDistribucionCuponPago_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfItem.Value = grvDistribucionCuponPago.SelectedRow.Cells[1].Text;
            btnBorrar.Enabled = true;
            btnAgregarCentro.Enabled = false;
        }

        protected void grvPagosDisponibles_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Convert.ToInt64(grvPagosDisponibles.SelectedRow.Cells[5].Text.Replace(".","")) == 0)
            {
                ddlRegional.Enabled = false ;
                ddlCentroFormacion.Enabled = false;
                txtValorCupon.Visible = false;
                btnAgregarCentro.Visible = false;
                btnBorrar.Visible = false;
                Alerta("Atención: El Cupón Tiene un Valor de Cero");
                return; 
            }
            ddlRegional.Enabled = true;
            ddlCentroFormacion.Enabled = true;
            txtValorCupon.Visible = true; 

            hfIdCuponPago.Value = grvPagosDisponibles.SelectedRow.Cells[1].Text;
            hfValorCupon.Value = grvPagosDisponibles.SelectedRow.Cells[5].Text.Replace(".","") ;
            txtCuponPago.Enabled = false;
            btnBuscar.Enabled = false;
            btnAgregarCentro.Visible = true;
            btnBorrar.Visible = true;
            ddlRegional.Focus();
        }
    }
}