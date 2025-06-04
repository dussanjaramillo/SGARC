using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Text;
using WebLiquidador.App_Code;

namespace WebLiquidador.Paginas.ProduccionCentros.Wompi
{
    public partial class ConsultaEstadoPagos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            //Cargo
            //1 Coordinador
            //2 Abogado
            //3 Fiscalizador
            //4 Técnico
            //5 Administrador
            //6 Profesional
            //7 Siif - Nación
            //8 Subdirector
            //9 Producción

            if (!IsPostBack)
            {

                DateTime nuevaFecha = DateTime.Now;
                txtFechaInicial.Text = nuevaFecha.AddDays(-1).ToString("yyyy-MM-dd");
                txtFechaFinal.Text = nuevaFecha.AddDays(-1).ToString("yyyy-MM-dd");
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();

            }
        }

        protected void Alerta(string Mensaje)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("alert('");
            sb.Append(Mensaje.Replace("'", "").Replace("\r\n", ""));
            sb.Append("')};");
            sb.Append("</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        }

        public bool IsDate(object inValue)
        {
            bool bValid;
            try
            {
                DateTime myDT = DateTime.Parse(inValue.ToString());
                bValid = true;
            }
            catch (Exception e)
            {
                bValid = false;
                string Excepcion = e.Message;
            }

            return bValid;
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
            if (grvPagosWompi.Rows.Count == 0 && !IsPostBack)
            {
                Alerta("Atención!!!! No hay pagos de Wompi para su Centro");
            }
        }

        protected void btn_Limpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Wompi/ConsultaEstadoPagos.aspx", false);
        }

        string Excepcion = "";
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            if (!IsDate(txtFechaInicial.Text))
            {
                Alerta(Excepcion);
                txtFechaInicial.Focus();
                return;
            }

            if (!IsDate(txtFechaFinal.Text))
            {
                Alerta(Excepcion);
                txtFechaFinal.Focus();
                return;
            }
        }

        protected void grvPagosWompi_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (grvPagosWompi.Rows.Count == 0 && IsPostBack)
                {
                    Alerta("No Hay Pagos por Wompi para su Centro entre las Fechas Seleccionadas");
                    return;
                }
            }
        }
    }
}