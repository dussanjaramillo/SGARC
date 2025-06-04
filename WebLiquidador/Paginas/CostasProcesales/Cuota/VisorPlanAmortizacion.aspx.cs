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


namespace WebLiquidador.Paginas.CostasProcesales.Cuota
{
    public partial class VisorPlanAmortizacion : System.Web.UI.Page
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
                //Session["_IdObligacion"] = hfIdObligacion.Value;
                ////https://docs.oasiscom.com/Desarrollo/reporterdl
                
                hfOpcion.Value = Session["_IdObligacion"].ToString();
                CultureInfo culture = new CultureInfo("es-CO");

                ReportViewer1.KeepSessionAlive = false;
                ReportViewer1.AsyncRendering = false;

                ReportViewer1.LocalReport.EnableExternalImages = true;
                //ReportParameter repParam;
                ReportViewer1.LocalReport.ReportPath = "Paginas/CostasProcesales/Cuota/PlanAmortizacion.rdl";
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", "SdsBuscarPlanAmortizacion"));
                ReportViewer1.LocalReport.SetParameters(new ReportParameter("IdObligacion", hfOpcion.Value));
                ReportViewer1.LocalReport.Refresh();
            }
        }

        protected void btnOtraFactura_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Factura/Factura.aspx", false);
        }
    }
}