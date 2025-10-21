using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Globalization;
using System.Threading;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.AtencionCiudadano
{
    public partial class VisorEstadoCuenta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }
            
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(Request.UserLanguages[0]);
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(Request.UserLanguages[0]);

            var Opcion = (string)Session["_Opcion"];
            
            if (!this.IsPostBack)
            {

                if (Opcion == "1")
                {
                    ReportViewer1.LocalReport.DisplayName = "EstadoCuenta_" + Session["_Identificacion"].ToString();
                    ReportViewer1.LocalReport.ReportPath = "Paginas/AtencionCiudadano/EstadoCuenta.rdlc";
                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", "SdsBuscarAportanteEstadoCuenta"));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("ReportParameter1", Session["_Identificacion"].ToString()));
                    
                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet2", "SdsBuscarResolucionesEstadoCuenta"));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("ReportParameter1", Session["_Identificacion"].ToString()));

                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet3", "SdsBuscarResolucionesPEstadoCuenta"));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("ReportParameter1", Session["_Identificacion"].ToString()));

                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet4", "SdsBuscarLiquidacionesEstadoCuenta"));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("ReportParameter1", Session["_Identificacion"].ToString()));

                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet5", "SdsBuscarLiquidacionesPEstadoCuenta"));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("ReportParameter1", Session["_Identificacion"].ToString()));
                    ReportViewer1.LocalReport.Refresh();
                }
                if (Opcion == "2")
                {
                    ReportViewer1.LocalReport.DisplayName = "ConsultaDatosGenerales_" + Session["_Identificacion"].ToString();
                    ReportViewer1.LocalReport.ReportPath = "Paginas/Certificados/ConsultaDatosGenerales.rdlc";
                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", "SdsDatosGenerales"));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("Identificacion", Session["_Identificacion"].ToString()));
    
                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet2", "SdsDatosGenerales1"));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("Identificacion", Session["_Identificacion"].ToString()));

                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet3", "SdsDatosGenerales2"));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("Identificacion", Session["_Identificacion"].ToString()));

                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet4", "SdsDatosGenerales3"));
                    ReportViewer1.LocalReport.SetParameters(new ReportParameter("Identificacion", Session["_Identificacion"].ToString()));
                    ReportViewer1.LocalReport.Refresh();

                }
                

            }
        }
    }
}