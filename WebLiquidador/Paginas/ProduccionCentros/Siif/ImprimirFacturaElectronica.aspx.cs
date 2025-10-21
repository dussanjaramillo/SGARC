using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Text;
using WebLiquidador.App_Code;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Siif
{
    public partial class ImprimirFacturaElectronica : System.Web.UI.Page
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

            if ((new List<string> { "1", "2", "3", "4", "6", "7", "8" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }

            if (!IsPostBack)
            {
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
            }
        }

        protected void grvFacturaXCentro_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["_Numerofactura"] = grvFacturaXCentro.SelectedRow.Cells[3].Text;
            hfCupon.Value = grvFacturaXCentro.SelectedRow.Cells[10].Text;
            Session["_Opcion"] = "1";
         }

        protected void Alerta(string Mensaje)
        {
            //string message = "Hello! Mudassar.";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("alert('");
            sb.Append(Mensaje.Replace("'", "").Replace("\r\n", ""));
            sb.Append("')};");
            sb.Append("</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        }

        protected void grvFacturaXCentro_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (grvFacturaXCentro.Rows.Count == 0)
                {
                    Alerta("No Hay Facturas Electrónica para su Centro");
                    return;
                }
            }
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            if (grvFacturaXCentro0.Rows.Count == 0)
            {
                Alerta("Atención, No hay Facturas Electrónicas");
                return;
            }

            if (ddlTipoArchivo.SelectedValue == "1")
            {
                ExportarTxt();
            }
            else
            {
                ExportarExcel();
            }
        }

        protected void ExportarExcel()
        {
            grvFacturaXCentro0.Visible = true;
            grvFacturaXCentro0.Caption = "Factura Electrónica Siif Nación";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvFacturaXCentro0.AllowPaging = false;
            grvFacturaXCentro0.AllowSorting = false;
            grvFacturaXCentro0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvFacturaXCentro0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "FacturaElectrónicaSiifNación.xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvFacturaXCentro0.Visible = false;
        }

        protected void ExportarTxt()
        {
            try
            {
                string PathArchivo = "FacturaElectrónicaSiifNación_" + DateTime.Now.ToShortDateString().Replace("/", "_") + ".txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[CentroFormacion].[Usp_BuscarPagosFacturaElectronicaXCentroSiif]";

                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                    cmd.CommandTimeout = 0;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    con.Close();

                    if (dt.Rows.Count > 0)
                    {
                        StringBuilder sb = new StringBuilder();
                        IEnumerable<string> columnNames = dt.Columns.Cast<DataColumn>().Select(column => column.ColumnName);
                        sb.AppendLine(string.Join("|", columnNames));

                        foreach (DataRow row in dt.Rows)
                        {
                            IEnumerable<string> fields = row.ItemArray.Select(field => field.ToString());
                            sb.AppendLine(string.Join("|", fields));
                        }

                        if (sb.Length > 0)
                        {
                            Response.Clear();
                            Response.Buffer = true;
                            Response.ContentType = "application/text/plain";
                            Response.AddHeader("Content-Disposition", "attachment;filename=" + PathArchivo);
                            Response.Charset = "UTF-8";
                            Response.ContentEncoding = System.Text.Encoding.Default;
                            Response.Write(sb.ToString());
                            Response.End();
                        }
                    }
                    else
                    {
                        Alerta("Atención: No Hay Facturas Electrónicas Registros");
                        return;
                    }
                }
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Siif/ImprimirFacturaElectronica.aspx", false);
        }
    }
}