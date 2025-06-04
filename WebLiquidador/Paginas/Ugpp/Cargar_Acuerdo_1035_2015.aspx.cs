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

namespace WebLiquidador.Paginas.Ugpp
{
    public partial class Cargar_Acuerdo_1035_2015 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if (!(new List<string> { "5" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/Default.aspx");
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
                string SavePath = Server.MapPath("~/Paginas/Ugpp/Archivos/");
                string FileName = FuCargarArchivo.FileName;
                string Extension = System.IO.Path.GetExtension(FileName);
                int fileLen = FuCargarArchivo.PostedFile.ContentLength;

                if (fileLen > 20 * 1024 * 1024)
                {
                    Alerta("El Archivo es muy Grande, Reduzca el Tamaño, Máximo 20MB e Intente de Nuevo");
                    return;
                }

                if (Extension == ".txt" || Extension == ".TXT")
                {
                    BuscarArchivoBorrar();
                    SavePath += FileName;
                    FuCargarArchivo.SaveAs(SavePath);
                    CargueArchivo();
                    BuscarAcuerdo1035de2015();
                }

                else
                {
                    Alerta("La Extensión del Archivo debe ser .txt");
                    return;
                }
            }
            catch (Exception ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }


        private void CargueArchivo()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[Ugpp].[Usp_CargueAcuerdo1035de2015]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Archivo", @FuCargarArchivo.FileName.ToString());
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



        private void ControlArchivo(int Registros)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_ControlCarguePagosInsert]";
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



        private void BuscarAcuerdo1035de2015()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[Ugpp].[Usp_BuscarAcuerdo1035de2015]";
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
                            //lblValorTotaldelPago.Text = string.Format("{0:##,###,###,##0}", Convert.ToDouble(reader[1].ToString()));
                            //lblFechaMinima.Text = Convert.ToDateTime(reader[2]).ToShortDateString();
                            //lblFechaMaxima.Text = Convert.ToDateTime(reader[3]).ToShortDateString();
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
                System.IO.File.Delete(Server.MapPath("~/Paginas/Ugpp/Archivos/" + @FuCargarArchivo.FileName));
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

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/Ugpp/Cargar_Acuerdo_1035_2015.aspx", false);
        }

        protected void btnEsCorrecto_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[Ugpp].[Usp_ControlCargueAcuerdo1035de2015Insert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@NombreArchivo", SqlDbType.Text).Value = lblNombreArchivo.Text;

                    lblRegistros.Text = lblRegistros.Text.Replace(".", "");
                    lblRegistros.Text = lblRegistros.Text.Replace(",", "");
                    cmd.Parameters.Add("@NumeroRegistros", SqlDbType.Int).Value = Convert.ToInt32(lblRegistros.Text);
                    cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    SqlParameter outputIdParam = new SqlParameter("@Existe", SqlDbType.Int) { Direction = ParameterDirection.Output };
                    cmd.Parameters.Add(outputIdParam);

                    int vResultado = 0;
                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    vResultado = Convert.ToInt32(cmd.Parameters["@Existe"].Value);
                    con.Close();

                    if (vResultado == -1)
                    {
                        Alerta("El Archivo ya está Procesado");
                        btnEsCorrecto.Enabled = false;
                        return;
                    }
                    ProcesarAcuerdo1035de2015();
                    Alerta("Registros Agregados y Procesados");
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                }
            }
        }

        protected void ProcesarAcuerdo1035de2015()
        {
            var FechaArchivo = lblNombreArchivo.Text.Substring(27, 7);
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[Ugpp].[Usp_ProcesarAcuerdo1035de2015]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FechaArchivo", FechaArchivo.ToString());
                    cmd.Parameters.AddWithValue("@IdUsuarioCrea", Convert.ToInt32(Session["_IdUsuario"].ToString()));
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
    }
}