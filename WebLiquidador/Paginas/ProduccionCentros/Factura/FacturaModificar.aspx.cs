using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using WebLiquidador.App_Code;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Factura
{
    public partial class FacturaModificar : System.Web.UI.Page
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
                Response.Redirect("~/DefaultCf.aspx");
            }

            if (!IsPostBack)
            {
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Factura/FacturaModificar.aspx", false);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (txtContacto.Text.Trim() != String.Empty)
            {
                ValidarCorreo CorreoValido = new ValidarCorreo();
                bool Valido = CorreoValido.email_bien_escrito(Convert.ToString(txtContacto.Text));

                if (!Valido)
                {
                    Alerta("Atención, introduzca una dirección de correo electrónico válida: ejemplo@dominio.com");
                    txtContacto.Focus();
                    hfErrorValidacion.Value = "1";
                    return;
                }
            }

            if (ddlTipoCliente.SelectedValue == "-1")
            {
                Alerta("Atención: Error Debe Especificar el Tipo de Cliente");
                ddlTipoCliente.Focus();
                return;
            }

            if (Convert.ToInt64(txtIdentificacion.Text) == Convert.ToInt64(Session["_CodigoCentroFormacion"].ToString()))
            {
                Alerta("!!!Atención!!!: Error en la Identificacion");
                txtIdentificacion.Focus();
                return;
            }

            if (txtIdentificacion.Text.Substring(0, 1) == "9" || txtIdentificacion.Text.Substring(0, 1) == "8")
            {
                if (txtIdentificacion.Text.Length > 9)
                {
                    Alerta("!!!Atención!!!: La Identificación en un NIT, Debe Tener 9 Digitos");
                    txtIdentificacion.Focus();
                    return;
                }
            }

            if (txtIdentificacion.Text.Substring(1, 5) == "22222")
            {
                Alerta("!!!Atención!!!: Error en la Identificacion");
                txtIdentificacion.Focus();
                return;
            }

            if (txtContacto.Text.Trim() != String.Empty)
            {
                ValidarCorreo CorreoValido = new ValidarCorreo();
                bool Valido = CorreoValido.email_bien_escrito(Convert.ToString(txtContacto.Text));

                if (!Valido)
                {
                    Alerta("Atención, introduzca una dirección de correo electrónico válida: ejemplo@dominio.com");
                    txtContacto.Focus();
                    hfErrorValidacion.Value = "1";
                    return;
                }
            }

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_FacturaUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@NumeroFactura", SqlDbType.BigInt).Value = Convert.ToInt64(hfNumeroFactura.Value);
                    cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = txtIdentificacion.Text.Trim();
                    cmd.Parameters.Add("@Nombre", SqlDbType.Text).Value = txtNombre.Text.Trim();
                    cmd.Parameters.Add("@Direccion", SqlDbType.Text).Value = txtDireccion.Text.Trim();
                    cmd.Parameters.Add("@Telefono", SqlDbType.Text).Value = txtTelefono.Text.Trim();
                    cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = Convert.ToInt16(ddlMunicipio.SelectedValue);
                    cmd.Parameters.Add("@Contacto", SqlDbType.Text).Value = txtContacto.Text.Trim();

                    if (txtReferencia.Text == "")
                    {
                        cmd.Parameters.Add("@Referencia", SqlDbType.Text).Value = System.DBNull.Value;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Referencia", SqlDbType.Text).Value = txtReferencia.Text.Trim();
                    }
                    cmd.Parameters.Add("@IdTipoCliente", SqlDbType.Int).Value = Convert.ToInt32(ddlTipoCliente.SelectedValue);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    grvFacturaXCentro.SelectedIndex = -1;
                    btnGuardar.Enabled = false;

                    txtIdentificacion.Text = "";
                    txtNombre.Text = "";
                    txtDireccion.Text = "";
                    txtTelefono.Text = "";
                    txtContacto.Text = "";
                    txtReferencia.Text = "";
                    ddlDepartamento.SelectedValue = "-1";
                    ddlMunicipio.SelectedValue = "-1";
                    ddlTipoCliente.SelectedValue = "-1";
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
            grvFacturaXCentro.DataSource = null;

            Alerta("Atención!!!!:" + Session["_NombreUsuario"].ToString() + " Usted debe Imprimir de Nuevo la Prefactura");
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

        protected void ddlDepartamento_DataBound(object sender, EventArgs e)
        {
            ddlDepartamento.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void grvFacturaXCentro_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (grvFacturaXCentro.Rows.Count == 0)
                {
                    Alerta("No Hay Prefacturas para su Centro");
                    return;
                }
            }
        }

        protected void grvFacturaXCentro_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfNumeroFactura.Value = grvFacturaXCentro.SelectedRow.Cells[1].Text;
            if (Convert.ToInt32(Session["_IdCentroFormacion"].ToString())  == 118)
            {
                grvFacturaXCentro.SelectedIndex = -1;
                Alerta("Error: Lo Siento ésta Prefactura no puede ser modificada por Usted");
                return;
            }

            if (grvFacturaXCentro.SelectedRow.Cells[8].Text == "Si")
            {
                grvFacturaXCentro.SelectedIndex = -1;
                Alerta("Error: Lo Siento ésta Prefactura no se puede Modificar");
                return;
            }
            if (grvFacturaXCentro.SelectedRow.Cells[9].Text == "Si")
            {
                grvFacturaXCentro.SelectedIndex = -1;
                Alerta("Error: Lo Siento ésta Prefactura no se puede Modificar");
                return;
            }
            Buscarfactura(Convert.ToInt64(hfNumeroFactura.Value));

            if (ddlTipoCliente.SelectedValue == "3" && (txtIdentificacion.Text == "899999034" || txtIdentificacion.Text == "8999990341"))
            {
                Alerta("Error: Lo Siento ésta Prefactura no se puede Modificar");
                ddlTipoCliente.Focus();
                return;
            }
            ddlTipoCliente.Focus();
            btnGuardar.Enabled = true;
        }

        private void Buscarfactura(Int64 NumeroFactura)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarFacturaXNumeroFacturaUpdate]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@NumeroFactura", SqlDbType.BigInt).Value = NumeroFactura;
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            txtIdentificacion.Text = reader[0].ToString();
                            txtNombre.Text = reader[1].ToString();
                            txtDireccion.Text = reader[2].ToString();
                            txtTelefono.Text = reader[3].ToString();
                            ddlDepartamento.SelectedValue = reader[5].ToString();
                            LlenarMunicipio(Convert.ToInt16(reader[5].ToString()));

                            ddlMunicipio.SelectedValue = reader[4].ToString();
                            txtContacto.Text = reader[6].ToString();
                            txtReferencia.Text = reader[7].ToString();
                            ddlTipoCliente.SelectedValue = reader[8].ToString();
                        }
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }

            //grvFacturaXCentro.DataSource = SdsFacturasXCentro;
            //grvFacturaXCentro.DataBind();
        }

        protected void ddlTipoCliente_DataBound(object sender, EventArgs e)
        {
            ddlTipoCliente.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }
    }
}