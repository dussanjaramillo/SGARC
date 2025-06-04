using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Globalization;
using System.Threading;
using System.IO;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.GerentePublico
{
    public partial class Cargar : System.Web.UI.Page
    {
        string carpeta;
        string Mensaje;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if (!(new List<string> { "1", "639" }).Contains(Session["_IdUsuario"].ToString()))
            {
                Response.Redirect("~/Default.aspx");
            }

            carpeta = Path.Combine(Request.PhysicalApplicationPath, "Paginas/ProduccionCentros/GerentePublico/Archivos");
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
                //VERIFICAR SI SE SELECCIONO UN ARCHIVO
                else
                {
                    //VERIFICAR LA EXTENSION
                    string extension = Path.GetExtension(FuCargarArchivo.PostedFile.FileName);
                    switch (extension.ToLower())
                    {
                        //validas
                        case ".xls":
                        case ".xlsx":
                        case ".pdf":
                            break;

                        //no validas
                        default:
                            Alerta("La Extensión del Archivo debe ser .xlsx, xls o .pdf");
                            FuCargarArchivo.Focus();
                            return;
                    }

                    //VERIFICA LA EXISTENCIA 
                    Mensaje = " Copiado Correctamente";
                    hfExiste.Value = "No";
                    BuscarArchivo();

                    int fileLen = FuCargarArchivo.PostedFile.ContentLength;
                    if (fileLen > 20 * 1024 * 1024)
                    {
                        Alerta("El Archivo es muy Grande, Reduzca el Tamaño, Máximo 20MB e Intente de Nuevo");
                        return;
                    }
                    CopiarArchivo();
                }
            }
            catch (Exception ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }


        private void CopiarArchivo()
        {
            //COPIAR EL ARCHIVO
            try
            {
                string archivo = Path.GetFileName(FuCargarArchivo.PostedFile.FileName);

                //NOMBRE DEL ARCHIVO
                string carpeta_final = Path.Combine(carpeta, archivo);
                FuCargarArchivo.PostedFile.SaveAs(carpeta_final);

                GrabarArchivo();

                Alerta("Archivo: " + archivo + Mensaje);
            }
            catch (Exception ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }

        private void BuscarArchivo()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_ControlGerentePublicoBuscarXNombreArchivo]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@NombreArchivo", SqlDbType.Text).Value = FuCargarArchivo.FileName;
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfId.Value = reader[0].ToString();
                            hfExiste.Value = reader[1].ToString();
                        }
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }


        private void GrabarArchivo()
        {
            if (hfExiste.Value == "Si")
            {
                Actualizar();
                Mensaje = " Actualizado Correctamente";
                return;
            }

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_ControlGerentePublicoInsert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@NombreArchivo", SqlDbType.Text).Value = @FuCargarArchivo.FileName.ToString();
                    cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());
                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();

                    GridView1.DataSource = null;
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
            Response.Redirect("~/Paginas/ProduccionCentros/GerentePublico/Cargar.aspx", false);
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            Actualizar();
        }

        private void Actualizar()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_ControlGerentePublicoUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdControlGerentePublico", SqlDbType.Int).Value = Convert.ToInt32(hfId.Value);
                    cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());
                    if (chbEsActivo.Checked)
                    { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true; }
                    else
                    { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false; }

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();

                    GridView1.DataSource = null;
                    GridView1.SelectedIndex = -1;
                    btnActualizar.Enabled = false;
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                    return;
                }
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfId.Value = GridView1.SelectedRow.Cells[1].Text;
            btnActualizar.Enabled = true;
        }
    }
}