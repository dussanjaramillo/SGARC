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

namespace WebLiquidador.Paginas.CostasProcesales.Deudor
{
    public partial class Abogado : System.Web.UI.Page
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

            //if ((new List<string> { "1", "2", "3", "4", "6", "7", "8", "9" }).Contains(Session["_IdCargo"].ToString()))
            //{
            //    Response.Redirect("~/DefaultCf.aspx");
            //}

            if (!IsPostBack)
            {
                txtIdentificacion.Focus();
               
            }
            lblEstado.Text = "Agregando: "+ Session["_NombreRegionalUsuario"].ToString(); 
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

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscarCostasProcesales(txtIdentificacion.Text, 0);
            btnGuardar.Enabled = true;
            txtNombre.Focus();
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
                        var Textocmd = "[CostasProcesales].[Usp_AbogadoUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdAbogado", SqlDbType.Int).Value = Convert.ToInt32(hfIdAbogado.Value); 
                        cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Convert.ToString(Convert.ToInt64(txtIdentificacion.Text.ToString().Trim()));
                        cmd.Parameters.Add("@Nombre", SqlDbType.Text).Value = txtNombre.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdRegional", SqlDbType.Int).Value = Convert.ToInt32(ddlRegional.SelectedValue.ToString());

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

                        Alerta("Abogado Actualizado");
                        lblEstado.Text = "Modificando: " + Session["_NombreRegionalUsuario"].ToString(); 
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
                        var Textocmd = "[CostasProcesales].[Usp_AbogadoInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Convert.ToString(Convert.ToInt64(txtIdentificacion.Text.ToString().Trim()));
                        cmd.Parameters.Add("@Nombre", SqlDbType.Text).Value = txtNombre.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdRegional", SqlDbType.Int).Value = Convert.ToInt32(ddlRegional.SelectedValue.ToString());

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

                        lblEstado.Text = "Agregando: " + Session["_NombreRegionalUsuario"].ToString();
                        Alerta("Abogado Agregado");
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

            grvAbogado.SelectedIndex = -1;
            grvAbogado.DataSource = null;
            grvAbogado.DataBind();
            btnGuardar.Enabled = false; 
        }

        private void Validar_Datos()
        {
            if (txtIdentificacion.Text == String.Empty)
            {
                Alerta("Atención, debe Escribir el Numero de Identificacion");
                txtIdentificacion.Focus();
                txtIdentificacion.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                return;
            }
            txtIdentificacion.BackColor = System.Drawing.Color.Empty;

            if (txtNombre.Text == String.Empty)
            {
                Alerta("Atención, debe Escribir el Nombre y Apellidos del Abogado");
                txtNombre.Focus();
                txtNombre.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                return;
            }
            txtNombre.BackColor = System.Drawing.Color.Empty;

            if (ddlRegional.SelectedValue == "-1")
            {
                Alerta("Atención, debe Seleccionar la Regional");
                ddlRegional.BackColor = System.Drawing.Color.Aqua;
                ddlRegional.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }
            ddlRegional.BackColor = System.Drawing.Color.Empty;
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/CostasProcesales/Deudor/Abogado.aspx", false);
        }

        protected void grvCentroFormacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            BuscarCostasProcesales("", Convert.ToInt32(grvAbogado.SelectedRow.Cells[1].Text));
        }

        protected void BuscarCostasProcesales(string  Identificacion, Int32 IdAbogado)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CostasProcesales].[Usp_BuscarAbogado]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdAbogado", SqlDbType.Int).Value = IdAbogado;
                cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value =  Identificacion.ToString();
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfIdAbogado.Value = reader[0].ToString();
                            txtIdentificacion.Text = reader[1].ToString();
                            txtNombre.Text = reader[2].ToString();
                            
                            if (reader[3].ToString() == "")
                            {
                                ddlRegional.SelectedValue = "-1";
                            }
                            else
                            {
                                ddlRegional.SelectedValue = reader[3].ToString();
                            }

                            if (reader[4].ToString() == "")
                            {
                                chbEsActivo.Checked = false;
                            }
                            else
                            {
                                chbEsActivo.Checked = true;
                            }
                            hfTransaccion.Value = "1";
                        }
                        lblEstado.Text = "Modificando: " + Session["_NombreRegionalUsuario"].ToString();
                        btnBuscar.Enabled = false;
                        btnGuardar.Enabled = true;
                        con.Close();
                    }
                    else
                    {
                        Alerta("La Identificacion del Abogado No Existe");
                        txtIdentificacion.Focus();
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            if (ddlTipoArchivo.SelectedValue == "1")
            {
                ExportarTxt();
            }
            else
            {
                ExportarExcel();
            }
        }

        protected void ExportarExcel()
        {
            grvAbogado0.Visible = true;
            grvAbogado0.Caption = "Abogados Costas Procesales";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvAbogado0.AllowPaging = false;
            grvAbogado0.AllowSorting = false;
            grvAbogado0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvAbogado0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "AbogadosCostasProcesales.xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvAbogado0.Visible = false;
        }

        protected void ExportarTxt()
        {
            try
            {
                string PathArchivo = "DeudoresCostasProcesales_" + DateTime.Now.ToShortDateString().Replace("/", "_") + ".txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[CostasProcesales].[Usp_BuscarAbogado_]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    con.Close();

                    if (dt.Rows.Count > 0)
                    {
                        StringBuilder sb = new StringBuilder();
                        IEnumerable<string> columnNames = dt.Columns.Cast<DataColumn>().Select(column => column.ColumnName);
                        sb.AppendLine(string.Join("|", columnNames));

                        foreach (DataRow row in dt.Rows)
                        {
                            IEnumerable<string> fields = row.ItemArray.Select(field => field.ToString());
                            sb.AppendLine(string.Join("|", fields));
                        }

                        if (sb.Length > 0)
                        {
                            Response.Clear();
                            Response.Buffer = true;
                            Response.ContentType = "application/text/plain";
                            Response.AddHeader("Content-Disposition", "attachment;filename=" + PathArchivo);
                            Response.Charset = "UTF-8";
                            Response.ContentEncoding = System.Text.Encoding.Default;
                            Response.Write(sb.ToString());
                            Response.End();
                        }
                    }
                    else
                    {
                        Alerta("Atención: No Hay Registros");
                        return;
                    }
                }
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }
        }

        protected void ddlRegional_DataBound(object sender, EventArgs e)
        {
            ddlRegional.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }
    }
}