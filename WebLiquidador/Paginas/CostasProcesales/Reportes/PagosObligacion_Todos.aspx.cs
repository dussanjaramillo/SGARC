using System;
using Microsoft.Reporting.WebForms;
using System.Globalization;

namespace WebLiquidador.Paginas.CostasProcesales.Reportes
{
    public partial class PagosObligacion_Todos : System.Web.UI.Page
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
                ////https://docs.oasiscom.com/Desarrollo/reporterdl

                CultureInfo culture = new CultureInfo("es-CO");

                ReportViewer1.KeepSessionAlive = false;
                ReportViewer1.AsyncRendering = false;

                ReportViewer1.LocalReport.EnableExternalImages = true;
                //ReportParameter repParam;
                ReportViewer1.LocalReport.DisplayName = "ObligacionesTodas";
                ReportViewer1.LocalReport.ReportPath = "Paginas/CostasProcesales/Reportes/PagosObligacion_Todos.rdl";
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", "SdsBuscarPagosObligacion_Todos"));
                ReportViewer1.LocalReport.SetParameters(new ReportParameter("NombreUsuario", Session["_NombreUsuario"].ToString()));
                ReportViewer1.LocalReport.Refresh();
            }
        }
    }
}