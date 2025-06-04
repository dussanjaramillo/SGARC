using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Text;
using System.Web.UI;


//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros
{
    public partial class Centros : System.Web.UI.Page
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
                Response.Redirect("~/DefaultCf.aspx");
            }

            if (!IsPostBack)
            {
                txtCodigoCentroFormacion.Focus();
                ddlMunicipio.Items.Insert(0, new ListItem("Seleccione...", "-1"));
            }
            lblEstado.Text = "Agregando";
        }

        protected void ddlDepartamento_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!ddlDepartamento.SelectedIndex.Equals(-1))
            {
                LlenarMunicipio(Convert.ToInt32(ddlDepartamento.SelectedValue));
            }
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
                ddlMunicipio.DataBind();
                ddlMunicipio.Items.Insert(0, new ListItem("Seleccione...", "-1"));
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
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

        protected void ddlDepartamento_DataBound(object sender, EventArgs e)
        {
            ddlDepartamento.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscarCentroFormacion(txtCodigoCentroFormacion.Text, 0);
            btnGuardar.Enabled = true;
            txtNombreCentroFormacion.Focus();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
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
                        var Textocmd = "[dbo].[Usp_CentroFormacionUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(hfCentroFormacion.Value);
                        cmd.Parameters.Add("@CodigoCentroFormacion", SqlDbType.Text).Value = txtCodigoCentroFormacion.Text.ToString().Trim();
                        cmd.Parameters.Add("@NombreCentroFormacion", SqlDbType.Text).Value = txtNombreCentroFormacion.Text.ToString().Trim();
                        cmd.Parameters.Add("@Direccion", SqlDbType.Text).Value = txtDireccion.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdRegional", SqlDbType.Int).Value = Convert.ToInt32(ddlRegional.SelectedValue.ToString());
                        cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = Convert.ToInt32(ddlMunicipio.SelectedValue.ToString());
                        cmd.Parameters.Add("@Indicativo", SqlDbType.Int).Value = Convert.ToInt32(txtIndicativo.Text.ToString().Trim());
                        cmd.Parameters.Add("@Conmutador", SqlDbType.Text).Value = txtConmutador.Text.ToString().Trim();
                        cmd.Parameters.Add("@Extension", SqlDbType.Text).Value = txtExtension.Text.ToString().Trim();
                        cmd.Parameters.Add("@Fax", SqlDbType.Text).Value = txtFax.Text.ToString().Trim();

                        if (chbEstadoEmergencia.Checked)
                        {
                            cmd.Parameters.Add("@EstadoEmergencia", SqlDbType.Bit).Value = true;
                        }
                        else
                        {
                            cmd.Parameters.Add("@EstadoEmergencia", SqlDbType.Bit).Value = false;
                        }

                        if (chbEsActivo.Checked)
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true;
                        }
                        else
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false;
                        }
                        cmd.Parameters.Add("@LinkWompi", SqlDbType.Text).Value = txtLinkWompi.Text.ToString().Trim();
                        cmd.Parameters.Add("@WompiPagosRapidos", SqlDbType.Text).Value = txtWompiPagosRapidos.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();

                        Alerta("Centro Formación Actualizado");
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
                        var Textocmd = "[dbo].[Usp_CentroFormacionInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = DbType.Int32;
                        cmd.Parameters.Add("@CodigoCentroFormacion", SqlDbType.Text).Value = txtCodigoCentroFormacion.Text.ToString().Trim();
                        cmd.Parameters.Add("@NombreCentroFormacion", SqlDbType.Text).Value = txtNombreCentroFormacion.Text.ToString().Trim();
                        cmd.Parameters.Add("@Direccion", SqlDbType.Text).Value = txtDireccion.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdRegional", SqlDbType.Int).Value = Convert.ToInt32(ddlRegional.SelectedValue.ToString());
                        cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = Convert.ToInt32(ddlMunicipio.SelectedValue.ToString());
                        cmd.Parameters.Add("@Indicativo", SqlDbType.Int).Value = Convert.ToInt32(txtIndicativo.Text.ToString().Trim());
                        cmd.Parameters.Add("@Conmutador", SqlDbType.Text).Value = txtConmutador.Text.ToString().Trim();
                        cmd.Parameters.Add("@Extension", SqlDbType.Text).Value = txtExtension.Text.ToString().Trim();
                        cmd.Parameters.Add("@Fax", SqlDbType.Text).Value = txtFax.Text.ToString().Trim();
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
                        Alerta("Centro de Formación Agregado");
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

            grvCentroFormacion.SelectedIndex = -1;
        }

        private void Validar_Datos()
        {
            if (txtCodigoCentroFormacion.Text == String.Empty)
            {
                Alerta("Atención, debe Escribir el Código del Centro de Formación");
                txtCodigoCentroFormacion.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }

            if (txtNombreCentroFormacion.Text == String.Empty)
            {
                Alerta("Atención, debe Escribir el Nombre del Centro de Formación");
                txtNombreCentroFormacion.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }

            if (ddlDepartamento.SelectedIndex == 0)
            {
                Alerta("Atención, debe seleccionar el Departamento");
                ddlDepartamento.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }

            if (ddlMunicipio.SelectedIndex == 0)
            {
                Alerta("Atención, debe seleccionar el Municipio");
                ddlMunicipio.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Centros.aspx", false);
        }

        protected void grvCentroFormacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            BuscarCentroFormacion("", Convert.ToInt32(grvCentroFormacion.SelectedRow.Cells[1].Text));
        }

        protected void BuscarCentroFormacion(string  CodigoCentroFormacion, Int32 IdCentroFormacion)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_BuscarCentroFormacionXCodigoCentroFormacion]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = IdCentroFormacion;
                cmd.Parameters.Add("@CodigoCentroFormacion", SqlDbType.Text).Value =  CodigoCentroFormacion.ToString();
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfCentroFormacion.Value = reader[0].ToString();
                            txtCodigoCentroFormacion.Text = reader[1].ToString();
                            txtNombreCentroFormacion.Text = reader[2].ToString();
                            txtDireccion.Text = reader[3].ToString();
                            ddlRegional.SelectedValue = reader[4].ToString();
                            
                            ddlDepartamento.SelectedValue = reader[5].ToString();
                            LlenarMunicipio(Convert.ToInt32(reader[5].ToString()));
                            ddlMunicipio.SelectedValue = reader[6].ToString();

                            txtIndicativo.Text = reader[7].ToString();
                            txtConmutador.Text = reader[8].ToString();                            
                            txtExtension.Text = reader[9].ToString();
                            txtFax.Text = reader[10].ToString();

                            if (reader[11].ToString() == "")
                            {
                                chbEstadoEmergencia.Checked = false;
                            }
                            else
                            {
                                chbEstadoEmergencia.Checked = true;
                            }

                            if (reader[12].ToString() == "")
                            {
                                chbEsActivo.Checked = false;
                            }
                            else
                            {
                                chbEsActivo.Checked = true;
                            }

                            txtLinkWompi.Text = reader[13].ToString();
                            txtWompiPagosRapidos.Text = reader[14].ToString();
                            hfTransaccion.Value = "1";
                        }
                        lblEstado.Text = "Modificando";
                        btnBuscar.Enabled = false;
                        btnGuardar.Enabled = true;
                        con.Close();
                    }
                    else
                    {
                        Alerta("El Codigo del Centro Formacion No Existe");
                        txtCodigoCentroFormacion.Focus();
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
            grvCentroFormacion0.Visible = true;
            grvCentroFormacion0.Caption = "Centros De Formación";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvCentroFormacion0.AllowPaging = false;
            grvCentroFormacion0.AllowSorting = false;
            grvCentroFormacion0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvCentroFormacion0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "CentrosDeFormacion.xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvCentroFormacion0.Visible = false;
        }

        protected void ExportarTxt()
        {
            try
            {
                string PathArchivo = "CantrosDeFormacion_" + DateTime.Now.ToShortDateString().Replace("/", "_") + ".txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[dbo].[Usp_ExportarCentroFormacion]";
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

        protected void ddlMunicipio_DataBound(object sender, EventArgs e)
        {
            ddlMunicipio.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }
    }
}