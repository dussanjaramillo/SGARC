using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebLiquidador.App_Code;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Globalization;
using System.Threading;
using System.IO;
using System.Text;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.Ugpp
{
    public partial class LiquidacionesPresuntas : System.Web.UI.Page
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
                ddlMesEntrega.Items.Insert(0, new ListItem("Seleccione...", "-1"));
            }
        }

        protected void btnLiquidacionesPresuntas_Click(object sender, EventArgs e)
        {
            try
            {
                string PathArchivo = "SENA_PASENA_" + ddlSegundaFecha.SelectedValue.Substring(0, 4) + "_" + ddlSegundaFecha.SelectedValue.Substring(4, 2) + "_DECRETO_3033.txt";

                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[dbo].[Usp_Genera_NuevasLiquidacionesUGPP]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandTimeout = 0; 
                    //cmd.Parameters.Add(new SqlParameter("@Fecha1", ddlPrimeraFecha.Text.ToString()));
                    //cmd.Parameters.Add(new SqlParameter("@Fecha2", ddlSegundaFecha.Text.Trim()));
                    
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    con.Close();

                    if (dt.Rows.Count > 0)
                    {
                        StringBuilder sb = new StringBuilder();
                        IEnumerable<string> columnNames = dt.Columns.Cast<DataColumn>().Select(column => column.ColumnName);
                        //sb.AppendLine(string.Join("|", columnNames));

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
                        Alerta("Alerta: No hay Registros de Liquidaciones Presuntas" );
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

        protected void ddlSegundaFecha_DataBound(object sender, EventArgs e)
        {
            ddlSegundaFecha.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlSegundaFecha_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (ddlPrimeraFecha.SelectedValue == "-1")
            //{
            //    Alerta("Error, Aún no ha Seleccionado la Primera Fecha");
            //    ddlPrimeraFecha.Focus();
            //    return;
            //}

            //if (ddlPrimeraFecha.SelectedValue == ddlSegundaFecha.SelectedValue)
            //{
            //    Alerta("Error, la Primera Fecha es Igual a la Segunda Fecha");
            //    ddlPrimeraFecha.Focus();
            //    return;
            //}
            btnLiquidacionesPresuntas.Visible = true; 
        }

        protected void ddlPrimeraFecha_DataBound(object sender, EventArgs e)
        {
            ddlPrimeraFecha.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnFichaControl_Click(object sender, EventArgs e)
        {
            try
            {
                ddlMesEntrega.Enabled = false;
                string PathArchivo = "FICHACONTROL_SENA_PASENA_" + DateTime.Now.ToString("yyyy") + "_" + ddlMesEntrega.SelectedValue.Substring(0, 2) + "_DECRETO_3033.txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[dbo].[Usp_FichaControlDECRETO_3033]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add(new SqlParameter("@Periodo", ddlSegundaFecha.SelectedValue));
                    cmd.Parameters.Add(new SqlParameter("@MesEntrega", DateTime.Now.ToString("yyyy") + "_" + ddlMesEntrega.SelectedValue.Substring(0, 2) + "_DECRETO_3033.txt"));

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    con.Close();

                    if (dt.Rows.Count > 0)
                    {
                        StringBuilder sb = new StringBuilder();
                        //IEnumerable<string> columnNames = dt.Columns.Cast<DataColumn>().Select(column => column.ColumnName);
                        //sb.AppendLine(string.Join("|", columnNames));

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