using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using WebLiquidador.App_Code;

namespace WebLiquidador.Paginas.ProduccionCentros.Wompi
{
    public partial class GenerarQrCentroFormacion : System.Web.UI.Page
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

        protected void btnGenerarQr_Click(object sender, EventArgs e)
        {
            System.IO.File.Delete(Server.MapPath("~/Paginas/ProduccionCentros/Wompi/QrPagosRapidos/" + hfCodigoCentroFormacion.Value));
            string DatosQr = txtLinkWompiPagosRapidos.Text.Trim();
            string Path = Server.MapPath("~/Paginas/ProduccionCentros/Wompi/QrPagosRapidos/");
            GenerarQrWompi ImagenQr = new GenerarQrWompi();
            string ImagenOk = ImagenQr.Qr(hfCodigoCentroFormacion.Value, DatosQr, Path);
            ImagenQrWompi.ImageUrl = "~/Paginas/ProduccionCentros/Wompi/QrPagosRapidos/" + hfCodigoCentroFormacion.Value + ".jpg";
        }

        protected void BuscarLinkWompi()
        {
            hfIdCentroFormacion.Value = ddlCentroFormacion.SelectedValue;
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                txtLinkWompiPagosRapidos.Text = "";
                var Textocmd = "[CentroFormacion].[Usp_BuscarLinkWompi]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(hfIdCentroFormacion.Value);
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfCodigoCentroFormacion.Value = reader[0].ToString();
                            txtLinkWompiPagosRapidos.Text = reader[1].ToString();
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

        protected void ddlRegional_DataBound(object sender, EventArgs e)
        {
            ddlRegional.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlCentroFormacion_DataBound(object sender, EventArgs e)
        {
            ddlCentroFormacion.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Wompi/GenerarQrCentroFormacion.aspx", false);
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

        protected void ddlCentroFormacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnGenerarQr.Enabled = false;
            BuscarLinkWompi();
            if (txtLinkWompiPagosRapidos.Text != "")
            {
                btnGenerarQr.Enabled = true;
                ddlRegional.Enabled = false;
                ddlCentroFormacion.Enabled = false;
            }
        }
    }
}