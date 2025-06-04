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
    public partial class UnidadMedida : System.Web.UI.Page
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

            if (!IsPostBack)
            {
                txtNombreUnidadMedida.Focus();
            }
            lblEstado.Text = "Agregando";
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/Parametro/UnidadMedida.aspx", false);
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            grvUnidadMedida0.Visible = true;
            grvUnidadMedida0.Caption = "UnidadMedida_" + DateTime.Today.ToShortDateString();
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvUnidadMedida0.AllowPaging = false;
            grvUnidadMedida0.AllowSorting = false;
            grvUnidadMedida0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvUnidadMedida0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "UnidadMedida_" + DateTime.Today.ToShortDateString() + ".xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvUnidadMedida0.Visible = false;
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
                        var Textocmd = "[CentroFormacion].[Usp_UnidadMedidaUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdUnidadMedida", SqlDbType.Int).Value = Convert.ToInt32(hfIdUnidadMedida.Value);
                        cmd.Parameters.Add("@NombreUnidadMedida", SqlDbType.Text).Value = txtNombreUnidadMedida.Text.Trim();
                        cmd.Parameters.Add("@AbreviaturaUnidadMedida", SqlDbType.Text).Value = txtAbreviaturaUnidadMedida.Text.Trim();

                        if (chbEsActivo.Checked)
                        {cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true;}
                        else
                        {cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false;}
                        cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();

                        Alerta("Unidad Medida Actualizada");
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
                        var Textocmd = "[CentroFormacion].[Usp_UnidadMedidaInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        //cmd.Parameters.Add("@IdUnidadMedida", SqlDbType.Int).Value = DbType.Int32;
                        cmd.Parameters.Add("@NombreUnidadMedida", SqlDbType.Text).Value = txtNombreUnidadMedida.Text.Trim();
                        cmd.Parameters.Add("@AbreviaturaUnidadMedida", SqlDbType.Text).Value = txtAbreviaturaUnidadMedida.Text.Trim();

                        if (chbEsActivo.Checked)
                        { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true; }
                        else
                        { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false; }

                        cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        int vResultado = 0;
                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();

                        lblEstado.Text = "Agregando";
                        Alerta("Unidad Medida Agregada");
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
            grvUnidadMedida.SelectedIndex = -1;
            grvUnidadMedida.DataSource = null;
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

        protected void grvUnidadMedida_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfTransaccion.Value = "1";
            hfIdUnidadMedida.Value = grvUnidadMedida.SelectedRow.Cells[1].Text;
            txtNombreUnidadMedida.Text = grvUnidadMedida.SelectedRow.Cells[2].Text;
            txtAbreviaturaUnidadMedida.Text = grvUnidadMedida.SelectedRow.Cells[3].Text;

            CheckBox chk = grvUnidadMedida.SelectedRow.Cells[4].Controls[0] as CheckBox;
            if (chk.Checked)
            {chbEsActivo.Checked = true;}
            else
            {chbEsActivo.Checked = false;}
        }
    }
}