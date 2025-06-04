using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Configuration;
using System.Globalization;
using System.Threading;


namespace WebLiquidador.Paginas.ProduccionCentros.Factura.Reportes
{
    public partial class VisorCotizacion : System.Web.UI.Page
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
                CultureInfo culture = new CultureInfo("es-CO");
                var Opcion = (string)Session["_Opcion"];
                hfOpcion.Value = (string)Session["_Opcion"];
                this.ReportViewer1.KeepSessionAlive = false;
                this.ReportViewer1.AsyncRendering = false;

                if (Opcion == "1")
                {
                    ReportViewer1.LocalReport.DisplayName = "Cotizacion_" + Session["_NumeroCotizacion"].ToString();
                    ReportViewer1.LocalReport.ReportPath = "Paginas/ProduccionCentros/Factura/Reportes/Cotizacion.rdlc";
                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", "SdsBuscarCotizacionXNumeroCotizacion"));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("IdCentroFormacion1", Session["_IdCentroFormacion1"].ToString()));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("ValorTotalLetras", Session["_ValorTotalLetras"].ToString()));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("NombreUsuario", Session["_NombreUsuario"].ToString()));
                    ReportViewer1.LocalReport.Refresh();
                }
            }
        }

        protected void btnOtraCotizacion_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Factura/Cotizacion.aspx", false);
        }
    }
}