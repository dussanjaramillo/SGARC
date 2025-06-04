using System;
using Microsoft.Reporting.WebForms;
using System.Globalization;

namespace WebLiquidador.Paginas.CostasProcesales.Obligacion
{
    public partial class VisorProyeccionIntereses : System.Web.UI.Page
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
                
                hfOpcion.Value = Session["_IdObligacion"].ToString();
                hfFechaFinal.Value = Session["_FechaFinal"].ToString();
               

                CultureInfo culture = new CultureInfo("es-CO");

                ReportViewer1.KeepSessionAlive = false;
                ReportViewer1.AsyncRendering = false;

                ReportViewer1.LocalReport.EnableExternalImages = true;
                //ReportParameter repParam;
                ReportViewer1.LocalReport.DisplayName = "ProyeccionIntereses_"+ Session["_Identificacion"].ToString();
                ReportViewer1.LocalReport.ReportPath = "Paginas/CostasProcesales/Obligacion/ProyeccionIntereses.rdl";
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", "SdsBuscarProyeccionIntereses"));
                ReportViewer1.LocalReport.SetParameters(new ReportParameter("IdObligacion", hfOpcion.Value));
                ReportViewer1.LocalReport.SetParameters(new ReportParameter("FechaFinal", hfFechaFinal.Value));
                ReportViewer1.LocalReport.SetParameters(new ReportParameter("NombreUsuario", Session["_NombreUsuario"].ToString()));
                ReportViewer1.LocalReport.Refresh();
            }
        }
    }
}