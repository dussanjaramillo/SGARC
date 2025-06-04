using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using WebLiquidador.App_Code;
using System.IO;

namespace WebLiquidador.Paginas.ProduccionCentros.CuponPago
{
    public partial class CuponPagoSinAsignar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if (!(new List<string> { "1", "639" }).Contains(Session["_IdUsuario"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }
            FechaPagoSinAsignar();
        }

        protected void btn_Limpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/CuponPago/CuponPagoSinAsignar.aspx", false);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[CentroFormacion].[Usp_BuscarCentroFormacionCuponSinAsignar]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandTimeout = 0;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    grvCentroFormacion.DataSource = dt;
                    grvCentroFormacion.DataBind();
                    con.Close();
                }
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }

            if (grvCentroFormacion.Rows.Count > 0)
            {
                btnContinuar.Enabled = true;
                btnBuscar.Enabled = false;
            }
            else
            {
                Alerta("Atención, No hay Registros");
                btnContinuar.Enabled = false;
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

        protected void btnContinuar_Click(object sender, EventArgs e)
        {
            btnContinuar.Enabled = false;
            ProcesarInformacion();
            Alerta("Listo: Correos Enviados");
        }

        private void FechaPagoSinAsignar()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            var Textocmd = "[CentroFormacion].[Usp_BuscarFechaPagoSinAsignar]";
            SqlConnection con = new SqlConnection(CadenaConexion);
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
                        lblFechaPagoSinAsignar.Text = reader[0].ToString();
                    }
                    con.Close();
                }
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }
        }

            private void ProcesarInformacion()
        {
            int Filas = grvCentroFormacion.Rows.Count;
            if (Filas > 0)
            {
                string IdCentroFormacion = "";
                //string NombreUsuario = "";
                //string CodigoUsuario = "";
                //string NombreCentroFormacion = "";
                //string NombreRegional = "";
                foreach (GridViewRow dr in grvCentroFormacion.Rows)
                {
                    IdCentroFormacion = HttpUtility.HtmlDecode(dr.Cells[0].Text);
                    //NombreUsuario = HttpUtility.HtmlDecode(dr.Cells[1].Text);
                    //CodigoUsuario = HttpUtility.HtmlDecode(dr.Cells[2].Text);
                    //NombreCentroFormacion = HttpUtility.HtmlDecode(dr.Cells[3].Text);
                    //NombreRegional = HttpUtility.HtmlDecode(dr.Cells[4].Text);

                    BuscarCentroFormacionCuponSinAsignar(IdCentroFormacion);
                }
            }
        }

        private void BuscarCentroFormacionCuponSinAsignar(string IdCentroFormacion)
        {
            try
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[CentroFormacion].[Usp_BuscarCuponPagoSinAsignar]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdCentroFormacion", Convert.ToInt32(IdCentroFormacion));

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    grvCuponPagoSinAsignar.DataSource = dt;
                    grvCuponPagoSinAsignar.DataBind();
                    con.Close();
                }
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }
            
            string UsuariosCentro = "";
            var CadenaConexion1 = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            var Textocmd1 = "[CentroFormacion].[Usp_BuscarUsuarioCentroFormacionCuponSinAsignar]";
            SqlConnection con1 = new SqlConnection(CadenaConexion1);
            SqlCommand cmd1 = new SqlCommand(Textocmd1, con1);
            cmd1.CommandType = System.Data.CommandType.StoredProcedure;
            cmd1.Parameters.AddWithValue("@IdCentroFormacion", Convert.ToInt32(IdCentroFormacion));

            try
            {
                con1.Open();
                SqlDataReader reader = cmd1.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        UsuariosCentro = UsuariosCentro + reader[2].ToString() + "@sena.edu.co,";
                    }
                    con1.Close();
                }
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }

            if (UsuariosCentro == "")
            {
                return;
            }

            int Filas = grvCuponPagoSinAsignar.Rows.Count;
            if (Filas > 0)
            {
                EnviarCorreo(UsuariosCentro);
            }
        }

        private void EnviarCorreo(string UsuariosCentro)
        {
            grvCuponPagoSinAsignar.Visible = true;

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    grvCuponPagoSinAsignar.RenderControl(hw);
                    StringReader sr = new StringReader(sw.ToString());
                    EnviarCorreo oCorreo = new EnviarCorreo();

                    var enviadoA = UsuariosCentro.Remove(UsuariosCentro.Length - 1);
                    //var enviadoA = "rivanegas@sena.edu.co";

                    var conCopiaA = Session["_CodigoUsuario"].ToString() + "@sena.edu.co";
                    //var conCopiaA = "rivanegas@sena.edu.co";

                    var mensaje = "Estimado(s) Usuario(s): Revisando la Base de Datos se encontrarón Cupones de Pago para su Centro de Formación que aún no están asignados a las PreFacturas.<b>"
                                + "<br/> A continuación se presenta el listado de los Cupones de Pago, aún no asociados a la PreFactura, para mayor información e instrucciones debe consultar al archivo adjunto.<br/> <br/>"
                                + "<hr/> " + sw.ToString() + "<hr/> "
                                + "<br/> Por favor, efectuar las acciones correspondientes en el menor tiempo posible, dada la importancia que tiene la Facturación Electrónica del Siif Nación, con lo establecido en la Circular 3-2021-000060 del 12/04/2021, del DIRECTOR ADMINISTRATIVO Y FINANCIERO.<br/> <br/>"
                                + "<br/> Agradezco su gestión oportuna, <br/> <br/> <b>Sistema Nacional de Producción de Centros de Formación</b>";
                    var asunto = "Cupones de Pagos Recibidos pendientes de asociar a Prefacturas en su Centro de Formación";
                    bool importante = true;
                    var archivo = Server.MapPath(@"\Imagenes\CuponPagoNoAsociado.pdf");

                    oCorreo.oEnviarCorreo(enviadoA, conCopiaA, mensaje, asunto, importante, archivo);
                }
            }
            grvCuponPagoSinAsignar.Visible = false;
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }
    }
}