using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace WebLiquidador.Paginas.CostasProcesales.Obligacion
{
    public partial class Pagos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            //if ((new List<string> { "1", "2", "3", "4", "6", "7", "8", "9" }).Contains(Session["_IdCargo"].ToString()))
            //{
            //    Response.Redirect("~/DefaultCf.aspx");
            //}

            if (!IsPostBack)
            {
                txtIdentificacion.Focus();
            }
            lblEstado.Text = Session["_NombreRegionalUsuario"].ToString();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscarDeudor(txtIdentificacion.Text, 0);
            //btnAgregar.Enabled = true;
            btnImprimir.Enabled = true;
        }

        protected void BuscarDeudor(string Identificacion, Int32 IdDeudor)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CostasProcesales].[Usp_BuscarDeudor]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdDeudor", SqlDbType.Int).Value = IdDeudor;
                cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Identificacion.ToString();
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfIdDeudor.Value = reader[0].ToString();
                            txtNombre.Text = reader[2].ToString();
                        }
                        btnBuscar.Enabled = false;
                        txtIdentificacion.Enabled = false;
                        con.Close();
                    }
                    else
                    {
                        Alerta("La Identificacion del Deudor No Existe");
                        txtIdentificacion.Focus();
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
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
            Response.Redirect("~/Paginas/CostasProcesales/Obligacion/Pagos.aspx", false);
        }

        protected void btnImprimir_Click(object sender, EventArgs e)
        {
            Session["_Identificacion"] = txtIdentificacion.Text;

            string _open = "window.open('VisorPagos.aspx', '_blank');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), _open, true);

        }
 
        protected void grvPagosXIdentificacion_DataBound(object sender, EventArgs e)
        {
            if (grvPagosXIdentificacion.Rows.Count == 0)
            {
                btnImprimir.Enabled = false;
            }
        }
    }
}