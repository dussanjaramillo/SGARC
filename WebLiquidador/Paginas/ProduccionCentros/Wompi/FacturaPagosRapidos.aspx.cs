using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Drawing;
using WebLiquidador.App_Code;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Wompi
{
    public partial class FacturaPagosRapidos : System.Web.UI.Page
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

            if (!(new List<string> { "5", "9" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }

            if (!IsPostBack)
            {
                BuscarIniciar();
            }
        }

        private void BuscarIniciar()
        {
            Session.Remove("_ListaProductos");
            grvProductosCentro.DataSource = null;
            grvProductosCentro.DataBind();

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

            BuscarControlCentroFormacion();

            lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
            ddlProducto.Focus();
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
            Response.Redirect("~/Paginas/ProduccionCentros/Wompi/FacturaPagosRapidos.aspx", false);
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
                            txtPrecio.Text = reader[1].ToString();
                            txtPrecioMinimo.Text = reader[1].ToString();
                            txtPrecioMaximo.Text = reader[2].ToString();
                            ddlUnidadMedida.SelectedValue = reader[3].ToString();
                        }
                        con.Close();
                        txtCantidad.Text = "1";
                        txtPrecio.Focus();
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
            //btnGuardar.Enabled = true;
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
            if (Convert.ToInt64(txtPrecio.Text) <= 0)
            {
                Alerta("Atención: El precio de venta no puede ser menor o igual a Cero");
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

            btnAgregar.Enabled = true;

            txtPrecio.Enabled = false;
            txtCantidad.Enabled = false;

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

            if (TotalFactura == Convert.ToDecimal(hfValorCupones.Value))
            {
                ddlProducto.Enabled = false;
                btnAgregar.Enabled = false;
                grvProductosCentro.Enabled = false;
                grvPagosRapidos.Enabled = false;
                btnGenerar.Enabled = true;
            }
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
            btnAgregar.Enabled = true;
            grvProductosCentro.SelectedIndex = -1;

            decimal TotalFactura = Producto.Sum(Tf => Tf.Valor);
            txtValorFactura.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(TotalFactura.ToString()));
            GlobalData.ItemFactura = GlobalData.ItemFactura - 1;

            if (TotalFactura == Convert.ToDecimal(hfValorCupones.Value))
            {
                ddlProducto.Enabled = false;
                btnAgregar.Enabled = false;
                grvProductosCentro.Enabled = false;
                grvPagosRapidos.Enabled = false;
                btnGenerar.Enabled = true;
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            if (Convert.ToInt64(txtPrecio.Text) <= 0)
            {
                Alerta("Atención: El precio de venta no puede ser menor o igual a Cero");
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

            List<ProductosFactura> Producto = (List<ProductosFactura>)Session["_ListaProductos"];

            if (Producto == null)
            {
                DeshabilitarCampos();
                Producto = new List<ProductosFactura>();
                GlobalData.ItemFactura = 0;
            }

            // Verifica que el producto y el precio no existan
            if (Producto.Exists(x => x.IdProducto == Convert.ToInt32(ddlProducto.SelectedValue) && x.Precio == Convert.ToInt64(txtPrecio.Text)))
            {
                txtPrecio.Enabled = false;
                txtCantidad.Enabled = false;
                ddlProducto.Enabled = false;
                Alerta("Atención: El Producto y el Precio ya Existe debe: Seleccionar el Producto y Actualizar el Producto y Modificar la Cantidad");
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
            txtPrecio.Enabled = false;
            txtCantidad.Enabled = false;

            txtPrecioMinimo.Text = "";
            txtPrecioMaximo.Text = "";

            ddlProducto.Enabled = true;
            ddlProducto.SelectedIndex = -1;

            decimal TotalFactura = Producto.Sum(Tf => Tf.Valor);
            txtValorFactura.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(TotalFactura.ToString()));

            if (TotalFactura == Convert.ToDecimal(hfValorCupones.Value))
            {
                ddlProducto.Enabled = false;
                btnAgregar.Enabled = false;
                grvProductosCentro.Enabled = false;
                grvPagosRapidos.Enabled = false;
                btnGenerar.Enabled = true;
            }
        }

        protected void grvProductosCentro_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlProducto.Enabled = false;
            hfdItem.Value = grvProductosCentro.SelectedRow.Cells[1].Text;
            hfdIdProducto.Value = grvProductosCentro.SelectedRow.Cells[2].Text;

            btnAgregar.Enabled = false;

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
            ddlDepartamento.Enabled = false;
            ddlMunicipio.Enabled = false;
        }

        protected void grvPagosRapidos_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnAgregar.Enabled = true; 
            ddlProducto.Enabled = true;
            hfValorCupones.Value = grvPagosRapidos.SelectedRow.Cells[3].Text;
            hfFechaCupon.Value = grvPagosRapidos.SelectedRow.Cells[4].Text;
            Panel6.Enabled = true;
        }

        protected void btnGenerar_Click(object sender, EventArgs e)
        {
            Grabar_FacturaDetalle();
            Grabar_Factura();
            btnGenerar.Enabled = false;
        }

        protected void Grabar_FacturaDetalle()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_FacturaDiariaDetallePagosRapidosInsert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();

                    foreach (GridViewRow row in grvProductosCentro.Rows)
                    {
                        cmd.Parameters.Clear();

                        cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                        cmd.Parameters.Add("@IdProducto", SqlDbType.Int).Value = Convert.ToInt32(row.Cells[2].Text);
                        hfCantidad.Value = row.Cells[4].Text;
                        cmd.Parameters.Add("@Cantidad", SqlDbType.Int).Value = Convert.ToInt32(hfCantidad.Value);
                        hfPrecio.Value = row.Cells[5].Text;
                        cmd.Parameters.Add("@Precio", SqlDbType.BigInt).Value = Convert.ToInt64(hfPrecio.Value);
                        cmd.Parameters.Add("@IdUnidadMedida", SqlDbType.Int).Value = Convert.ToInt32(row.Cells[7].Text);
                        cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

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
            ddlProducto.SelectedIndex = -1;
            txtCantidad.Enabled = false;
            txtCantidad.Enabled = false;
        }

        protected void Grabar_Factura()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_FacturaDiariaDetallePagosRapidosFacturaInsert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                    cmd.Parameters.Add("@FechaCupon", SqlDbType.Text).Value = hfFechaCupon.Value.ToString();
                    cmd.Parameters.Add("@ValorPrefactura", SqlDbType.BigInt).Value = Convert.ToInt64(hfValorCupones.Value.ToString());
                    cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                    return;
                }
            }
            ddlProducto.SelectedIndex = -1;
            txtCantidad.Enabled = false;
            txtCantidad.Enabled = false;
            //lblEstado0.Text = "Listo!!! PreFactura Pagos Rápidos Generada, Por favor Imprima la Prefactura";
            Alerta("Listo!!! PreFactura Pagos Rápidos Generada, Por favor Imprima la Prefactura");
        }
    
    }
}