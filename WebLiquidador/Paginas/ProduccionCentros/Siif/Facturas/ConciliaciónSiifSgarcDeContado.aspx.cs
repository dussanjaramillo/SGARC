using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using System.Text;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Siif.Facturas
{
    public partial class ConciliaciónSiifSgarcDeContado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            BuscarFacturaElectronicaXId(Convert.ToInt32(GridView1.SelectedRow.Cells[1].Text));
            hfId.Value = GridView1.SelectedRow.Cells[1].Text;
        }

        protected void BuscarFacturaElectronicaXId(int IdFacturaElectronicaSiif)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarFacturaElectronicaSiifTipoFacturaXId]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdFacturaElectronicaSiifXTipoFactura", SqlDbType.Int).Value = IdFacturaElectronicaSiif;
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            txtConsignacion.Text = reader[0].ToString();
                        }
                        con.Close();
                    }
                btnGuardar.Enabled = true;
                txtConsignacion.Enabled = true;
                txtConsignacion.BackColor = System.Drawing.Color.Aqua;
                txtConsignacion.Focus();    
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
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

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Siif/Facturas/ConciliaciónSiifSgarcDeContado.aspx", false);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (txtConsignacion.Text == "")
            {
                txtConsignacion.Focus();
                txtConsignacion.BackColor = System.Drawing.Color.Aqua;
                Alerta("Atención: Debe escribir el número de Consignación o Cupón de Pago" );
                return;
            }
            txtConsignacion.BackColor = System.Drawing.Color.Empty;

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_FacturaElectronicaSiifXTipoFacturaUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@IdFacturaElectronicaSiifXTipoFactura", SqlDbType.Int).Value = Convert.ToInt32(hfId.Value);
                    cmd.Parameters.Add("@NumeroCuponPago", SqlDbType.Text).Value = txtConsignacion.Text.Trim();
                    cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();

                    Alerta("Listo!!! se Actualizó el Número de la Consignación");
                    GridView1.SelectedIndex = -1;

                    btnGuardar.Enabled = false;
                    txtConsignacion.Enabled = false;
                    txtConsignacion.Text = "";
                    GridView1.DataSource = null;
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                    return;
                }
            }
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            if (GridView2.Rows.Count == 0)
            {
                Alerta("Atención, No Hay Conciliación Siif - Sgarc De Contado");
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
            GridView2.Visible = true;
            GridView2.Caption = "Conciliación_Siif_Sgarc_DeContado" + Session["_NombreCentroFormacion"].ToString(); 
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            GridView2.AllowPaging = false;
            GridView2.AllowSorting = false;
            GridView2.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(GridView2);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "ConciliacionSiif_Sgarc_DeContado.xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            GridView1.Visible = false;
        }

        protected void ExportarTxt()
        {
            try
            {
                string PathArchivo = "ConciliaciónSiif_Sgarc_DeContado" + Session["_NombreCentroFormacion"].ToString()+DateTime.Now.ToShortDateString().Replace("/", "_") + ".txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[CentroFormacion].[Usp_BuscarFacturaElectronicaSiifXTipoFacturaXCentro]";

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
                        Alerta("Atención: No Hay ConciliaciónSiif_Sgarc para su Centro");
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
    }
}