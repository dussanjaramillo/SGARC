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
    public partial class Deudor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            //if ((new List<string> { "1", "2", "3", "4", "6", "7", "8", "9" }).Contains(Session["_IdCargo"].ToString()))
            //{
            //    Response.Redirect("~/DefaultCf.aspx");
            //}

            if (!IsPostBack)
            {
                txtIdentificacion.Focus();
                ddlMunicipio.Items.Insert(0, new ListItem("Seleccione...", "-1"));
            }
            lblEstado.Text = "Agregando: "+ Session["_NombreRegionalUsuario"].ToString(); 
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

        protected void ddlMunicipio_DataBound(object sender, EventArgs e)
        {
            ddlMunicipio.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }
        
        protected void ddlDepartamento_DataBound(object sender, EventArgs e)
        {
            ddlDepartamento.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscarDeudor(txtIdentificacion.Text, 0);
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
                        var Textocmd = "[CostasProcesales].[Usp_DeudorUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdDeudor", SqlDbType.Int).Value = Convert.ToInt32(hfIdDeudor.Value); 
                        cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Convert.ToString(Convert.ToInt64(txtIdentificacion.Text.ToString().Trim()));
                        cmd.Parameters.Add("@Nombre", SqlDbType.Text).Value = txtNombre.Text.ToString().Trim();
                        
                        if (txtCorreo.Text == "")
                        {
                            cmd.Parameters.Add("@Correo", SqlDbType.Text).Value = System.DBNull.Value;
                        }
                        else
                        {
                            cmd.Parameters.Add("@Correo", SqlDbType.Text).Value = txtCorreo.Text.ToString().Trim();
                        }

                        if (txtCelular.Text == "")
                        {
                            cmd.Parameters.Add("@Celular", SqlDbType.Text).Value = System.DBNull.Value;
                        }
                        else
                        {
                            cmd.Parameters.Add("@Celular", SqlDbType.Text).Value = txtCelular.Text.ToString().Trim();
                        }

                        if (txtDireccion.Text == "")
                        {
                            cmd.Parameters.Add("@Direccion", SqlDbType.Text).Value = System.DBNull.Value;
                        }
                        else
                        {
                            cmd.Parameters.Add("@Direccion", SqlDbType.Text).Value = txtDireccion.Text.ToString().Trim();
                        }

                        if (ddlMunicipio.SelectedValue == "-1")
                        {
                            cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = System.DBNull.Value;
                        }
                        else
                        {
                            cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = Convert.ToInt32(ddlMunicipio.SelectedValue.ToString());
                        }

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

                        Alerta("Deudor Actualizado");
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
                        var Textocmd = "[CostasProcesales].[Usp_DeudorInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Convert.ToString(Convert.ToInt64(txtIdentificacion.Text.ToString().Trim()));
                        cmd.Parameters.Add("@Nombre", SqlDbType.Text).Value = txtNombre.Text.ToString().Trim();
                        if (txtCorreo.Text == "")
                        {
                            cmd.Parameters.Add("@Correo", SqlDbType.Text).Value = System.DBNull.Value;
                        }
                        else
                        {
                            cmd.Parameters.Add("@Correo", SqlDbType.Text).Value = txtCorreo.Text.ToString().Trim();
                        }

                        if (txtCelular.Text == "")
                        {
                            cmd.Parameters.Add("@Celular", SqlDbType.Text).Value = System.DBNull.Value;
                        }
                        else
                        {
                            cmd.Parameters.Add("@Celular", SqlDbType.Text).Value = txtCelular.Text.ToString().Trim();
                        }

                        if (txtDireccion.Text == "")
                        {
                            cmd.Parameters.Add("@Direccion", SqlDbType.Text).Value = System.DBNull.Value;
                        }
                        else
                        {
                            cmd.Parameters.Add("@Direccion", SqlDbType.Text).Value = txtDireccion.Text.ToString().Trim();
                        }

                        if (ddlMunicipio.SelectedValue == "-1")
                        {
                            cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = System.DBNull.Value;
                        }
                        else
                        {
                            cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = Convert.ToInt32(ddlMunicipio.SelectedValue.ToString());
                        }

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
                        Alerta("Deudor Agregado");
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

            grvDeudor.SelectedIndex = -1;
            grvDeudor.DataSource = null;
            grvDeudor.DataBind();
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

            if (txtNombre.Text == String.Empty)
            {
                Alerta("Atención, debe Escribir el Nombre y Apellidos del Deudor");
                txtNombre.Focus();
                txtNombre.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                return;
            }

            if (txtCelular.Text != String.Empty)
            {
                if (txtCelular.Text.Length != 10)
                {
                    Alerta("Atención, el Número del celular debe tener 10 Digitos");
                    txtCelular.Focus();
                    txtCelular.BackColor = System.Drawing.Color.Aqua;
                    hfErrorValidacion.Value = "1";
                    return;
                }
            }
            txtCelular.BackColor = System.Drawing.Color.Empty;


            if ((txtDireccion.Text != String.Empty) && ((ddlDepartamento.SelectedValue == "-1") || (ddlMunicipio.SelectedValue == "-1")))
            {
                Alerta("Atención, debe Seleccionar el Departamento y el Municipio");
                ddlDepartamento.BackColor = System.Drawing.Color.Aqua;
                ddlMunicipio.BackColor = System.Drawing.Color.Aqua;
                ddlDepartamento.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }
            ddlDepartamento.BackColor = System.Drawing.Color.Empty;
            ddlMunicipio.BackColor = System.Drawing.Color.Empty;

            if (txtCorreo.Text.Trim() != String.Empty)
            {
                ValidarCorreo CorreoValido = new ValidarCorreo();
                bool Valido = CorreoValido.email_bien_escrito(Convert.ToString(txtCorreo.Text));

                if (!Valido)
                {
                    Alerta("Atención, introduzca una dirección de correo electrónico válida: ejemplo@dominio.com");
                    txtCorreo.Focus();
                    txtCorreo.BackColor = System.Drawing.Color.Aqua;
                    hfErrorValidacion.Value = "1";
                    return;
                }
            }
            txtCorreo.BackColor = System.Drawing.Color.Empty;
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/CostasProcesales/Deudor/Deudor.aspx", false);
        }

        protected void BuscarDeudor(string  Identificacion, Int32 IdDeudor)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CostasProcesales].[Usp_BuscarDeudor]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdDeudor", SqlDbType.Int).Value = IdDeudor;
                cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value =  Identificacion.ToString();
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfIdDeudor.Value = reader[0].ToString();
                            txtIdentificacion.Text = reader[1].ToString();
                            txtNombre.Text = reader[2].ToString();
                            txtCorreo.Text = reader[3].ToString();
                            txtCelular.Text = reader[4].ToString();
                            txtDireccion.Text = reader[5].ToString();
                            
                            if (reader[7].ToString() == "")
                            {
                                ddlDepartamento.SelectedValue = "-1";
                                ddlMunicipio.SelectedValue = "-1";
                            }
                            else
                            {
                                ddlDepartamento.SelectedValue = reader[7].ToString();
                                LlenarMunicipio(Convert.ToInt32(reader[7].ToString()));
                                ddlMunicipio.SelectedValue = reader[6].ToString();
                            }

                            if (reader[9].ToString() == "")
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
                        Alerta("La Identificacion del Deudor No Existe");
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
            grvDeudor0.Visible = true;
            grvDeudor0.Caption = "Deudores Costas Procesales";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvDeudor0.AllowPaging = false;
            grvDeudor0.AllowSorting = false;
            grvDeudor0.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvDeudor0);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "DeudoresCostasProcesales.xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvDeudor0.Visible = false;
        }

        protected void ExportarTxt()
        {
            try
            {
                string PathArchivo = "DeudoresCostasProcesales_" + DateTime.Now.ToShortDateString().Replace("/", "_") + ".txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[CostasProcesales].[Usp_BuscarDeudor_]";
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

        protected void grvDeudor_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfIdDeudor.Value = grvDeudor.SelectedRow.Cells[1].Text;
            hfTransaccion.Value = "1";
            BuscarDeudor("",Convert.ToInt32(hfIdDeudor.Value));
        }
    }
}