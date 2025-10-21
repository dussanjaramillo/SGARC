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

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.CuponPago
{
    public partial class TrasladoCuponPago : System.Web.UI.Page
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

        protected void ddlRegional0_DataBound(object sender, EventArgs e)
        {
            ddlRegional0.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlRegional0_SelectedIndexChanged(object sender, EventArgs e)
        {
            BuscarCentroFormacionD();
        }

        protected void BuscarCuponPagoCentroFormacion()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarCuponPagoActivoXNroInternodeTransaccion]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@NroInternodeTransaccion", SqlDbType.Text).Value = txtCuponPago.Text.ToString();
                
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfIdCuponPago.Value = reader[0].ToString();
                            txtRegional.Text = reader[1].ToString();
                            txtCodigoCentroFormacion.Text = reader[2].ToString();
                            txtNombreCentroFormacion.Text = reader[3].ToString();
                            txtNroInternodeTransaccion.Text = reader[4].ToString();
                            txtValorPago.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(reader[5].ToString()));
                            txtFechaPago.Text = Convert.ToDateTime(reader[6]).ToShortDateString();
                            txtNombreTipoIngreso.Text = reader[7].ToString();
                            hfAsignado.Value = reader[8].ToString();
                            txtIdentificacion.Text = reader[9].ToString();  
                            txtPrimerNombre.Text = reader[10].ToString();
                            txtPrimerApellido.Text = reader[11].ToString();
                            txtPrefactura.Text = reader[12].ToString();
                        }

                        if (hfAsignado.Value == "")
                            {
                            ddlRegional0.Enabled = true;
                            ddlCentroFormacion0.Enabled = true;
                            ddlTipoIngreso.Enabled = true;

                            txtCuponPago.Enabled = false;
                            btnBuscar.Enabled = false;
                            btnTrasladoCuponPago.Visible = true;
                        }
                        else
                        {
                            Alerta("El Cupón de Pago Ya Está Asignado a un Documento Equivalente");
                        }
                        con.Close();
                    }
                    else
                    {
                        Alerta("El Cupón de Pago No Existe");
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void BuscarCentroFormacionD()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            var Textocmd = "[dbo].[Usp_BuscarCentroFormacionXRegional]";
            SqlConnection con = new SqlConnection(CadenaConexion);
            SqlCommand cmd = new SqlCommand(Textocmd, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IdRegional", Convert.ToInt16(ddlRegional0.SelectedValue.ToString()));

            SqlDataAdapter CentroFormacion = new SqlDataAdapter(cmd);
            DataSet dsCentroFormacion = new DataSet();
            CentroFormacion.Fill(dsCentroFormacion, "CentroFormacion");

            ddlCentroFormacion0.DataSource = dsCentroFormacion.Tables["CentroFormacion"].DefaultView;
            ddlCentroFormacion0.DataTextField = "NombreCentroFormacion";
            ddlCentroFormacion0.DataValueField = "IdCentroFormacion";
            ddlCentroFormacion0.DataBind();
            ddlCentroFormacion0.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnTrasladoCuponPago_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_TrasladoCuponPagoUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(ddlCentroFormacion0.SelectedValue);
                    cmd.Parameters.Add("@IdCuponPago", SqlDbType.Int).Value = Convert.ToInt32(hfIdCuponPago.Value);
                    cmd.Parameters.Add("@IdTipoIngreso", SqlDbType.Int).Value = Convert.ToInt32(ddlTipoIngreso.SelectedValue);
                    cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                    btnTrasladoCuponPago.Visible = false; 

                    Alerta("Cupón de Pago Trasladado");
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/CuponPago/TrasladoCuponPago.aspx", false);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscarCuponPagoCentroFormacion();
        }

        protected void ddlTipoIngreso_DataBound(object sender, EventArgs e)
        {
            ddlTipoIngreso.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }
    }
}