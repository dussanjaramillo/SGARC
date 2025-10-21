using System;
using Microsoft.Reporting.WebForms;
using System.Globalization;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace WebLiquidador.Paginas.ProduccionCentros.Wompi
{
    public partial class VisorQrWompi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }


            if (!this.IsPostBack)
            {
                BuscarLinkPagosRapidos();
                
                CultureInfo culture = new CultureInfo("es-CO");

                this.ReportViewer1.KeepSessionAlive = false;
                this.ReportViewer1.AsyncRendering = false;

                ReportViewer1.LocalReport.EnableExternalImages = true;
                ReportParameter repParam;
                ReportViewer1.LocalReport.DisplayName = "QrPagosRapidos_"+Session["_NombreCentroFormacion"].ToString();
                ReportViewer1.LocalReport.ReportPath = "Paginas/ProduccionCentros/Wompi/Reportes/QrCentroFormacion.rdlc";
                string imagePath = new Uri(Server.MapPath("~/Paginas/ProduccionCentros/Wompi/QrPagosRapidos/" + Session["_CodigoCentroFormacion"].ToString()+".jpg")).AbsoluteUri;
                repParam = new ReportParameter("QrCentro", imagePath, true);
                ReportViewer1.LocalReport.SetParameters(new ReportParameter("NombreRegional", Session["_NombreRegionalUsuario"].ToString()));
                ReportViewer1.LocalReport.SetParameters(new ReportParameter("NombreCentroFormacion", Session["_NombreCentroFormacion"].ToString()));
                ReportViewer1.LocalReport.SetParameters(new ReportParameter("CodigoCentroFormacion", Session["_CodigoCentroFormacion"].ToString()));
                ReportViewer1.LocalReport.SetParameters(new ReportParameter("LinkPagosRapidos", hfLinkPagosRapidos.Value.ToString()));
                ReportViewer1.LocalReport.SetParameters(repParam);
                ReportViewer1.LocalReport.Refresh();
            }
        }

        private void BuscarLinkPagosRapidos()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarLinkWompiXCodigo]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@CentroFormacion", SqlDbType.Text).Value = Session["_CodigoCentroFormacion"].ToString();
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfLinkPagosRapidos.Value = reader[0].ToString().Trim();
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

    }
}