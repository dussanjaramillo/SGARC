using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using OfficeOpenXml;
using System.IO;
using WebLiquidador.App_Code;


//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.CostasProcesales.Pagos
{
    public partial class CargarArchivo : System.Web.UI.Page
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

            //if ((new List<string> { "1", "2", "3", "4", "6", "7", "8", "9" }).Contains(Session["_IdCargo"].ToString()))
            //{
            //    Response.Redirect("~/DefaultCf.aspx");
            //}

            if (!IsPostBack)
            {
               

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

        protected void BtnCargarArchivo_Click(object sender, EventArgs e)
        {
            try
            {
                if (!FuCargarArchivo.HasFile)
                {
                    Alerta("Error: Usted aún no a Cargado ningún Archivo");
                    return;
                }
                string SavePath = Server.MapPath("~/Paginas/CostasProcesales/Pagos/Archivos/");
                string FileName = FuCargarArchivo.FileName;
                string Extension = System.IO.Path.GetExtension(FileName);
                int fileLen = FuCargarArchivo.PostedFile.ContentLength;

                if (fileLen > 20 * 1024 * 1024)
                {
                    Alerta("El Archivo es muy Grande, Reduzca el Tamaño, Máximo 20MB e Intente de Nuevo");
                    return;
                }

                if (Extension == ".xlsx")
                {
                    BuscarArchivoBorrar();
                    SavePath += FileName;
                    FuCargarArchivo.SaveAs(SavePath);
                    ImportDataFromExcel(@SavePath.ToString());
                }
                else
                {
                    Alerta("La Extensión del Archivo debe ser .xlsx");
                    return;
                }
            }
            catch (Exception ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }

        public void ImportDataFromExcel(string excelFilePath)
        {
            try
            {
                var ssqlconnectionstring = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                /// LA TABLA DEBE EXISTIR EN LA BD
                string ssqltable = "[CostasProcesales].[CarguePagosCostasProcesales]";
                string sexcelconnectionstring = @"provider=microsoft.ace.oledb.12.0;data source=" + excelFilePath + ";extended properties=" + "\"excel 12.0;hdr=no;\"";

                //execute a query to erase any previous data from our destination table 
                string sclearsql = "Truncate Table " + ssqltable;
                SqlConnection sqlconn = new SqlConnection(ssqlconnectionstring);
                SqlCommand sqlcmd = new SqlCommand(sclearsql, sqlconn);
                sqlconn.Open();
                sqlcmd.ExecuteNonQuery();
                sqlconn.Close();

                if (IsPostBack && FuCargarArchivo.HasFile)
                {
                    if (Path.GetExtension(FuCargarArchivo.FileName).Equals(".xlsx"))
                    {
                        var excel = new ExcelPackage(FuCargarArchivo.FileContent);
                        var dt = excel.ToDataTable();
                        if (excel.Workbook.Worksheets[1].Name.ToString() != "CostasProcesales")
                        {
                            lblNombreArchivo.Text = excel.Workbook.Worksheets[1].Name.ToString();
                            Alerta("Error: El Archivo No es de Pagos de Costas Procesales");
                            return;
                        }

                        var table = ssqltable;
                        using (var conn = new SqlConnection(ssqlconnectionstring))
                        {
                            using (var bulkCopy = new SqlBulkCopy(conn))
                            {
                                bulkCopy.DestinationTableName = table;
                                conn.Open();
                                var schema = conn.GetSchema("Columns", new[] { null, null, table, null });
                                foreach (DataColumn sourceColumn in dt.Columns)
                                {
                                    foreach (DataRow row in schema.Rows)
                                    {
                                        if (string.Equals(sourceColumn.ColumnName, (string)row["COLUMN_NAME"], StringComparison.OrdinalIgnoreCase))
                                        {
                                            bulkCopy.ColumnMappings.Add(sourceColumn.ColumnName, (string)row["COLUMN_NAME"]);
                                            break;
                                        }
                                    }
                                }
                                bulkCopy.WriteToServer(dt);
                            }
                        }
                    }
                }

                BuscarControlCargue();
                FuCargarArchivo.Enabled = false;
                BtnCargarArchivo.Enabled = false;
            }
            catch (Exception ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }
        }
        
        private void BuscarControlCargue()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CostasProcesales].[Usp_BuscarCarguePagosCostasProcesales]";
                using (SqlCommand cmd = new SqlCommand(Textocmd, con))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    try
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                lblNombreArchivo.Text = @FuCargarArchivo.FileName;
                                lblRegistros.Text = string.Format("{0:##,###,###,##0}", Convert.ToDouble(reader[0].ToString()));
                                lblValorTotaldelPago.Text = string.Format("{0:##,###,###,##0}", Convert.ToDouble(reader[1].ToString()));
                                lblFechaMinima.Text = Convert.ToDateTime(reader[2]).ToShortDateString();
                                lblFechaMaxima.Text = Convert.ToDateTime(reader[3]).ToShortDateString();
                            }
                            BtnEsCorrecto.Visible = true;
                            con.Close();
                        }
                    }
                    catch (SqlException ex)
                    {
                        Alerta("Error: " + ex.Message);
                    }
                }
            }


        }
        
        private void BuscarArchivoBorrar()
        {
            try
            {
                System.IO.File.Delete(Server.MapPath("~/Paginas/CostasProcesales/Pagos/Archivos/" + @FuCargarArchivo.FileName));
            }
            catch (System.IO.IOException ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }
        
        protected void BtnEsCorrecto_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CostasProcesales].[Usp_ControlCarguePagosCostasProcesalesInsert]";
                    using (SqlCommand cmd = new SqlCommand(Textocmd, con))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@NombreArchivo", SqlDbType.Text).Value = lblNombreArchivo.Text;
                        lblRegistros.Text = lblRegistros.Text.Replace(".", "");
                        lblRegistros.Text = lblRegistros.Text.Replace(",", "");
                        cmd.Parameters.Add("@NumeroRegistros", SqlDbType.Int).Value = Convert.ToInt32(lblRegistros.Text);
                        lblValorTotaldelPago.Text = lblValorTotaldelPago.Text.Replace(".", "");
                        lblValorTotaldelPago.Text = lblValorTotaldelPago.Text.Replace(",", "");
                        cmd.Parameters.Add("@ValorTotaldelPago", SqlDbType.BigInt).Value = Convert.ToInt64(lblValorTotaldelPago.Text);
                        cmd.Parameters.Add("@FechaMinima", SqlDbType.Date).Value = lblFechaMinima.Text;
                        cmd.Parameters.Add("@FechaMaxima", SqlDbType.Date).Value = lblFechaMaxima.Text;
                        cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        int vResultado = 0;
                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                    }

                    con.Close();

                    ProcesarRegistros();

                    Alerta("Registros Agregados y Procesados");
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 2627)
                    {
                        //Alerta("Error: El Codigo y/o la Identificacion del Usuario ya Existe");
                        Alerta("Error: " + ex.Message.ToString());
                        return;
                    }
                    Alerta("Error: " + ex.Message.ToString());
                }
            }
        }
        
        protected void ProcesarRegistros()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CostasProcesales].[Usp_ProcesarPagosCostasProcesales]";
                    using (SqlCommand cmd = new SqlCommand(Textocmd, con))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@IdUsuario", Convert.ToInt32(Session["_IdUsuario"].ToString()));
                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                    }

                    con.Close();
                    BtnEsCorrecto.Enabled = false;
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                    return;
                }
            }
        }
        
        protected void BtnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/CostasProcesales/Pagos/CargarArchivo.aspx", false);
        }
    }
}