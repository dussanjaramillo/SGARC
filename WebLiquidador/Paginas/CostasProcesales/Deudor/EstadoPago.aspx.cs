using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Globalization;
using System.Threading;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci


namespace WebLiquidador.Paginas.FondoVivienda.Empleado
{
    public partial class EstadoPago : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if (!(new List<string> { "1", "2" }).Contains(Session["_IdUsuario"].ToString()))
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[FondoVivienda].[Usp_BuscarEmpleado]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Convert.ToString(Convert.ToInt64(txtIdentificacion.Text.ToString().Trim()));

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            txtNombreEmpleado.Text = reader[0].ToString();
                         }
                        txtIdentificacion.Enabled = false;
                        btnBuscar.Enabled = false;
                        btnImprimir.Enabled = true;
                        con.Close();
                    }
                    else
                    {
                        Alerta("La Identificacion del Empleado No Existe");
                        txtIdentificacion.Focus();
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
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

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/FondoVivienda/Empleado/EstadoPago.aspx", false);
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            if (grvPagosAhorro0.Rows.Count == 0)
            {
                Alerta("Atención, No hay Pagos Ahorro");
                return;
            }
            grvPagosAhorro0.Visible = true;
            grvPagosAhorro0.Caption = "Pagos Ahorro Vivienda: "+ txtIdentificacion.Text.ToString().Trim();
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvPagosAhorro0.AllowPaging = false;
            grvPagosAhorro0.AllowSorting = false;
            grvPagosAhorro0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvPagosAhorro0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "Pagos Ahorro Vivienda: " + txtIdentificacion.Text.ToString().Trim()+".xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvPagosAhorro0.Visible = false;

        }

        protected void btnImprimir_Click(object sender, EventArgs e)
        {
            Session["_Identificacion"] = txtIdentificacion.Text;
            Response.Redirect("~/Paginas/FondoVivienda/Empleado/Reportes/VisorEstadoPago.aspx", false);
        }
    }
}