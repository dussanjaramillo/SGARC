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
using WebLiquidador.App_Code;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.DireccionGeneral
{
    public partial class EntidadPublica : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                txtIdentificacion.Focus();
                ddlMunicipio.Items.Insert(0, new ListItem("Seleccione...", "-1"));
                lblEstado.Text = "Agregando";
            }
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

        protected void ddlSector_DataBound(object sender, EventArgs e)
        {
            ddlSector.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            if (txtIdentificacion.Text == String.Empty)
            {
                Alerta("Error, debe Escribir el numero de Identificacion");
                txtIdentificacion.Focus();
                return;
            }
            BuscarEntidadPublica(txtIdentificacion.Text);
            btnGuardar.Enabled = true;
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
                var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        int vResultado;
                        var Textocmd = "[dbo].[Usp_EntidadPublicaUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdEntidadPublica", SqlDbType.Int).Value = Convert.ToInt32(hfEntidadPublica.Value);
                        cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Convert.ToString(Convert.ToInt64(txtIdentificacion.Text.ToString().Trim()));
                        cmd.Parameters.Add("@Reciproco", SqlDbType.Text).Value = txtReciproco.Text.ToString().Trim();
                        cmd.Parameters.Add("@NombreEntidadPublica", SqlDbType.Text).Value = txtNombreEntidadPublica.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = Convert.ToInt32(ddlMunicipio.SelectedValue.ToString());
                        cmd.Parameters.Add("@Direccion", SqlDbType.Text).Value = txtDireccion.Text.ToString().Trim();
                        cmd.Parameters.Add("@Telefono", SqlDbType.Text).Value = txtTelefono.Text.ToString().Trim();
                        cmd.Parameters.Add("@Fax", SqlDbType.Text).Value = txtFax.Text.ToString().Trim();
                        cmd.Parameters.Add("@EMail", SqlDbType.Text).Value = txtEmail.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdSector", SqlDbType.Int).Value = Convert.ToInt32(ddlSector.SelectedValue.ToString());
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

                        Alerta("Entidad Publica Actualizada");
                    }
                    catch (SqlException ex)
                    {
                        Alerta("Error: " + ex.Message);
                    }
                }
            }
            else
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        var Textocmd = "[dbo].[Usp_EntidadPublicaInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdEntidadPublica", SqlDbType.Int).Value = DbType.Int32;
                        cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Convert.ToString(Convert.ToInt64(txtIdentificacion.Text.ToString().Trim()));
                        cmd.Parameters.Add("@Reciproco", SqlDbType.Text).Value = txtReciproco.Text.ToString().Trim();
                        cmd.Parameters.Add("@NombreEntidadPublica", SqlDbType.Text).Value = txtNombreEntidadPublica.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = Convert.ToInt32(ddlMunicipio.SelectedValue.ToString());
                        cmd.Parameters.Add("@Direccion", SqlDbType.Text).Value = txtDireccion.Text.ToString().Trim();
                        cmd.Parameters.Add("@Telefono", SqlDbType.Text).Value = txtTelefono.Text.ToString().Trim();
                        cmd.Parameters.Add("@Fax", SqlDbType.Text).Value = txtFax.Text.ToString().Trim();
                        cmd.Parameters.Add("@EMail", SqlDbType.Text).Value = txtEmail.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdSector", SqlDbType.Int).Value = Convert.ToInt32(ddlSector.SelectedValue.ToString());
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
                        Alerta("Entidad Publica Agregada");
                    }
                    catch (SqlException ex)
                    {
                        if (ex.Number == 2627)
                        {
                            //Alerta("Error: El Codigo y/o la Identificacion del Usuario ya Existe");
                            Alerta("Error: " + ex.Message.ToString());
                            return;
                        }
                        Alerta("Error: " + ex.Message.ToString());
                    }
                }
            }
            btnGuardar.Enabled = false;
        }

        private void Validar_Datos()
        {
            if (txtIdentificacion.Text == String.Empty)
            {
                Alerta("Atención, debe Escribir el numero de Identificación");
                txtIdentificacion.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }

            if (txtReciproco.Text == String.Empty)
            {
                Alerta("Atención, debe Escribir el Numero Reciproco");
                txtReciproco.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }

            if (txtNombreEntidadPublica.Text == String.Empty)
            {
                Alerta("Atención, debe Escribir el Nombre de la Entidad Publica");
                txtNombreEntidadPublica.Focus();
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

            if (txtEmail.Text != String.Empty)
            {
                ValidarCorreo CorreoValido = new ValidarCorreo();
                bool Valido = CorreoValido.email_bien_escrito(Convert.ToString(txtEmail.Text));

                if (!Valido)
                {
                    Alerta("Atención, El Correo no Tiene el Formato Adecuado");
                    txtEmail.Focus();
                    hfErrorValidacion.Value = "1";
                    return;
                }
            }

            if (ddlSector.SelectedIndex == 0)
            {
                Alerta("Atención, debe seleccionar el Sector");
                ddlSector.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/DireccionGeneral/EntidadPublica.aspx", false);
        }

        protected void grvEntidadPublica_SelectedIndexChanged(object sender, EventArgs e)
        {
            BuscarEntidadPublica(grvEntidadPublica.SelectedRow.Cells[2].Text);
        }

        protected void BuscarEntidadPublica(string Identificacion)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_BuscarEntidadPublica]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Identificacion.Trim();
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfEntidadPublica.Value = reader[0].ToString();
                            txtIdentificacion.Text = reader[1].ToString();
                            txtReciproco.Text = reader[2].ToString();
                            txtNombreEntidadPublica.Text = reader[3].ToString();

                            ddlDepartamento.SelectedValue = reader[13].ToString();
                            LlenarMunicipio(Convert.ToInt32(reader[13].ToString()));
                            ddlMunicipio.SelectedValue = reader[4].ToString();

                            txtDireccion.Text = reader[5].ToString();
                            txtTelefono.Text = reader[6].ToString();

                            txtFax.Text = reader[7].ToString();
                            txtEmail.Text = reader[8].ToString();
                            ddlSector.SelectedValue = reader[9].ToString();
                            chbEsActivo.Checked = Convert.ToBoolean(reader[10].ToString());
                            hfTransaccion.Value = "1";
                        }
                        con.Close();
                        lblEstado.Text = "Modificando";
                        btnBuscar.Enabled = false;
                        btnGuardar.Enabled = true;
                    }
                    else
                    {
                        Alerta("La Identificacion de la Entidad Pública No Existe");
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
            try
            {
                string PathArchivo = "EntidadPublica.txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[dbo].[Usp_ExportarEntidadPublica]";
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
                        else
                        {
                            Alerta("Alerta: No Hay Registros");
                            return;
                        }
                    }
                }

            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }

        }

    }
}