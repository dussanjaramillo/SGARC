using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Wompi
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

            if (!(new List<string> { "4","5" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
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
                string SavePath = Server.MapPath("~/Paginas/ProduccionCentros/Wompi/Archivos/");
                string FileName = FuCargarArchivo.FileName;
                string Extension = System.IO.Path.GetExtension(FileName);
                int fileLen = FuCargarArchivo.PostedFile.ContentLength;

                if (fileLen > 20 * 1024 * 1024)
                {
                    Alerta("El Archivo es muy Grande, Reduzca el Tamaño, Máximo 20MB e Intente de Nuevo");
                    return;
                }

                if (Extension.ToLower() == ".csv")
                {
                    BuscarArchivoBorrar();
                    SavePath += FileName;
                    FuCargarArchivo.SaveAs(SavePath);
                    ImportDataFromCsv(@SavePath.ToString());
                }
                else
                {
                    Alerta("La Extensión del Archivo debe ser .csv");
                    return;
                }
            }
            catch (Exception ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }

        private void BuscarExisteArchivo()
        {
            lblNombreArchivo.Text = "";
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[Wompi].[Usp_BuscarArchivoPagosWompi]";
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
                            lblNombreArchivo.Text = reader[0].ToString();
                        }
                        btnEsCorrecto.Visible = false;
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        public void ImportDataFromCsv(string CsvFilePath)
        {
            // Establece si el archivo Existe 

            BuscarExisteArchivo();
            if (lblNombreArchivo.Text == FuCargarArchivo.PostedFile.FileName)
            {
                Alerta("Atención!!!! el Archivo "+ lblNombreArchivo.Text + " Ya está Cargado");
                lblNombreArchivo.Text = "";
                return;
            }

            try
            {
                /// LA TABLA DEBE EXISTIR EN LA BD
                string ssqltable = "[Wompi].[CuponPagoCargueWompi]";
                var ssqlconnectionstring = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                //execute a query to erase any previous data from our destination table 
                string sclearsql = "Truncate Table " + ssqltable;
                SqlConnection sqlconn = new SqlConnection(ssqlconnectionstring);
                SqlCommand sqlcmd = new SqlCommand(sclearsql, sqlconn);
                sqlconn.Open();
                sqlcmd.ExecuteNonQuery();
                sqlconn.Close();

                //Upload and save the file.
                string csvPath = Server.MapPath("~/Paginas/ProduccionCentros/Wompi/Archivos/") + Path.GetFileName(FuCargarArchivo.PostedFile.FileName);

                FuCargarArchivo.SaveAs(csvPath);

                DataTable dt = new DataTable();
                dt.Columns.AddRange(new DataColumn[19] { new DataColumn("Id de la transaccion", typeof(string)),
                    new DataColumn("Fecha", typeof(string)),
                    new DataColumn("Referencia", typeof(string)),
                    new DataColumn("Monto", typeof(string)),
                    new DataColumn("IVA", typeof(string)),
                    new DataColumn("Impuesto al consumo", typeof(string)),
                    new DataColumn("Moneda", typeof(string)),
                    new DataColumn("Medio de pago", typeof(string)),
                    new DataColumn("Email del pagador", typeof(string)),
                    new DataColumn("Nombre del pagador", typeof(string)),
                    new DataColumn("Telefono del pagador", typeof(string)),
                    new DataColumn("Id conciliacion", typeof(string)),
                    new DataColumn("Id link de pago", typeof(string)),
                    new DataColumn("Documento del pagador", typeof(string)),
                    new DataColumn("Tipo de documento del pagador", typeof(string)),
                    new DataColumn("Ref. 1 Nombre", typeof(string)),
                    new DataColumn("Ref. 1", typeof(string)),
                    new DataColumn("Ref. 2 Nombre", typeof(string)),
                    new DataColumn("Ref. 2",typeof(string)) });

                string csvData = File.ReadAllText(csvPath);
                foreach (string row in csvData.Split('\n'))
                {
                    if (!string.IsNullOrEmpty(row))
                    {
                        dt.Rows.Add();
                        int i = 0;
                        foreach (string cell in row.Split(','))
                        {
                            dt.Rows[dt.Rows.Count - 1][i] = cell;
                            i++;
                        }
                    }
                }

                string consString = ConfigurationManager.ConnectionStrings["CentroFormacion"].ConnectionString;
                using (SqlConnection con = new SqlConnection(consString))
                {
                    using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                    {
                        //Set the database table name.
                        sqlBulkCopy.DestinationTableName = "[Wompi].[CuponPagoCargueWompi]";
                        con.Open();
                        sqlBulkCopy.WriteToServer(dt);
                        con.Close();
                    }
                }

                BuscarControlCarguePagos();
                FuCargarArchivo.Enabled = false;
                ddlTipoIngreso.Enabled = false;
                btnCargarArchivo.Enabled = false;
            }
            catch (Exception ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }
        }

        private void BuscarControlCarguePagos()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[Wompi].[Usp_BuscarControlCarguePagosWompi]";
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
                            lblRegistros.Text = string.Format("{0:##,###,###,##0}", Convert.ToDouble(reader[0].ToString()));
                            lblValorTotaldelPago.Text = string.Format("{0:##,###,###,##0.00}", Convert.ToDouble(reader[1].ToString()));
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
                System.IO.File.Delete(Server.MapPath("~/Paginas/ProduccionCentros/Wompi/Archivos/" + @FuCargarArchivo.FileName));
            }
            catch (System.IO.IOException ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }

        protected void btnEsCorrecto_Click(object sender, EventArgs e)
        {
            vResultadoError = 0;
            ProcesarCuponPagoWompi();
            if (vResultadoError == 1)
            {
                Alerta("Error en el Codigo del Centro en el Archivo "+ lblNombreArchivo.Text);
                btnEsCorrecto.Text = "Error en el Codigo del Centro";
                return;
            }

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[Wompi].[Usp_ControlCarguePagosWompiInsert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@NombreArchivo", SqlDbType.Text).Value = lblNombreArchivo.Text;

                    lblRegistros.Text = lblRegistros.Text.Replace(".", "");
                    lblRegistros.Text = lblRegistros.Text.Replace(",", "");
                    cmd.Parameters.Add("@NumeroRegistros", SqlDbType.Int).Value = Convert.ToInt32(lblRegistros.Text);

                    //lblValorTotaldelPago.Text = lblValorTotaldelPago.Text.Replace(".", "");
                    //lblValorTotaldelPago.Text = lblValorTotaldelPago.Text.Replace(",", "");
                    cmd.Parameters.Add("@ValorTotaldelPago", SqlDbType.Decimal).Value = Convert.ToDecimal(lblValorTotaldelPago.Text);

                    cmd.Parameters.Add("@FechaMinima", SqlDbType.Date).Value = lblFechaMinima.Text;
                    cmd.Parameters.Add("@FechaMaxima", SqlDbType.Date).Value = lblFechaMaxima.Text;

                    cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    int vResultado = 0;
                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();

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

        int vResultadoError;
        protected void ProcesarCuponPagoWompi()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    vResultadoError = 0;
                    var Textocmd = "[Wompi].[Usp_ProcesarCuponPagoWompi]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    //cmd.Parameters.AddWithValue("@IdUsuario", Convert.ToInt32(Session["_IdUsuario"].ToString()));

                    SqlParameter outputIdParam = new SqlParameter("@ErrorCodigo", SqlDbType.Int) { Direction = ParameterDirection.Output };
                    cmd.Parameters.Add(outputIdParam);
                    cmd.Parameters.AddWithValue("@IdTipoIngreso", Convert.ToInt32(ddlTipoIngreso.SelectedValue));
                    con.Open();
                    cmd.ExecuteNonQuery();
                    vResultadoError = Convert.ToInt32(cmd.Parameters["@ErrorCodigo"].Value);
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
            Response.Redirect("~/Paginas/ProduccionCentros/Wompi/CargarArchivo.aspx", false);
        }

        protected void ddlTipoIngreso_DataBound(object sender, EventArgs e)
        {
            ddlTipoIngreso.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }
    
    }
}