using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.IO.Compression;
using System.Configuration;
using WebLiquidador.App_Code;
using System.Web.UI.WebControls;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Siif
{
    public partial class CargarArchivoZip : System.Web.UI.Page
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

            if (!(new List<string> { "5" }).Contains(Session["_IdCargo"].ToString()))
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
                string SavePathOrigen = Server.MapPath("~/Paginas/ProduccionCentros/Siif/ArchivosZip/");
                string FileName = FuCargarArchivo.FileName;
                string Extension = System.IO.Path.GetExtension(FileName);
                int fileLen = FuCargarArchivo.PostedFile.ContentLength;

                if (fileLen > 1000 * 1024 * 1024)
                {
                    Alerta("El Archivo es muy Grande, Reduzca el Tamaño, Máximo 1000 MB e Intente de Nuevo");
                    return;
                }

                if (Extension.ToUpper() == ".ZIP")
                {
                    BuscarArchivoBorrar();
                    SavePathOrigen += FileName;
                    FuCargarArchivo.SaveAs(SavePathOrigen);
                    DescomprimirZip(@SavePathOrigen.ToString());
                }
                else
                {
                    Alerta("La Extensión del Archivo debe ser .Zip");
                    return;
                }
            }
            catch (Exception ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }

        public void DescomprimirZip(string ZipFilePathOrigen)
        {
            try
            {
                string SavePathDestino = Server.MapPath("~/Paginas/ProduccionCentros/Siif/Facturas");
                string SavePathDestinoPdf = Server.MapPath("~/Paginas/ProduccionCentros/Siif/FacturaPdf/");
                ZipFile.ExtractToDirectory(ZipFilePathOrigen, SavePathDestino);
                string[] allfiles = Directory.GetFiles(Server.MapPath("~/Paginas/ProduccionCentros/Siif/Facturas"), "*.*", SearchOption.AllDirectories);

                List<FacturaSiif> listFactura = new List<FacturaSiif>();

                foreach (var file in allfiles)
                {
                    string _CodigoCentro = "";
                    string _NombreArchivo = "";
                    Int32 _NumeroFactura = 0;

                    FileInfo info = new FileInfo(file);

                    _NumeroFactura = Convert.ToInt32(info.DirectoryName.Split('.')[1].Trim());
                    _CodigoCentro = info.DirectoryName.Split('.')[1].Trim().Substring(0, 4);
                    _NombreArchivo = Convert.ToString(_NumeroFactura) + "-"+ info.Name;

                    listFactura.Add(new FacturaSiif { NumeroFactura = _NumeroFactura, CodigoCentro = _CodigoCentro, NombreArchivo = _NombreArchivo });
                    string PathFull = info.FullName;
                    File.Copy(PathFull, SavePathDestinoPdf + _NombreArchivo, true);
                }
                grvFacturasSiif.DataSource = listFactura;
                grvFacturasSiif.DataBind();
                grvFacturasSiif.Visible = false;

                lblNombreArchivo.Text = @FuCargarArchivo.FileName;
                lblRegistros.Text = string.Format("{0:###,##0}", Convert.ToDouble(listFactura.Count));

                btnEsCorrecto.Visible = true;
            }

            catch (Exception ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }
        }

        private void BuscarArchivoBorrar()
        {
            try
            {
                System.IO.File.Delete(Server.MapPath("~/Paginas/ProduccionCentros/Siif/ArchivosZip/" + @FuCargarArchivo.FileName));
                System.IO.Directory.Delete(Server.MapPath("~/Paginas/ProduccionCentros/Siif/Facturas/"), true);
                // FileSystemWatcher
            }
            catch (System.IO.IOException ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }

        protected void btnEsCorrecto_Click(object sender, EventArgs e)
        {
            Grabar_FacturaPdf();
            ControlArchivo(Convert.ToInt32(lblRegistros.Text));
        }

        private void ControlArchivo(int Registros)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_ControlCargueArchivoZipInsert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Archivo", @FuCargarArchivo.FileName.ToString());
                    cmd.Parameters.AddWithValue("@Registros", Registros);
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

        protected void Grabar_FacturaPdf()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_FacturaElectronicaSiiffInsert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();

                    foreach (GridViewRow row in grvFacturasSiif.Rows)
                    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("@NumeroFactura", SqlDbType.Int).Value = Convert.ToInt64(row.Cells[0].Text);
                        cmd.Parameters.Add("@CodigoCentroFormacion", SqlDbType.Int).Value = row.Cells[1].Text;
                        cmd.Parameters.Add("@NombreArchivo", SqlDbType.Text).Value = row.Cells[2].Text;
                        cmd.ExecuteNonQuery();
                    }
                    con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                    return;
                }
            }
            Alerta("Listo!!!  Facturas Electrónicas Siif Guardadas");
            btnEsCorrecto.Visible = false;
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Siif/CargarArchivoZip.aspx", false);
        }
    }
}