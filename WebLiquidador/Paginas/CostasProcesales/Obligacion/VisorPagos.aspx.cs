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


namespace WebLiquidador.Paginas.CostasProcesales.Obligacion
{
    public partial class VisorPagos : System.Web.UI.Page
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
                
                //hfOpcion.Value = Session["_IdObligacion"].ToString();
                CultureInfo culture = new CultureInfo("es-CO");

                ReportViewer1.KeepSessionAlive = false;
                ReportViewer1.AsyncRendering = false;
                
                ReportViewer1.LocalReport.EnableExternalImages = true;
                //ReportParameter repParam;
                ReportViewer1.LocalReport.ReportPath = "Paginas/CostasProcesales/Obligacion/PagosXIdentificacion.rdl";
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", "SdsBuscarPagos"));
                ReportViewer1.LocalReport.SetParameters(new ReportParameter("Identificacion", Session["_Identificacion"].ToString()));
                ReportViewer1.LocalReport.Refresh();
            }
        }
               
    }
}