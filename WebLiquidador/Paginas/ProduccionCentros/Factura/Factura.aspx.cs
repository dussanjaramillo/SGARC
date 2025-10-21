using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Drawing;
using WebLiquidador.App_Code;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Factura
{
    public partial class Factura : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }
            //Cargo
            //1 Coordinador
            //2 Abogado
            //3 Fiscalizador
            //4 Técnico
            //5 Administrador
            //6 Profesional
            //7 Siif - Nación
            //8 Subdirector
            //9 Producción

            if ((new List<string> { "1", "2", "3", "4", "6", "7", "8" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
                return;
            }

            if (!IsPostBack)
            {
                Session.Remove("_ListaProductos");
                grvProductosCentro.DataSource = null;
                grvProductosCentro.DataBind();

                //txtIdentificacion.Text = "899999034";
                //txtNombre.Text = Session["_NombreCentroFormacion"].ToString();
                //txtDireccion.Text = Session["_DireccionCentroFormacion"].ToString();
                //txtTelefono.Text = Session["_TelefonoCentroFormacion"].ToString();
                //ddlDepartamento.SelectedValue = Session["_IdDepartamentoCentroFormacion"].ToString();
                //LlenarMunicipio(Convert.ToInt32(Session["_IdDepartamentoCentroFormacion"].ToString()));
                //ddlMunicipio.SelectedValue = Session["_IdMunicipioCentroFormacion"].ToString();

                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
                BuscarControlCentroFormacion();
                txtIdentificacion.Focus();
            }
        }

        protected void ddlProducto_DataBound(object sender, EventArgs e)
        {
            ddlProducto.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlUnidadMedida_DataBound(object sender, EventArgs e)
        {
            ddlUnidadMedida.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlProducto.SelectedValue == "-1")
            {
                txtPrecio.Text = "";
                txtCantidad.Text = "";
                txtPrecio.Enabled = false;
                txtCantidad.Enabled = false;
                ddlUnidadMedida.SelectedIndex = -1;
                txtPrecioMaximo.Text = "";
                txtPrecioMinimo.Text = "";
                return;
            }
            BuscarProducto(Convert.ToInt32(ddlProducto.SelectedValue));
            txtPrecio.Enabled = true;
            txtCantidad.Enabled = true;
            btnAgregar.Enabled = true;
            txtPrecio.Focus();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Factura/Factura.aspx", false);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!IsValid)
            {
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

            if (Convert.ToInt64(txtIdentificacion.Text) < 1000)
            {
                Alerta("!!!Atención!!!: Error en la Identificacion");
                txtIdentificacion.Focus();
                return;
            }

            if (txtIdentificacion.Text.Substring(1,5) == "22222")
            {
                Alerta("!!!Atención!!!: Error en la Identificacion");
                txtIdentificacion.Focus();
                return;
            }

            if (ddlTipoCliente.SelectedValue == "-1")
            {
                Alerta("!!!Atención!!!: Falta el Tipo de Cliente");
                ddlTipoCliente.Focus();
                return;
            }

            if (ddlTipoCliente.SelectedValue == "3" && (txtIdentificacion.Text == "899999034" || txtIdentificacion.Text == "8999990341"))
            {
                Alerta("Atención: El Número de Identificación No Es Permitido para este Tipo de Cliente");
                ddlTipoCliente.Focus();
                return;
            }

            GrabarNumeroFactura();

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_FacturaInsert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@NumeroFactura", SqlDbType.BigInt).Value = Convert.ToInt64(Session["_Numerofactura"].ToString());
                    cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());

                    if (txtIdentificacion.Text == "")
                    {
                        cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = System.DBNull.Value;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Convert.ToString(Convert.ToInt64(txtIdentificacion.Text.ToString().Trim()));
                    }

                    if (txtNombre.Text == "")
                    {
                        cmd.Parameters.Add("@Nombre", SqlDbType.Text).Value = System.DBNull.Value;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Nombre", SqlDbType.Text).Value = txtNombre.Text.Trim();
                    }

                    if (txtDireccion.Text == "")
                    {
                        cmd.Parameters.Add("@Direccion", SqlDbType.Text).Value = System.DBNull.Value;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Direccion", SqlDbType.Text).Value = txtDireccion.Text.Trim();
                    }

                    if (txtTelefono.Text == "")
                    {
                        cmd.Parameters.Add("@Telefono", SqlDbType.Text).Value = System.DBNull.Value;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Telefono", SqlDbType.Text).Value = txtTelefono.Text.Trim();
                    }

                    if (ddlMunicipio.SelectedValue == "")
                    {
                        cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = System.DBNull.Value;
                    }
                    else
                    {
                        cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = Convert.ToInt32(ddlMunicipio.SelectedValue);
                    }

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
                    cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    SqlParameter outputIdParam = new SqlParameter("@IdFactura", SqlDbType.Int) { Direction = ParameterDirection.Output };
                    cmd.Parameters.Add(outputIdParam);

                    int vResultado;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    vResultado = Convert.ToInt32(cmd.Parameters["@IdFactura"].Value);
                    con.Close();
                    Session["_IdFactura"] = vResultado.ToString();
                    Grabar_FacturaDetalle();
                    Alerta("Prefactura Guardada Correctamente");
                    btnGuardar.Enabled = false;
                    btnAgregar.Enabled = false;
                    btnImprimir.Enabled = true;
                    btnImprimir.ForeColor = Color.White;
                    btnImprimir.BackColor = Color.DarkCyan;
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

        protected void Grabar_FacturaDetalle()
        {
            if (!IsValid)
            {
                return;
            }

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_FacturaDetalleInsert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();

                    foreach (GridViewRow row in grvProductosCentro.Rows)
                    {
                        cmd.Parameters.Clear();

                        cmd.Parameters.Add("@IdFactura", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdFactura"].ToString());
                        cmd.Parameters.Add("@IdProducto", SqlDbType.Int).Value = Convert.ToInt32(row.Cells[2].Text);

                        hfCantidad.Value = row.Cells[4].Text;
                        hfCantidad.Value = hfCantidad.Value.Replace(",", "");
                        hfCantidad.Value = hfCantidad.Value.Replace(".", "");
                        cmd.Parameters.Add("@Cantidad", SqlDbType.Int).Value = Convert.ToInt32(hfCantidad.Value);

                        hfPrecio.Value = row.Cells[5].Text;
                        hfPrecio.Value = hfPrecio.Value.Replace(",", "");
                        hfPrecio.Value = hfPrecio.Value.Replace(".", "");
                        cmd.Parameters.Add("@Precio", SqlDbType.BigInt).Value = Convert.ToInt64(hfPrecio.Value);
                        cmd.Parameters.Add("@IdUnidadMedida", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[7].Text);

                        cmd.ExecuteNonQuery();
                    }
                    con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                    return;
                }
            }
        }

        protected void GrabarNumeroFactura()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    long vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_NumeroFacturaUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    SqlParameter outputIdParam = new SqlParameter("@NumeroFactura", SqlDbType.BigInt) { Direction = ParameterDirection.Output };
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(outputIdParam);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    vResultado = Convert.ToInt64(cmd.Parameters["@NumeroFactura"].Value);
                    con.Close();
                    Session["_Numerofactura"] = vResultado.ToString();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        private void Validar_Datos()
        {
            if (txtPrecioMaximo.Text != "")
            {
                if (Convert.ToInt32(txtPrecioMaximo.Text) < Convert.ToInt32(txtPrecioMinimo.Text))
                {
                    Alerta("Error, el Precio Maximo debe ser Igual o Mayor al Precio Minimo");
                    txtPrecioMaximo.Focus();
                    hfErrorValidacion.Value = "1";
                    return;
                }
            }
        }

        private void BuscarProducto(int Producto)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_BuscarCentroFormacionXProducto]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                cmd.Parameters.Add("@IdProducto", SqlDbType.Int).Value = Producto;
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            txtPrecioMinimo.Text = reader[1].ToString();
                            txtPrecioMaximo.Text = reader[2].ToString();
                            ddlUnidadMedida.SelectedValue = reader[3].ToString();
                        }
                        con.Close();
                        txtCantidad.Text = "1";

                        btnAgregar.Enabled = true;
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        private void BuscarControlCentroFormacion()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarControlCentroFormacion]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfPlazoMaximo.Value = reader[2].ToString();
                            hfCantidadMaxima.Value = reader[3].ToString();
                        }
                        con.Close();
                    }
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

        protected void ddlUnidadMedida_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnGuardar.Enabled = true;
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            BuscarProducto(Convert.ToInt32(hfdIdProducto.Value));

            ddlProducto.SelectedValue = hfdIdProducto.Value;
            ddlProducto.Enabled = false;
            txtPrecio.Focus();

            txtCantidad.Text = grvProductosCentro.SelectedRow.Cells[4].Text;
            txtPrecio.Text = grvProductosCentro.SelectedRow.Cells[5].Text;

            btnBorrar.Enabled = false;
            btnBorrar.ForeColor = Color.Empty;
            btnBorrar.BackColor = Color.Empty;

            btnActualizar.Enabled = false;
            btnActualizar.ForeColor = Color.Empty;
            btnActualizar.BackColor = Color.Empty;

            btnActualizar.Visible = false;
            btnAgregar.Enabled = false;
            btnActualizaProducto.Visible = true;

            txtPrecio.Enabled = true;
            txtCantidad.Enabled = true;
            txtPrecio.Focus();
        }

        protected void btnActualizaProducto_Click(object sender, EventArgs e)
        {
            if (txtPrecio.Text == "" || Convert.ToInt32(txtPrecio.Text) == 0)
            {
                Alerta("Atención: la Cantidad de Apoyo no puede estar Vacia o Cero ");
                txtCantidad.Focus();
                return;
            }

            if (Convert.ToInt32(txtPrecio.Text) > Convert.ToInt32(txtPrecioMaximo.Text))
            {
                Alerta("Error, el Precio de Venta debe ser Igual o Menor al Precio Máximo");
                txtPrecio.Focus();
                return;
            }

            if (Convert.ToInt32(txtPrecio.Text) < Convert.ToInt32(txtPrecioMinimo.Text))
            {
                Alerta("Error, el Precio de Venta debe ser Igual o Mayor al Precio Mínimo");
                txtPrecio.Focus();
                return;
            }

            if (txtCantidad.Text == "" || Convert.ToInt32(txtCantidad.Text) == 0)
            {
                Alerta("Atención: la Cantidad no puede estar Vacia o Cero");
                txtCantidad.Focus();
                return;
            }

            if (Convert.ToInt32(txtCantidad.Text) > Convert.ToInt32(hfCantidadMaxima.Value))
            {
                Alerta("Error, la Cantidad debe ser Menor o Igual a: " + hfCantidadMaxima.Value);
                txtPrecio.Focus();
                return;
            }

            ddlProducto.Enabled = false;
            List<ProductosFactura> Producto = (List<ProductosFactura>)Session["_ListaProductos"];

            Producto.RemoveAt(Convert.ToInt32(hfdItem.Value));
            Int64 WValor = Convert.ToInt64(txtPrecio.Text) * Convert.ToInt64(txtCantidad.Text);
            Producto.Insert(Convert.ToInt32(hfdItem.Value), new ProductosFactura() { Item = Convert.ToInt32(hfdItem.Value), IdProducto = Convert.ToInt32(ddlProducto.SelectedValue), Nombre = ddlProducto.SelectedItem.ToString(), Cantidad = Convert.ToInt32(txtCantidad.Text), Precio = Convert.ToInt64(txtPrecio.Text), Valor = WValor, IdUnidadMedida = Convert.ToInt32(ddlUnidadMedida.SelectedValue), NombreUnidadMedida = ddlUnidadMedida.SelectedItem.ToString() });

            grvProductosCentro.DataSource = Producto;
            grvProductosCentro.DataBind();

            btnBorrar.Enabled = false;
            btnBorrar.ForeColor = Color.Empty;
            btnBorrar.BackColor = Color.Empty;

            btnActualizar.Enabled = false;
            btnActualizar.ForeColor = Color.Empty;
            btnActualizar.BackColor = Color.Empty;

            btnGuardar.Enabled = true;
            btnAgregar.Enabled = true;

            txtPrecio.Text = "";
            txtCantidad.Text = "";
            ddlProducto.SelectedIndex = -1;
            txtPrecioMinimo.Text = "";
            txtPrecioMaximo.Text = "";
            grvProductosCentro.SelectedIndex = -1;
            ddlProducto.Enabled = true;
            btnActualizaProducto.Visible = false;
            btnActualizar.Visible = true;
            decimal TotalFactura = Producto.Sum(Tf => Tf.Valor);
            txtValorFactura.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(TotalFactura.ToString()));
        }

        protected void btnBorrar_Click(object sender, EventArgs e)
        {
            List<ProductosFactura> Producto = (List<ProductosFactura>)Session["_ListaProductos"];
            Producto.RemoveAt(Convert.ToInt16(hfdItem.Value));

            int WItem = 0;
            foreach (ProductosFactura o in Producto)
            {
                o.Item = WItem;
                WItem = WItem + 1;
            }

            grvProductosCentro.DataSource = Producto;
            grvProductosCentro.DataBind();

            btnBorrar.Enabled = false;
            btnBorrar.ForeColor = Color.Empty;
            btnBorrar.BackColor = Color.Empty;

            btnActualizar.Enabled = false;
            btnActualizar.ForeColor = Color.Empty;
            btnActualizar.BackColor = Color.Empty;

            txtPrecio.Text = "";
            txtCantidad.Text = "";
            ddlProducto.SelectedIndex = -1;
            txtPrecioMinimo.Text = "";
            txtPrecioMaximo.Text = "";

            ddlProducto.Enabled = true;
            btnGuardar.Enabled = true;
            btnAgregar.Enabled = true;
            grvProductosCentro.SelectedIndex = -1;

            decimal TotalFactura = Producto.Sum(Tf => Tf.Valor);
            txtValorFactura.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(TotalFactura.ToString()));
            GlobalData.ItemFactura = GlobalData.ItemFactura - 1;
        }

        protected void grvProductosCentro_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfdItem.Value = grvProductosCentro.SelectedRow.Cells[1].Text;
            hfdIdProducto.Value = grvProductosCentro.SelectedRow.Cells[2].Text;

            btnAgregar.Enabled = false;
            btnGuardar.Enabled = false;

            btnBorrar.Enabled = true;
            btnBorrar.ForeColor = Color.White;
            btnBorrar.BackColor = Color.DarkCyan;

            btnActualizar.Enabled = true;
            btnActualizar.ForeColor = Color.White;
            btnActualizar.BackColor = Color.DarkCyan;
        }

        protected void ddlDepartamento_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!ddlDepartamento.SelectedIndex.Equals(-1))
            {
                ddlProducto.Enabled = true;
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

        public static class GlobalData
        {
            public static int ItemFactura;
        }

        protected void DeshabilitarCampos()
        {
            txtIdentificacion.Enabled = false;
            txtNombre.Enabled = false;
            txtDireccion.Enabled = false;
            txtTelefono.Enabled = false;
            txtReferencia.Enabled = false;
            txtContacto.Enabled = false;
            ddlDepartamento.Enabled = false;
            ddlMunicipio.Enabled = false;
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
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

            if (txtIdentificacion.Text.Substring(0,1) == "9" || txtIdentificacion.Text.Substring(0,1) == "8")
            {
                if (txtIdentificacion.Text.Length > 9 )
                {
                    Alerta("!!!Atención!!!: La Identificación en un NIT, Debe Tener 9 Digitos");
                    txtIdentificacion.Focus();
                    return;
                }
            }

            if (Convert.ToInt64(txtIdentificacion.Text) < 1000)
            {
                Alerta("!!!Atención!!!: Error en la Identificacion");
                txtIdentificacion.Focus();
                return;
            }

            if (Convert.ToInt64(txtIdentificacion.Text) == Convert.ToInt64(Session["_CodigoCentroFormacion"].ToString()))
            {
                Alerta("!!!Atención!!!: Error en la Identificacion");
                txtIdentificacion.Focus();
                return;
            }

            ddlTipoCliente.Enabled = false;

            if (txtNombre.Text.ToLower() == "sena")
            {
                txtNombre.Text = lblEstado.Text;
            }

            if (ddlTipoCliente.SelectedValue == "3" && (txtIdentificacion.Text == "899999034" || txtIdentificacion.Text == "8999990341"))
            {
                Alerta("Atención: El Número de Identificación: "+txtIdentificacion.Text +" No Es Permitido para este Tipo de Cliente");
                ddlTipoCliente.Focus();
                return;
            }

            if (txtCantidad.Text == "" || Convert.ToInt32(txtCantidad.Text) == 0)
            {
                Alerta("Atención: la Cantidad no puede estar Vacia o Cero");
                txtCantidad.Focus();
                return;
            }

            if (Convert.ToInt64(txtPrecio.Text) <= 0)
            {
                Alerta("Atención: El Precio de venta no puede ser menor o igual a Cero");
                txtPrecio.Focus();
                return;
            }

            if (Convert.ToInt64(txtPrecio.Text) < Convert.ToInt64(txtPrecioMinimo.Text))
            {
                Alerta("Atención: El Precio de venta no puede ser Menor a: " + txtPrecioMinimo.Text);
                txtPrecio.Focus();
                return;
            }

            if (Convert.ToInt64(txtPrecio.Text) > Convert.ToInt64(txtPrecioMaximo.Text))
            {
                Alerta("Atención: El Precio de venta no puede ser Mayor a: " + txtPrecioMaximo.Text);
                txtPrecio.Focus();
                return;
            }

            if (Convert.ToInt32(txtCantidad.Text) > Convert.ToInt32(hfCantidadMaxima.Value))
            {
                Alerta("Atención: la Cantidad del Producto no puede ser Mayor a: " + hfCantidadMaxima.Value);
                txtCantidad.Focus();
                return;
            }

            if (Convert.ToInt32(txtCantidad.Text) <= 0)
            {
                Alerta("Atención: la Cantidad del Producto debe ser Mayor o Igual a: 1 ");
                txtCantidad.Focus();
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

            List<ProductosFactura> Producto = (List<ProductosFactura>)Session["_ListaProductos"];

            if (Producto == null)
            {
                DeshabilitarCampos();
                Producto = new List<ProductosFactura>();
                GlobalData.ItemFactura = 0;
                btnGuardar.Enabled = true;
            }

            // Verifica que el producto y el precio no existan

            if (Producto.Exists(x => x.IdProducto == Convert.ToInt32(ddlProducto.SelectedValue) && x.Precio == Convert.ToInt64(txtPrecio.Text)))
            {
                txtPrecio.Enabled = false;
                txtCantidad.Enabled = false;
                ddlProducto.Enabled = false;
                Alerta("Atención: El Producto y el Precio ya Existe debe: Seleccionar el Producto y Modificar la Cantidad");
                return;
            }

            Int64 WValor = Convert.ToInt64(txtPrecio.Text) * Convert.ToInt64(txtCantidad.Text);
            Producto.Insert(GlobalData.ItemFactura, new ProductosFactura() { Item = GlobalData.ItemFactura, IdProducto = Convert.ToInt32(ddlProducto.SelectedValue), Nombre = ddlProducto.SelectedItem.ToString(), Cantidad = Convert.ToInt32(txtCantidad.Text), Precio = Convert.ToInt64(txtPrecio.Text), Valor = WValor, IdUnidadMedida = Convert.ToInt32(ddlUnidadMedida.SelectedValue), NombreUnidadMedida = ddlUnidadMedida.SelectedItem.ToString() });

            GlobalData.ItemFactura = GlobalData.ItemFactura + 1;

            Session.Add("_ListaProductos", Producto);
            grvProductosCentro.DataSource = Producto;
            grvProductosCentro.DataBind();

            txtPrecio.Text = "";
            txtCantidad.Text = "";
            ddlProducto.SelectedIndex = -1;
            ddlUnidadMedida.SelectedIndex = -1;
            txtPrecioMinimo.Text = "";
            txtPrecioMaximo.Text = "";

            txtPrecio.Enabled = false;
            txtCantidad.Enabled = false;

            decimal TotalFactura = Producto.Sum(Tf => Tf.Valor);
            txtValorFactura.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(TotalFactura.ToString()));
        }

        protected void btnImprimir_Click(object sender, EventArgs e)
        {
            List<ProductosFactura> Producto = (List<ProductosFactura>)Session["_ListaProductos"];
            decimal TotalFactura = Producto.Sum(pkg => pkg.Valor);
            Conversion EnLetras = new Conversion();
            string Monto = EnLetras.enletras(Convert.ToString(TotalFactura));

            Session["_ValorTotalLetras"] = Monto + " Pesos M/Cte";
            Session["_FacturaAnulada"] = "Tipo Cliente: " + ddlTipoCliente.SelectedItem.ToString() + " - Pendiente de Pago";
            btnImprimir.Visible = true;

            btnGuardar.Enabled = false;
            Session["_Opcion"] = "1";

            //string DatosQr = Session["_Numerofactura"].ToString() + "|" + Session["_FacturaAnulada"].ToString() + "|Valor:" + TotalFactura.ToString();
            //GenerarQr ImagenQr = new GenerarQr();
            //string ImagenOk = ImagenQr.Qr(Session["_Numerofactura"].ToString(), DatosQr);

            Response.Redirect("~/Paginas/ProduccionCentros/Factura/Reportes/VisorFactura.aspx", false);
        }

        protected void ValidarIdentificacion()
        {
            DigitoVerificacion DigitoVerificacion = new DigitoVerificacion();
            string Digito = DigitoVerificacion.Dv(txtIdentificacion.Text);
        }

        protected void ddlTipoCliente_DataBound(object sender, EventArgs e)
        {
            ddlTipoCliente.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlTipoCliente_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnAgregar.Enabled = false;

            if (ddlTipoCliente.SelectedValue == "1")
            {//Sena Proveedor Sena
                txtIdentificacion.Text = "899999034";
                txtIdentificacion.Enabled = false;
                txtNombre.Text = "";
                txtDireccion.Text = "";
                txtTelefono.Text = "";
                txtReferencia.Text = "";
                ddlDepartamento.SelectedIndex = -1;
                ddlMunicipio.SelectedIndex = -1;

                txtNombre.Enabled = true;
                txtNombre.Attributes.Add("placeholder", "Centro Qué Compra");
                txtContacto.Attributes.Add("placeholder", "Correo Electrónico");
                txtReferencia.Attributes.Add("placeholder", "Contacto y/o Referencia");
                txtDireccion.Enabled = true;
                txtTelefono.Enabled = true;
                ddlDepartamento.Enabled = true;
                ddlMunicipio.Enabled = true;
                txtContacto.Text = ConfigurationManager.AppSettings["CorreoProduccion"].ToString();
                txtContacto.Enabled = false;
                txtReferencia.Enabled = true;
                ddlProducto.Enabled = false;
                btnAgregar.Enabled = false;
                txtNombre.Focus();
            }

            if (ddlTipoCliente.SelectedValue == "2")
            {//Sena AutoConsumo
                txtIdentificacion.Text = "899999034";
                txtNombre.Text = Session["_NombreCentroFormacion"].ToString();
                txtDireccion.Text = Session["_DireccionCentroFormacion"].ToString();
                txtTelefono.Text = Session["_TelefonoCentroFormacion"].ToString();
                ddlDepartamento.SelectedValue = Session["_IdDepartamentoCentroFormacion"].ToString();
                LlenarMunicipio(Convert.ToInt32(Session["_IdDepartamentoCentroFormacion"].ToString()));
                ddlMunicipio.SelectedValue = Session["_IdMunicipioCentroFormacion"].ToString();

                txtIdentificacion.Enabled = false;
                txtNombre.Enabled = false;
                txtDireccion.Enabled = false;
                txtTelefono.Enabled = false;
                ddlDepartamento.Enabled = false;
                ddlMunicipio.Enabled = false;

                //txtContacto.Text = "produccioncentros@sena.edu.co";
                txtContacto.Text = ConfigurationManager.AppSettings["CorreoProduccion"].ToString();

                txtReferencia.Text = "";
                txtContacto.Enabled = false;
                txtReferencia.Enabled = true;

                txtContacto.Attributes.Add("placeholder", "Correo Electrónico");
                txtReferencia.Attributes.Add("placeholder", "Contacto y/o Referencia");

                ddlProducto.Enabled = true;
                btnAgregar.Enabled = true;
                txtContacto.Focus();
            }

            if (ddlTipoCliente.SelectedValue == "3")
            {//Particular
                txtIdentificacion.Enabled = true;
                txtNombre.Enabled = true;
                txtDireccion.Enabled = true;
                txtTelefono.Enabled = true;
                ddlDepartamento.Enabled = true;
                ddlMunicipio.Enabled = true;

                txtContacto.Enabled = true;
                txtReferencia.Enabled = true;

                txtIdentificacion.Text = "";
                txtNombre.Text = "";
                txtDireccion.Text = "";
                txtTelefono.Text = "";
                txtContacto.Text = "";
                txtReferencia.Text = "";

                ddlDepartamento.SelectedIndex = -1;
                ddlMunicipio.SelectedIndex = -1;
                txtNombre.Attributes.Add("placeholder", "Nombre del Particular");
                txtContacto.Attributes.Add("placeholder", "Correo Electrónico");
                txtReferencia.Attributes.Add("placeholder", "Contacto y/o Referencia");
                ddlProducto.Enabled = false;
                btnAgregar.Enabled = false;
                txtIdentificacion.Focus();
            }
        }

    }
}