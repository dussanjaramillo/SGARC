using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Text;
using System.Web.UI;
using WebLiquidador.App_Code;


//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.CostasProcesales.Global
{
    public partial class TasaInteresMoratorio : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

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
                Response.Redirect("~/DefaultCp.aspx");
            }

            if (!IsPostBack)
            {
                lblEstado.Text = Session["_NombreRegionalUsuario"].ToString();
                //txtVigenciaDesde_CalendarExtender.StartDate = DateTime.Today;
                //txtVigenciaDesde_CalendarExtender.EndDate = DateTime.Today.AddDays(10);

                //txtVigenciaHasta_CalendarExtender.StartDate = DateTime.Today;
                //txtVigenciaHasta_CalendarExtender.EndDate = DateTime.Today.AddDays(10);
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

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            hfTransaccion.Value = "0";
            btnGuardar_Click(sender, e);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!IsValid)
            {
                return;
            }

            hfErrorValidacion.Value = "0";
            Validar_Datos();
            if (hfErrorValidacion.Value == "1")
            { return; }
            
            //Usuario Existe se hace un Update
            if (hfTransaccion.Value == "1")
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        int vResultado;
                        var Textocmd = "[Global].[Usp_TasaInt​eresBancarioUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdTasaInteresBancario", SqlDbType.Int).Value = Convert.ToInt32(hfIdTasa.Value);
                        cmd.Parameters.Add("@Tasa", SqlDbType.Decimal).Value = txtTasa.Text.ToString().Trim();
                        cmd.Parameters.Add("@VigenciaDesde", SqlDbType.Date).Value = Convert.ToDateTime(txtVigenciaDesde.Text.ToString());
                        cmd.Parameters.Add("@VigenciaHasta", SqlDbType.Date).Value = Convert.ToDateTime(txtVigenciaHasta.Text.ToString());
                        //cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();

                        Alerta("Tasa Interes Moratorio Actualizada");
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
                        var Textocmd = "[Global].[Usp_TasaInt​eresBancarioInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@Tasa", SqlDbType.Decimal).Value = txtTasa.Text.ToString().Trim();
                        cmd.Parameters.Add("@VigenciaDesde", SqlDbType.Date).Value = Convert.ToDateTime(txtVigenciaDesde.Text.ToString());
                        cmd.Parameters.Add("@VigenciaHasta", SqlDbType.Date).Value = Convert.ToDateTime(txtVigenciaHasta.Text.ToString());

                        int vResultado = 0;
                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();
                       
                        Alerta("Tasa Interes Moratorio Agregada");
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

            grvTasaInteresMoratorio.SelectedIndex = -1;
            grvTasaInteresMoratorio.DataSource = null;
            grvTasaInteresMoratorio.DataBind();
            btnGuardar.Enabled = false; 
        }

        private void Validar_Datos()
        {
            if (Convert.ToDecimal(txtTasa.Text) == 0)
            {
                Alerta("Error: El Valor de la Tasa debe ser mayor que cero");
                txtTasa.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                txtTasa.Focus();
                return;
            }
            txtTasa.BackColor = System.Drawing.Color.Empty;

            if (txtVigenciaDesde.Text == "")
            {
                Alerta("Error: La Vigencia Desde debe ser una Fecha");
                txtVigenciaDesde.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                txtVigenciaDesde.Focus();
                return;
            }
            txtVigenciaDesde.BackColor = System.Drawing.Color.Empty;

            if (txtVigenciaHasta.Text == "")
            {
                Alerta("Error: La Vigencia Desde debe ser una Fecha");
                txtVigenciaHasta.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                txtVigenciaHasta.Focus();
                return;
            }
            txtVigenciaHasta.BackColor = System.Drawing.Color.Empty;
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/CostasProcesales/Global/TasaInteresMoratorio.aspx", false);
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
           ExportarExcel();

        }

        protected void ExportarExcel()
        {
            grvTasaInteresMoratorio0.Visible = true;
            grvTasaInteresMoratorio0.Caption = "Tasa Interes Moratorio";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvTasaInteresMoratorio0.AllowPaging = false;
            grvTasaInteresMoratorio0.AllowSorting = false;
            grvTasaInteresMoratorio0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvTasaInteresMoratorio0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "TasaInteresMoratorio.xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvTasaInteresMoratorio0.Visible = false;
        }

        protected void grvTasaInteresMoratorio_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfIdTasa.Value = grvTasaInteresMoratorio.SelectedRow.Cells[1].Text;
            BuscarTasaInteresMoratorioXId();

        }
        
        protected void BuscarTasaInteresMoratorioXId()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[Global].[Usp_BuscarTasaInt​eresBancarioXId]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdTasaInteresBancario", SqlDbType.Int).Value = hfIdTasa.Value;
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            txtTasa.Text = reader[0].ToString();
                            txtVigenciaDesde.Text = Convert.ToDateTime(reader[1]).ToShortDateString();
                            txtVigenciaHasta.Text = Convert.ToDateTime(reader[2]).ToShortDateString();
                        }
                        con.Close();
                        btnGuardar.Enabled = true;
                        hfTransaccion.Value = "1";
                    }
                    else
                    {
                        Alerta("La Tasa Interes Moratorio No Existe");
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void txtVigenciaHasta_TextChanged(object sender, EventArgs e)
        {
            btnAgregar.Enabled = true;  
        }
    }
}