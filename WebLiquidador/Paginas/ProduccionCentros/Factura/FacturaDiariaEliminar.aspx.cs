using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Factura
{
    public partial class FacturaDiariaEliminar : System.Web.UI.Page
    {
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
            }
        }

        protected void btnBorrar_Click(object sender, EventArgs e)
        {
            btnBorrar.Enabled = false;
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_FacturaDiariaDetalleDelete]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                    cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    btnBorrar.Enabled = false;
                    Alerta("Listo!!!!! Prefactura Diaria Borrada");

                    grvProductosFacturaDiaria.DataSource = null;
                    grvProductosFacturaDiaria.DataBind();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Factura/FacturaDiariaEliminar.aspx", false);
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

        protected void grvProductosFacturaDiaria_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            { 
              if (grvProductosFacturaDiaria.Rows.Count == 0 )
              {
                  Alerta("La Prefactura Diaria No Tiene Productos para: " + Session["_NombreUsuario"].ToString());
                  btnBorrar.Enabled = false;
              }
            }
        }

    }
}