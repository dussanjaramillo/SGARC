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

namespace WebLiquidador.Paginas.CostasProcesales.Juzgado
{
    public partial class Juzgado : System.Web.UI.Page
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
                ddlDepartamento.Focus();
                lblEstado.Text = Session["_NombreRegionalUsuario"].ToString();
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
                lblEstado.Text = "Modificando: " + Session["_NombreRegionalUsuario"].ToString();
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        int vResultado;
                        var Textocmd = "[CostasProcesales].[Usp_JuzgadoUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdJuzgado", SqlDbType.Int).Value = Convert.ToInt32(hfIdJuzgado.Value);
                        cmd.Parameters.Add("@Nombre", SqlDbType.Text).Value = txtNombre.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = Convert.ToInt32(ddlMunicipio.SelectedValue.ToString());
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

                        Alerta("Juzgado Actualizado");
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
                        var Textocmd = "[CostasProcesales].[Usp_JuzgadoInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@Nombre", SqlDbType.Text).Value = txtNombre.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = Convert.ToInt32(ddlMunicipio.SelectedValue.ToString());

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
                       
                        Alerta("Juzgado Agregado");
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

            grvJuzgado.SelectedIndex = -1;
            grvJuzgado.DataSource = null;
            grvJuzgado.DataBind();
            btnGuardar.Enabled = false; 
        }

        protected void LlenarMunicipio(Int32 IdDepartamento)
        {
            try
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                var Textocmd = "[dbo].[Usp_MunicipiosPorDepartamento]";
                SqlConnection con = new SqlConnection(CadenaConexion);
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdDepartamento", SqlDbType.Int).Value = IdDepartamento;

                SqlDataAdapter Municipio = new SqlDataAdapter(cmd);
                DataSet dsMunicipio = new DataSet();
                Municipio.Fill(dsMunicipio, "Municipio");

                ddlMunicipio.DataSource = dsMunicipio.Tables["Municipio"].DefaultView;
                ddlMunicipio.DataTextField = "NombreMunicipio";
                ddlMunicipio.DataValueField = "IdMunicipio";
                ddlMunicipio.DataSource = null;
                ddlMunicipio.DataBind();
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }

        private void Validar_Datos()
        {
            if (ddlDepartamento.SelectedValue == "-1")
            {
                Alerta("Atención, debe Seleccionar el Departamento");
                ddlDepartamento.BackColor = System.Drawing.Color.Aqua;
                ddlDepartamento.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }
            ddlDepartamento.BackColor = System.Drawing.Color.Empty;

            if (ddlMunicipio.SelectedValue == "-1")
            {
                Alerta("Atención, debe Seleccionar el Muncipio");
                ddlMunicipio.BackColor = System.Drawing.Color.Aqua;
                ddlMunicipio.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }
            ddlMunicipio.BackColor = System.Drawing.Color.Empty;

            if (txtNombre.Text == String.Empty)
            {
                Alerta("Atención, debe Escribir el Nombre del Juzgado");
                txtNombre.Focus();
                txtNombre.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                return;
            }
            txtNombre.BackColor = System.Drawing.Color.Empty;
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/CostasProcesales/Juzgado/Juzgado.aspx", false);
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
            grvJuzgado0.Visible = true;
            grvJuzgado0.Caption = "Juzgados Costas Procesales";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvJuzgado0.AllowPaging = false;
            grvJuzgado0.AllowSorting = false;
            grvJuzgado0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvJuzgado0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "JuzgadosCostasProcesales.xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvJuzgado0.Visible = false;
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

        protected void ddlDepartamento_DataBound(object sender, EventArgs e)
        {
            ddlDepartamento.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlMunicipio_DataBound(object sender, EventArgs e)
        {
            ddlMunicipio.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlJuzgado_DataBound(object sender, EventArgs e)
        {
            ddlJuzgado.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            hfTransaccion.Value = "0";
            btnGuardar_Click(sender, e);    
        }

        protected void ddlJuzgado_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtNombre.Text = ddlJuzgado.SelectedItem.Text;
            hfIdJuzgado.Value = ddlJuzgado.SelectedValue;
            txtNombre.Enabled = true;
            btnGuardar.Enabled = true;
            btnAgregar.Enabled = false;
            btnExportar.Enabled = false;
            ddlTipoArchivo.Enabled = false;
            txtNombre.Focus();
            ddlDepartamento.Enabled = false;    
            ddlMunicipio.Enabled = false;
            hfTransaccion.Value = "1";
        }

        protected void ddlMunicipio_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnAgregar.Enabled = true;
            txtNombre.Enabled = true;
            txtNombre.Focus();
        }

        protected void grvJuzgado_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfIdJuzgado.Value = grvJuzgado.SelectedRow.Cells[1].Text;
            BuscarJuzgadoXId();
        }

        protected void LlenarJuzgado(Int32 IdMunicipio)
        {
            try
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                var Textocmd = "[CostasProcesales].[Usp_BuscarJuzgadoXIdMunicipio]";
                SqlConnection con = new SqlConnection(CadenaConexion);
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = IdMunicipio;

                SqlDataAdapter Juzgado = new SqlDataAdapter(cmd);
                DataSet dsJuzgado = new DataSet();
                Juzgado.Fill(dsJuzgado, "Juzgado");

                ddlJuzgado.DataSource = dsJuzgado.Tables["Juzgado"].DefaultView;
                ddlJuzgado.DataTextField = "Nombre";
                ddlJuzgado.DataValueField = "IdJuzgado";
                ddlJuzgado.DataSource = null;
                ddlJuzgado.DataBind();
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }

        protected void BuscarJuzgadoXId()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CostasProcesales].[Usp_BuscarJuzgadoXId]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdJuzgado", SqlDbType.Int).Value = hfIdJuzgado.Value;
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            txtNombre.Text = reader[0].ToString();
                            ddlDepartamento.SelectedValue = reader[2].ToString();
                            LlenarMunicipio(Convert.ToInt32(reader[2].ToString()));
                            ddlMunicipio.SelectedValue = reader[1].ToString();
                            LlenarJuzgado(Convert.ToInt32(hfIdJuzgado.Value));
                            ddlJuzgado.SelectedValue = hfIdJuzgado.Value;
                        }
                        con.Close();
                        txtNombre.Enabled = true;
                        btnGuardar.Enabled = true;
                        hfTransaccion.Value = "1";
                    }
                    else
                    {
                        Alerta("El Juzgado No Existe");
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

    }
}