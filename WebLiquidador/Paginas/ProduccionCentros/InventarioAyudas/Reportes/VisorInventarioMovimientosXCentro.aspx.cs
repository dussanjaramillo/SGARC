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

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.InventarioAyudas.Reportes
{
    public partial class VisorInventarioMovimientosXCentro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                CultureInfo culture = new CultureInfo("es-CO");
                
                this.ReportViewer1.KeepSessionAlive = false;
                this.ReportViewer1.AsyncRendering = false;

                var Opcion = "1";
                //hfOpcion.Value = (string)Session["_Opcion"];

                if (Opcion == "1")
                {
                    ReportViewer1.LocalReport.DisplayName = "Inventario_" + Session["_NombreCentroFormacion"].ToString();
                    ReportViewer1.LocalReport.ReportPath = "Paginas/ProduccionCentros/InventarioAyudas/Reportes/InventarioMovimientosXCentro.rdlc";
                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", "SdsInventarioMovimientos"));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("IdCentroFormacion", Session["_IdCentroFormacion"].ToString()));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("FechaInicial", Session["_FechaInicial"].ToString()));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("FechaFinal", Session["_FechaFinal"].ToString()));
                    ReportViewer1.LocalReport.Refresh();
                }
            }
        }

    }
}