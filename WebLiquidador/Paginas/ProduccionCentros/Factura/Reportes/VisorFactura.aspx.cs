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
    public partial class VisorFactura : System.Web.UI.Page
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
                
                this.ReportViewer1.KeepSessionAlive = false;
                this.ReportViewer1.AsyncRendering = false;

                var Opcion = (string)Session["_Opcion"];
                hfOpcion.Value = (string)Session["_Opcion"];

                if (Opcion == "1")
                {
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportParameter repParam;
                    ReportViewer1.LocalReport.DisplayName = "PrefacturaNumero_" + Session["_Numerofactura"].ToString();
                    ReportViewer1.LocalReport.ReportPath = "Paginas/ProduccionCentros/Factura/Reportes/Factura.rdlc";
                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", "SdsBuscarFacturaXNumeroFactura"));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("ValorTotalLetras", Session["_ValorTotalLetras"].ToString()));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("NombreUsuario", Session["_NombreUsuario"].ToString()));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("FacturaAnulada", Session["_FacturaAnulada"].ToString()));
                    //ReportViewer1.LocalReport.SetParameters(new ReportParameter("LinkPasarela", "https://sgmm.sena.edu.co/Inicio.aspx?idLink={0}"));

                    string imagePath = new Uri(Server.MapPath("~/Paginas/ProduccionCentros/Wompi/Qr/0001.jpg")).AbsoluteUri;
                    repParam = new ReportParameter("FacturaQr", imagePath, true);
                    
                    ReportViewer1.LocalReport.SetParameters(repParam);
                    ReportViewer1.LocalReport.Refresh();
                }
            }
        }

        protected void btnOtraFactura_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Factura/Factura.aspx", false);
        }
    }
}