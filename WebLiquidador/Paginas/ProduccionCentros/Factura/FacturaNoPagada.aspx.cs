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

namespace WebLiquidador.Paginas.ProduccionCentros.Factura
{
    public partial class FacturaNoPagada : System.Web.UI.Page
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
        }

        protected void btn_Limpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Factura/FacturaNoPagada.aspx", false);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[CentroFormacion].[Usp_BuscarControlSeguimientoCentroFormacion]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FechaInicial", txtFechaInicial.Text.Trim());
                    cmd.Parameters.AddWithValue("@FechaFinal", txtFechaFinal.Text.Trim());
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
                txtFechaInicial.Enabled = false;
                txtFechaFinal.Enabled = false;
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
            txtFechaRespuesta.Enabled = false;
            ProcesarInformacion();
            Alerta("Listo: Correos Enviados");
        }

        private void ProcesarInformacion()
        {
            int Filas = grvCentroFormacion.Rows.Count;
            if (Filas > 0)
            {
                string IdCentroFormacion = "";
                string NombreSubdirector = "";
                string CodigoSubdirector = "";
                string NombreCentroFormacion = "";
                foreach (GridViewRow dr in grvCentroFormacion.Rows)
                {
                    IdCentroFormacion = HttpUtility.HtmlDecode(dr.Cells[0].Text);
                    CodigoSubdirector = HttpUtility.HtmlDecode(dr.Cells[1].Text);
                    NombreSubdirector = HttpUtility.HtmlDecode(dr.Cells[2].Text);
                    NombreCentroFormacion = HttpUtility.HtmlDecode(dr.Cells[3].Text);
                    BuscarControlSeguimientoFactura(IdCentroFormacion, NombreSubdirector, CodigoSubdirector, NombreCentroFormacion);
                }
            }
        }

        private void BuscarControlSeguimientoFactura(string IdCentroFormacion, string NombreSubdirector, string CodigoSubdirector, string NombreCentroFormacion)
        {
            try
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[CentroFormacion].[Usp_BuscarControlSeguimientoFactura]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FechaInicial", Convert.ToDateTime(txtFechaInicial.Text.Trim()));
                    cmd.Parameters.AddWithValue("@FechaFinal", Convert.ToDateTime(txtFechaFinal.Text.Trim()));
                    cmd.Parameters.AddWithValue("@IdCentroFormacion", Convert.ToInt32(IdCentroFormacion));

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    grvControlSeguimientoFactura.DataSource = dt;
                    grvControlSeguimientoFactura.DataBind();
                    con.Close();
                }
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }
            string UsuariosCentro = "";

            if (Session["_CodigoUsuario"].ToString() == "rivanegas")
            {
                UsuariosCentro = "rivanegas@sena.edu.co;";
            }
            else
            {
                UsuariosCentro = "rivanegas@sena.edu.co;" + Session["_CodigoUsuario"] + "@sena.edu.co;";
            }

            var CadenaConexion1 = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            var Textocmd1 = "[CentroFormacion].[Usp_BuscarControlSeguimientoUsuario]";
            SqlConnection con1 = new SqlConnection(CadenaConexion1);
            SqlCommand cmd1 = new SqlCommand(Textocmd1, con1);
            cmd1.CommandType = System.Data.CommandType.StoredProcedure;
            cmd1.Parameters.AddWithValue("@FechaInicial", Convert.ToDateTime(txtFechaInicial.Text.Trim()));
            cmd1.Parameters.AddWithValue("@FechaFinal", Convert.ToDateTime(txtFechaFinal.Text.Trim()));
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

            int Filas = grvControlSeguimientoFactura.Rows.Count;
            if (Filas > 0)
            {
                EnviarCorreo(NombreSubdirector, CodigoSubdirector, NombreCentroFormacion, UsuariosCentro);
            }
        }

        private void EnviarCorreo(string NombreSubdirector, string CodigoSubdirector, string NombreCentroFormacion, string UsuariosCentro)
        {
            grvControlSeguimientoFactura.Visible = true;

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    grvControlSeguimientoFactura.RenderControl(hw);
                    StringReader sr = new StringReader(sw.ToString());
                    EnviarCorreo oCorreo = new EnviarCorreo();

                    var enviadoA = CodigoSubdirector + "@sena.edu.co";
                    //var enviadoA = "rivanegas@sena.edu.co";

                    var conCopiaA = UsuariosCentro.Remove(UsuariosCentro.Length - 1);
                    //var conCopiaA = "rivanegas@sena.edu.co";

                    var mensaje = "Señor(a) Subdirector(a): " + NombreSubdirector + ", " + NombreCentroFormacion + ". Durante el periodo comprendido entre el <b>"
                        + String.Format("{0:D}", Convert.ToDateTime(txtFechaInicial.Text)) + "</b> y el <b>" + String.Format("{0:D}", Convert.ToDateTime(txtFechaFinal.Text))
                        + "</b>, se reflejan en el Sistema Nacional de Producción de Centros, las Prefacturas que no presentan pago, los motivos pueden ser:<br/> "
                        + "<br/>1- La Prefactura debe ser anulada por no venta del bien o servicio."
                        + "<br/>2- La Prefactura no aparece pagada porque, no se colocó el número de la Prefactura de la forma correcta en el Cupón de Pago. Por favor corríja el número, según documento que se adjunta. "
                        + "<br/>3- Aún no se ha efectuado el pago de la Prefactura. Por favor gestione el pago con el Tercero o el Cliente"
                        + "<br/> <br/> Se solicita comedidamente que a más tardar el día <b>"
                        + String.Format("{0:D}", Convert.ToDateTime(txtFechaRespuesta.Text))
                        + "</b>, que todas las Prefacturas relacionadas tengan el estado de pagadas o anuladas, si tiene dudas del proceso a realizar en alguno de los casos enumerados anteriormente, agradecemos contactarse con el Señor Edwin Alejandro Caicedo al correo edcaicedo@sena.edu.co o a la IP 14347. <br/> "
                        + "<br/> A continuación se presenta el listado de las Prefacturas pendientes de pago: <br/> <br/> "
                        + "<hr/> " + sw.ToString() + "<hr/> "
                        + "<br/> Agradezco su gestión oportuna, <br/> <br/> <b>Sistema Nacional de Producción de Centros de Formación </b>";
                    var asunto = "Prefacturas No Pagadas en su Centro de Formación";
                    bool importante = true;
                    var archivo = Server.MapPath(@"\Imagenes\FacturaNoPagada.pdf");

                    oCorreo.oEnviarCorreo(enviadoA, conCopiaA, mensaje, asunto, importante, archivo);
                }
            }
            grvControlSeguimientoFactura.Visible = false;
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

        protected void grvCentroFormacion_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvCentroFormacion.PageIndex = e.NewPageIndex;
            grvCentroFormacion.DataSource = SqlDataSource1;
            grvCentroFormacion.DataBind();
        }
    }
}