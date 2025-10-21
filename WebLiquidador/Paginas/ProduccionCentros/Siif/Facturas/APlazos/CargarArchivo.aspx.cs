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

namespace WebLiquidador.Paginas.ProduccionCentros.Siif.Facturas.APlazos
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
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
                //// Guardar el centro que está cargando
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[Siif].[Usp_CrearTablasAPlazosDeContado]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@CodigoCentroFormacion", SqlDbType.Text).Value = Session["_CodigoCentroFormacion"].ToString();
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
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

        protected void btnCargarArchivo_Click(object sender, EventArgs e)
        {
            try
            {
                if (!FuCargarArchivo.HasFile)
                {
                    Alerta("Error: Usted aún no a Cargado ningún Archivo");
                    return;
                }
                string SavePath = Server.MapPath("~/Paginas/ProduccionCentros/Siif/Archivos/");
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
                string ssqltable = "[Siif].[APlazos"+ Session["_CodigoCentroFormacion"].ToString()+"]";
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
                        if (excel.Workbook.Worksheets[1].Name.ToString() != "APlazos")
                        {
                            lblNombreArchivo.Text = excel.Workbook.Worksheets[1].Name.ToString();
                            Alerta("Error: El Archivo No es una archivo de Facturas Electrónica A Plazos");
                            return;
                        }

                        var table = ssqltable;
                        using (var conn = new SqlConnection(ssqlconnectionstring))
                        {
                            var bulkCopy = new SqlBulkCopy(conn);
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

                BuscarControlCargue();
                FuCargarArchivo.Enabled = false;
                btnCargarArchivo.Enabled = false;
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
                var Textocmd = "[CentroFormacion].[Usp_BuscarCargueFacturaElectronicaSiifAPlazo]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@CodigoCentro", SqlDbType.Text).Value = Session["_CodigoCentroFormacion"].ToString();

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
                            lblCodigoCentro.Text = reader[4].ToString();
                        }
                        btnEsCorrecto.Visible = true;
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }

            if (lblCodigoCentro.Text != Session["_CodigoCentroFormacion"].ToString())
            {
                Alerta("Atención El Archivo de Factura Electrónica de A Plazo no es de su Centro Formación");
                btnEsCorrecto.Enabled = false;
            }
        }
        
        private void BuscarArchivoBorrar()
        {
            try
            {
                System.IO.File.Delete(Server.MapPath("~/Paginas/ProduccionCentros/Siif/Archivos/" + @FuCargarArchivo.FileName));
            }
            catch (System.IO.IOException ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }
        
        protected void btnEsCorrecto_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_ControlCargueFacturaElectronicaSiifInsert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
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
                    cmd.Parameters.Add("@CodigoCentro", SqlDbType.Text).Value = lblCodigoCentro.Text;
                    cmd.Parameters.Add("@IdTipoFacturaElectrónicaSiif", SqlDbType.Int).Value = 2;
                    cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    int vResultado = 0;
                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
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
                    var Textocmd = "[CentroFormacion].[Usp_ProcesarFacturaElectronicaSiifXTipoFacturaAPlazos]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdUsuario", Convert.ToInt32(Session["_IdUsuario"].ToString()));
                    cmd.Parameters.AddWithValue("@CodigoCentro", SqlDbType.Text).Value = Session["_CodigoCentroFormacion"].ToString();

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                    btnEsCorrecto.Enabled = false;
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                    return;
                }
            }
        }
        
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Siif/Facturas/APlazos/CargarArchivo.aspx", false);
        }
    }
}