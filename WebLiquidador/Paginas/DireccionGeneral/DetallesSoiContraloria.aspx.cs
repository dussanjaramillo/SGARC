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

namespace WebLiquidador.Paginas.DireccionGeneral
{
    public partial class DetallesSoiContraloria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                txtFechaInicial.Focus();
                CargarDatos();
            }
        }

        private void CargarDatos()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_BuscaControlSoiContraloria]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            txtFechaInicial.Text = reader[0].ToString();
                            txtFechaFinal.Text = reader[1].ToString();
                            txtDocumentoCausacion.Text = reader[2].ToString();
                            txtDocumentoRecaudo.Text = reader[3].ToString();
                            txtMensaje.Text = reader[4].ToString();
                            hdfEstado.Value = reader[5].ToString();
                        }
                        con.Close();

                        if (hdfEstado.Value == "0")
                        {
                            btnExportar.Enabled = true;
                            txtFechaInicial.Enabled = true;
                            txtFechaFinal.Enabled = true;
                            txtDocumentoCausacion.Enabled = true;
                            txtDocumentoRecaudo.Enabled = true;
                           
                            txtFechaInicial.Text = "";
                            txtFechaFinal.Text = "";
                            txtDocumentoCausacion.Text = "";
                            txtDocumentoRecaudo.Text = "";

                            txtFechaInicial.Focus();
                            btnExportar.Enabled = true;
                        }

                        if (hdfEstado.Value == "1")
                        {
                            txtFechaInicial.Enabled = false;
                            txtFechaFinal.Enabled = false;
                            txtDocumentoCausacion.Enabled = false;
                            txtDocumentoRecaudo.Enabled = false;
                            btnExportar.Enabled = false;
                            btnImprimir.Enabled = false;
                            ddlRegional.Enabled = false;
                        }

                        if (hdfEstado.Value == "2")
                        {
                            txtFechaInicial.Enabled = false;
                            txtFechaFinal.Enabled = false;
                            txtDocumentoCausacion.Enabled = false;
                            txtDocumentoRecaudo.Enabled = false;
                            btnExportar.Enabled = false;
                        }

                        if (hdfEstado.Value == "3")
                        {
                            txtFechaInicial.Enabled = true;
                            txtFechaFinal.Enabled = true;
                            txtDocumentoCausacion.Enabled = true;
                            txtDocumentoRecaudo.Enabled = true;

                            //txtFechaInicial.Text = "";
                            //txtFechaFinal.Text = "";
                            //txtDocumentoCausacion.Text = "";
                            //txtDocumentoRecaudo.Text = "";

                            btnExportar.Enabled = false;
                            btnImprimir.Enabled = true;
                            ddlRegional.Enabled = true;
                        }
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }

            }
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            if (Convert.ToDecimal(txtFechaInicial.Text) > Convert.ToDecimal(txtFechaFinal.Text))
            {
                Alerta("Error: en la Fecha Inicial");
                btnExportar.Enabled = false;
                txtFechaInicial.Focus();
                return;
            }
            btnExportar.Enabled = false;
            txtFechaInicial.Enabled = false;
            txtFechaFinal.Enabled = false;
            txtDocumentoCausacion.Enabled = false;
            txtDocumentoRecaudo.Enabled = false;
            ControlSoiContraloria();
            IniciarEjecutarSoiContraloria();
        }

        private void IniciarEjecutarSoiContraloria()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    //var FechaInicio = System.DateTime.Now;
                    //FechaInicio = FechaInicio.AddMinutes(2);
                    //var HoraInicio = FechaInicio.ToString("HHmmss");

                    int vResultado;
                    var Textocmd = "[dbo].[Usp_IniciarEjecutarSoiContraloria]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                    return;
                }
            }
        }

        private void ControlSoiContraloria()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[dbo].[Usp_ControlSoiContraloria]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@FechaInicial", txtFechaInicial.Text.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@FechaFinal", txtFechaFinal.Text.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@DocumentoCausacion", txtDocumentoCausacion.Text.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@DocumentoRecaudo", txtDocumentoRecaudo.Text.ToString()));

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                    return;
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
            Response.Redirect("~/Paginas/DireccionGeneral/DetallesSoiContraloria.aspx", false);
        }

        protected void txtDocumentoRecaudo_TextChanged(object sender, EventArgs e)
        {
            btnExportar.Enabled = true;
        }

        protected void btnImprimir_Click(object sender, EventArgs e)
        {
            try
            {
                string PathArchivo = "DetallesSoiContraloria_" + ddlRegional.SelectedItem + "_" + txtFechaInicial.Text.Trim() + "_" + txtFechaFinal.Text.Trim() + ".txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[dbo].[Usp_BuscarDetallesSoiContraloria]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@Departamento", ddlRegional.SelectedValue));


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
                         Alerta("Alerta: No Hay Registros");
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

        protected void ddlRegional_DataBound(object sender, EventArgs e)
        {
            ddlRegional.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }
    }
}