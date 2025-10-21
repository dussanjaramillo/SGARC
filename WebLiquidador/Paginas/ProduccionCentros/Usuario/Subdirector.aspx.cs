using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace WebLiquidador.Paginas.ProduccionCentros.Usuario
{
    public partial class Subdirector : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if ((new List<string> { "1", "2", "3", "4", "6", "7", "8" }).Contains(Session["_IdCargo"].ToString()))
            {
                btnGuardar.Enabled = false;
                txtIpTelefono.Enabled = false;
                chbEsActivo.Enabled = false;
                grvSubdirector.Columns[0].Visible = false;
                grvSubdirector.Columns[1].Visible = false;
            }


            if (!IsPostBack)
            {
                //var NombrePrograma = Request.Url.Segments[Request.Url.Segments.Length - 1];
                //BuscarPermiso oLeerPermisos = new BuscarPermiso();
                //Permisos oPermiso = oLeerPermisos.BuscarPermisoUsuario(Session["_CodigoUsuario"].ToString(), NombrePrograma); 
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (txtIpTelefono.Text != "")
            {
                if (txtIpTelefono.Text.Length != 5)
                {
                    Alerta("La Ip del Teléfono debe tener 5 dígitos");
                    txtIpTelefono.Focus();
                    return;
                }
            }

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_UsuarioUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = Convert.ToInt32(hfIdUsuario.Value);

                    if (chbEsActivo.Checked)
                    { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true; }
                    else
                    { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false; }

                    if (txtIpTelefono.Text == "")
                    { cmd.Parameters.Add("@IpTelefono", SqlDbType.Int).Value = System.DBNull.Value; }
                    else
                    { cmd.Parameters.Add("@IpTelefono", SqlDbType.Int).Value = Convert.ToInt32(txtIpTelefono.Text); }

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();

                    grvSubdirector.SelectedIndex = -1;

                    grvSubdirector.DataSource = null;
                    btnGuardar.Enabled = false;
                    Alerta("Usuario Actualizado");
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void Alerta(string Mensaje)
        {
            //string message = "Hello! Mudassar.";
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
            Response.Redirect("~/Paginas/ProduccionCentros/Usuario/Subdirector.aspx", false);
        }

        protected void grvSubdirector_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfIdUsuario.Value = grvSubdirector.SelectedRow.Cells[1].Text;
            BuscarUsuario();
        }

        protected void BuscarUsuario()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[UsuarioBuscarXIdUsuario]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = Convert.ToInt32(hfIdUsuario.Value);

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            chbEsActivo.Checked = Convert.ToBoolean(reader[4].ToString());
                            txtIpTelefono.Text = reader[10].ToString();
                        }
                        con.Close();
                    }
                    btnGuardar.Enabled = true;
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            grvSubdirector0.Visible = true;
            grvSubdirector0.Caption = "SubdirectoresDeCentros";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvSubdirector0.AllowPaging = false;
            grvSubdirector0.AllowSorting = false;
            grvSubdirector0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvSubdirector0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "SubdirectoresDeCentros.xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvSubdirector0.Visible = false;
        }
    }
}