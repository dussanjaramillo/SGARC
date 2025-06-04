using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using System.Text;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.Parametro
{
    public partial class SalarioMinimo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            //Cargos
            //1   01  Coordinador
            //2   02  Abogado
            //3   03  Fiscalizador
            //4   04  Técnico
            //5   05  Administrador
            //6   06  Profesional
            //7   07  Siif - Nación
            //8   08  Subdirector
            //9   09  Producción
            //10  10  Control Interno
            if (!(new List<string> { "5" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/Default.aspx");
            }


            if (!IsPostBack)
            {
                txtDesde.Focus();
            }
            lblEstado.Text = "Agregando";
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/Parametro/SalarioMinimo.aspx", false);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            //Usuario Existe se hace un Update
            if (hfTransaccion.Value == "1")
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        int vResultado;
                        var Textocmd = "[dbo].[Usp_SalarioMinimoUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdSalarioMinimo", SqlDbType.Int).Value = Convert.ToInt32(hfIdSalarioMinimo.Value);

                        cmd.Parameters.Add("@Desde", SqlDbType.Date).Value = Convert.ToDateTime(txtDesde.Text.ToString().Trim());
                        cmd.Parameters.Add("@Hasta", SqlDbType.Date).Value = Convert.ToDateTime(txtHasta.Text.ToString().Trim());
                        cmd.Parameters.Add("@Valor", SqlDbType.Int).Value = txtValor.Text.ToString().Trim();
                        cmd.Parameters.Add("@Norma", SqlDbType.Text).Value = txtNorma.Text.ToString().Trim();

                        if (chbEsActivo.Checked)
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true;
                        }
                        else
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false;
                        }
                        cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();
                        Alerta("Salario Mínimo Actualizado");
                        lblEstado.Text = "Modificando";
                    }
                    catch (SqlException ex)
                    {
                        Alerta("Error: " + ex.Message);
                    }
                }
            }
            else
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        var Textocmd = "[dbo].[Usp_SalarioMinimoInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdSalarioMinimo", SqlDbType.Int).Value = DbType.Int32;
                        cmd.Parameters.Add("@Desde", SqlDbType.Date).Value = Convert.ToDateTime(txtDesde.Text.ToString().Trim());
                        cmd.Parameters.Add("@Hasta", SqlDbType.Date).Value = Convert.ToDateTime(txtHasta.Text.ToString().Trim());
                        cmd.Parameters.Add("@Valor", SqlDbType.Int).Value = txtValor.Text.ToString().Trim();
                        cmd.Parameters.Add("@Norma", SqlDbType.Text).Value = txtNorma.Text.ToString().Trim();

                        if (chbEsActivo.Checked)
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true;
                        }
                        else
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false;
                        }
                        cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        int vResultado = 0;
                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();

                        lblEstado.Text = "Agregando";
                        Alerta("Salario Minimo Agregado");
                    }
                    catch (SqlException ex)
                    {
                        if (ex.Number == 2627)
                        {
                            Alerta("Error: " + ex.Message.ToString());
                            return;
                        }
                        Alerta("Error: " + ex.Message.ToString());
                    }
                }
            }
            grvSalarioMinimo.SelectedIndex = -1;
            grvSalarioMinimo.DataSource = null;
            grvSalarioMinimo.DataBind();
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

        protected void grvSalarioMinimo_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfIdSalarioMinimo.Value = grvSalarioMinimo.SelectedRow.Cells[1].Text;

            txtDesde.Text = grvSalarioMinimo.SelectedRow.Cells[2].Text;
            txtHasta.Text = grvSalarioMinimo.SelectedRow.Cells[3].Text;
            txtValor.Text = grvSalarioMinimo.SelectedRow.Cells[4].Text;
            txtNorma.Text = grvSalarioMinimo.SelectedRow.Cells[5].Text;
            CheckBox chk = grvSalarioMinimo.SelectedRow.Cells[6].Controls[0] as CheckBox;
            if (chk.Checked)
            {chbEsActivo.Checked = true;}
            else
            {chbEsActivo.Checked = false;}

            hfTransaccion.Value = "1";
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            grvSalarioMinimo0.Visible = true;
            grvSalarioMinimo0.Caption = "SalarioMinimo_" + DateTime.Today.ToShortDateString();
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvSalarioMinimo0.AllowPaging = false;
            grvSalarioMinimo0.AllowSorting = false;
            grvSalarioMinimo0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvSalarioMinimo0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "SalarioMinimo_" + DateTime.Today.ToShortDateString() + ".xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvSalarioMinimo0.Visible = false;
        }

    }
}