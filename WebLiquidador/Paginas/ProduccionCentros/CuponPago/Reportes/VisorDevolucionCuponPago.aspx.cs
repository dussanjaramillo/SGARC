using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Globalization;
using System.Threading;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.CuponPago.Reportes
{
    public partial class VisorDevolucionCuponPago : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {

                CultureInfo culture = new CultureInfo("es-CO");
                this.ReportViewer1.KeepSessionAlive = false;
                this.ReportViewer1.AsyncRendering = false;
                var Opcion = (string)Session["_Opcion"];

                if (Opcion == "1")
                {
                    ReportViewer1.LocalReport.DisplayName = "DevolucionCuponPago_" + Session["_NombreCentroFormacion"].ToString();
                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", "SdsBuscarDevolucionCuponPagoXIdDevolucionCuponPago"));
                    ReportViewer1.LocalReport.ReportPath = "Paginas/ProduccionCentros/CuponPago/Reportes/DevolucionCuponPago.rdlc";
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("ValorTotalLetras", Session["_ValorTotalLetras"].ToString()));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("Pagado", Session["_Pagado"].ToString()));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("NombreUsuario", Session["_NombreUsuario"].ToString()));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("Coordinador", Session["_Coordinador"].ToString()));
                    ReportViewer1.LocalReport.Refresh();
                }

            }
        }
    }
}