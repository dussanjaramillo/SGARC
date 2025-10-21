using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Data.OleDb;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.DireccionGeneral
{
    public partial class EstadoPagosCarteraMasivo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }
        }

        private void BuscarArchivoBorrar()
        {
            System.IO.File.Delete(Server.MapPath("~/Paginas/DireccionGeneral/ArchivosXls/" + @FuCargarArchivo.FileName));
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
            Response.Redirect("~/Paginas/DireccionGeneral/EstadoPagosCarteraMasivo.aspx", false);
        }

        protected void btnCargarArchivo_Click(object sender, EventArgs e)
        {
            try
            {
                if (!FuCargarArchivo.HasFile)
                {
                    Alerta("Error: Usted aún no a Cargado ningún Archivo");
                    return;
                }
                string SavePath = Server.MapPath("~/Paginas/DireccionGeneral/ArchivosXls/");
                string FileName = FuCargarArchivo.FileName;
                string Extension = System.IO.Path.GetExtension(FileName);
                int fileLen = FuCargarArchivo.PostedFile.ContentLength;

                if (fileLen > 20 * 1024 * 1024)
                {
                    Alerta("ATENCIÓN: El Archivo es muy Grande, Reduzca el Tamaño, Máximo 20MB e Intente de Nuevo");
                    return;
                }

                if (Extension == ".xls" || Extension == ".XLS")
                {
                    BuscarArchivoBorrar();
                    SavePath += FileName;
                    FuCargarArchivo.SaveAs(SavePath);

                    Session["_NombreArchivo"] = @FuCargarArchivo.FileName;
                    Session["_PathArchivo"] = @SavePath;
                    btnGenerar.Enabled = true;
                    Alerta("ATENCIÓN: El Archivo " + FileName + ", fue Grabado Exitosamente");
                    btnCargarArchivo.Enabled = false;
                }
                else
                {
                    Alerta("ATENCIÓN: La Extensión del Archivo " + FileName + ", debe ser .xls");
                    return;
                }
            }
            catch (Exception ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            grvEstadoPagosCarteraLicitacion.Visible = true;  
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvEstadoPagosCarteraLicitacion.AllowPaging = false;
            grvEstadoPagosCarteraLicitacion.AllowSorting = false;
            grvEstadoPagosCarteraLicitacion.DataBind();
            grvEstadoPagosCarteraLicitacion.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvEstadoPagosCarteraLicitacion);

            page.RenderControl(htw);

            if (sb.Length > 0)
            {
                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("Content-Disposition", "attachment;filename=" + "EstadoPagosCarteraMasivo.xls");
                Response.Charset = "UTF-8";
                Response.ContentEncoding = System.Text.Encoding.Default;
                Response.Write(sb.ToString());
                Response.End();
            }
            else
            {
                Alerta("Alerta: No Hay Registros");
                return;
            }
            grvEstadoPagosCarteraLicitacion.Visible = false; 
        }

        protected void btnGenerar_Click(object sender, EventArgs e)
        {
            string excelFilePath = Session["_PathArchivo"].ToString();
            /// LA TABLA DEBE EXISTIR EN LA BD
            string ssqltable = "EstadoPagosCarteraNit";
            // make sure your sheet name is correct, here sheet name is sheet1, so you can change your sheet name if have    different 
            //string myexceldataquery = "Select Nit,PrimerNombreRazonSocial,PrimerApellido,DescripciónServicio,FechaPago,ValorPago,Regional,TicketID,EntidadFinancieraAutorizadora FROM [Hoja1$]";
            string myexceldataquery = "Select * FROM [Hoja1$]";

            try
            {
                //string sexcelconnectionstring = @"provider=microsoft.jet.oledb.4.0;data source=" + excelFilePath + ";extended properties=" + "\"excel 8.0;hdr=no;\"";
                string sexcelconnectionstring = @"provider=microsoft.ace.oledb.12.0;data source=" + excelFilePath + ";extended properties=" + "\"excel 12.0;hdr=no;\"";
                var ssqlconnectionstring = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                //execute a query to erase any previous data from our destination table 
                string sclearsql = "Delete From " + ssqltable;
                SqlConnection sqlconn = new SqlConnection(ssqlconnectionstring);
                SqlCommand sqlcmd = new SqlCommand(sclearsql, sqlconn);
                sqlconn.Open();
                sqlcmd.ExecuteNonQuery();
                sqlconn.Close();

                //series of commands to bulk copy data from the excel file into our sql table 
                OleDbConnection oledbconn = new OleDbConnection(sexcelconnectionstring);
                OleDbCommand oledbcmd = new OleDbCommand(myexceldataquery, oledbconn);
                oledbconn.Open();
                OleDbDataReader dr = oledbcmd.ExecuteReader();
                SqlBulkCopy bulkcopy = new SqlBulkCopy(ssqlconnectionstring);
                bulkcopy.DestinationTableName = ssqltable;

                while (dr.Read())
                {
                    bulkcopy.WriteToServer(dr);
                }

                dr.Close();
                oledbconn.Close();

                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    int vResultado;
                    var Textocmd = "[dbo].[Usp_EstadoPagosCarteraLicitacion]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();
                    cmd.CommandTimeout = 0;
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                    Alerta("Alerta: Proceso Terminado para el Archivo: " + Session["_NombreArchivo"].ToString());
                    btnExportar.Enabled = true;
                    btnCargarArchivo.Enabled = false;
                    btnGenerar.Enabled = false;
                    FuCargarArchivo.Enabled = false;
                }
            }
            catch (Exception ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }
    }
}