using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Data.OleDb;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Presupuesto
{
    public partial class CargarCompromiso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if ((new List<string> { "1", "2", "3", "4", "6", "7", "8", "9" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }
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
                string SavePath = Server.MapPath("~/Paginas/ProduccionCentros/Presupuesto/ArchivosXls/");
                string FileName = FuCargarArchivo.FileName;
                string Extension = System.IO.Path.GetExtension(FileName);
                int fileLen = FuCargarArchivo.PostedFile.ContentLength;

                if (fileLen > 100 * 1024 * 1024)
                {
                    Alerta("El Archivo es muy Grande, Reduzca el Tamaño, Máximo 20MB e Intente de Nuevo");
                    return;
                }

                if (Extension == ".xls" || Extension == ".xlsx")
                {
                    BuscarArchivoBorrar();
                    SavePath += FileName;
                    FuCargarArchivo.SaveAs(SavePath);
                    ImportDataFromExcel(@SavePath.ToString());
                }
                else
                {
                    Alerta("La Extensión del Archivo debe ser .xls o .xlsx");
                    return;
                }
            }
            catch (Exception ex)
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
                    var Textocmd = "[Aportes].[Usp_CrucePseVsCarteraControlInsert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@NombreArchivo", SqlDbType.Text).Value = lblNombreArchivo.Text;
                    //cmd.Parameters.Add("@IdTipoArchivoPse", SqlDbType.Int).Value = Convert.ToInt32(ddlArchivo.SelectedValue);

                    lblRegistros.Text = lblRegistros.Text.Replace(".", "");
                    lblRegistros.Text = lblRegistros.Text.Replace(",", "");
                    cmd.Parameters.Add("@NumeroRegistros", SqlDbType.Int).Value = Convert.ToInt32(lblRegistros.Text);

                    //lblValorTotaldelPago.Text = lblValorTotaldelPago.Text.Replace(".", "");
                    //lblValorTotaldelPago.Text = lblValorTotaldelPago.Text.Replace(",", "");
                    //cmd.Parameters.Add("@ValorTotaldelPago", SqlDbType.Decimal).Value = Convert.ToDecimal(lblValorTotaldelPago.Text);

                    cmd.Parameters.Add("@FechaMinima", SqlDbType.Date).Value = lblFechaMinima.Text;
                    cmd.Parameters.Add("@FechaMaxima", SqlDbType.Date).Value = lblFechaMaxima.Text;

                    cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    int vResultado = 0;
                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();

                    PrepararArchivos();
                    Alerta("Registros Agregados");
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

        protected void PrepararArchivos()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[Aportes].[Usp_PrepararCrucePseVsCartera]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
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
            Response.Redirect("~/Paginas/ProduccionCentros/Presupuesto/CargarCompromiso.aspx", false);
        }

        public void ImportDataFromExcel(string excelFilePath)
        {
            /// LA TABLA DEBE EXISTIR EN LA BD
            string ssqltable = "[CentroFormacion].[CargueCompromiso]";
            // make sure your sheet name is correct, here sheet name is sheet1, so you can change your sheet name if have    different 
            //string myexceldataquery = "Select Nit,PrimerNombreRazonSocial,PrimerApellido,DescripciónServicio,FechaPago,ValorPago,Regional,TicketID,EntidadFinancieraAutorizadora FROM [Hoja1$]";
            string myexceldataquery = "Select * From [Compromiso$]";

            try
            {
                //string sexcelconnectionstring = @"provider=microsoft.jet.oledb.4.0;data source=" + excelFilePath + ";extended properties=" + "\"excel 8.0;hdr=no;\"";
                string sexcelconnectionstring = @"provider=microsoft.ace.oledb.12.0;data source=" + excelFilePath + ";extended properties=" + "\"excel 12.0;hdr=no;\"";
                //"HDR=Yes;" indicates that the first row contains columnnames, not data. "HDR=No;" indicates the opposite.

                var ssqlconnectionstring = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                //execute a query to erase any previous data from our destination table 
                string sclearsql = "Truncate Table " + ssqltable;
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

                try
                {
                    // Write from the source to the destination.
                    while (dr.Read())
                    {
                        bulkcopy.WriteToServer(dr);
                    }
                    dr.Close();
                    oledbconn.Close();
                }
                catch (Exception ex)
                {
                    Alerta("Error: " + ex.Message);
                    return;
                }
                finally
                {
                    // Close the SqlDataReader. The SqlBulkCopy
                    // object is automatically closed at the end
                    // of the using block.
                    oledbconn.Close();
                    dr.Close();
                }
                //BuscarControlCarguePagos();
            }
            catch (Exception ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }

        private void BuscarControlCarguePagos()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[Aportes].[Usp_BuscarCrucePseVsCartera]";
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
                            lblNombreArchivo.Text = @FuCargarArchivo.FileName;
                            lblRegistros.Text = string.Format("{0:###,##0}", Convert.ToDouble(reader[0].ToString()));
                            lblFechaMinima.Text = Convert.ToDateTime(reader[2]).ToShortDateString();
                            lblFechaMaxima.Text = Convert.ToDateTime(reader[3]).ToShortDateString();
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
        }

        private void BuscarArchivoBorrar()
        {
            try
            {
                System.IO.File.Delete(Server.MapPath("~/Paginas/ProduccionCentros/Presupuesto/ArchivosXls/" + @FuCargarArchivo.FileName));
            }
            catch (System.IO.IOException ex)
            {
                Alerta("Error: " + ex.Message);
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
    }
}