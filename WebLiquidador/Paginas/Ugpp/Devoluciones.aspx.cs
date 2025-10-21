using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebLiquidador.Paginas.Ugpp
{
    public partial class Devoluciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            //Cargos
            //1   01  Coordinador
            //2   02  Abogado
            //3   03  Fiscalizador
            //4   04  Técnico
            //5   05  Administrador
            //6   06  Profesional
            //7   07  Siif - Nación
            //8   08  Subdirector
            //9   09  Producción
            //10  10  Control Interno
            if (!(new List<string> { "5" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/Default.aspx");
            }

            if (!IsPostBack)
            {
                txtFechaInicial.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtFechaFinal.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            try
            {
                string PathArchivo = "SENA_PASENA_1004_" + txtFechaInicial.Text.ToString() + "_" + txtFechaFinal.Text.ToString() + "_Devoluciones.txt";
                //string PathArchivo = "4500_899999034_" + txtFechaInicial.Text.ToString()+ ".str";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[Ugpp].[Usp_BuscarDevoluciones]";

                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@FechaInicial", txtFechaInicial.Text.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@FechaFinal", txtFechaFinal.Text.ToString()));
                    cmd.CommandTimeout = 0;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    con.Close();

                    if (dt.Rows.Count > 0)
                    {
                        StringBuilder sb = new StringBuilder();
                        IEnumerable<string> columnNames = dt.Columns.Cast<DataColumn>().Select(column => column.ColumnName);
                        if (ddlEncabezado.SelectedValue == "Si")
                        {
                            sb.AppendLine(string.Join("|", columnNames));
                        }

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
                        Alerta("Atención: No Hay Registros");
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

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            btnExportar.Enabled = true;
        }

        protected void btn_Limpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/Ugpp/Devoluciones.aspx", false);
        }
    }
}