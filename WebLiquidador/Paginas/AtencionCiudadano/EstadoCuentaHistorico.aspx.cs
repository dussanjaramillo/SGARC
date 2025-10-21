using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Threading;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using System.Text;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.AtencionCiudadano
{
    public partial class EstadoCuentaHistorico : System.Web.UI.Page
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
                txtIdentificacion.Focus();
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            if (txtIdentificacion.Text == string.Empty)
            {
                Alerta("Error, Falta el Numero de Identificación");
                return;
            }
            txtIdentificacion.Enabled = false;
            btnBuscar.Enabled = false;
        }

        protected void btn_Limpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/AtencionCiudadano/EstadoCuentaHistorico.aspx", false);
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

        protected void btnImprimir_Click(object sender, EventArgs e)
        {
            try
            {
                string PathArchivo = "EstadoCuentaHistoricoAcumulado_" + txtIdentificacion.Text.Trim() + ".txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[dbo].[Usp_Buscar_APOV_LIQRESS_MES]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Convert.ToString(Convert.ToInt64(txtIdentificacion.Text.ToString().Trim()));
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

        protected void grvHistorico_DataBound(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (grvHistorico.Rows.Count == 0)
                {
                    Alerta("Error, La Identificación No Existe");
                    txtIdentificacion.Enabled = true;
                    btnBuscar.Enabled = true;
                }
                else
                {
                    btnImprimir.Visible = true;
                }
            }
        }

    }
}