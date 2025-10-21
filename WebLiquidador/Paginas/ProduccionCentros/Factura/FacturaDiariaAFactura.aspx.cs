using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
    public partial class FacturaDiariaAFactura : System.Web.UI.Page
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
                Session.Remove("_ListaProductos");
                grvProductosCentro.DataSource = null;
                grvProductosCentro.DataBind();

                BuscarFacturaDiariaDetalle();

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

                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
            }
        }

        private void BuscarFacturaDiariaDetalle()
        {
            try
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[CentroFormacion].[Usp_BuscarFacturaDiariaDetalle]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdCentroFormacion", Convert.ToInt32(Session["_IdCentroFormacion"].ToString()));
                    cmd.Parameters.AddWithValue("@IdUsuario", Convert.ToInt32(Session["_IdUsuario"].ToString()));

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    hfFilas.Value = Convert.ToString(dt.Rows.Count);

                    grvProductosCentro.DataSource = dt;
                    grvProductosCentro.DataBind();
                    con.Close();

                    if (grvProductosCentro.Rows.Count > 0)
                    {
                        List<ProductosFactura> Producto = (List<ProductosFactura>)Session["_ListaProductos"];

                        if (Producto == null)
                        {
                            Producto = new List<ProductosFactura>();
                        }
                        hfUltimoItem.Value = "0";

                        foreach (GridViewRow dtRow in grvProductosCentro.Rows)
                        {
                            var Item = dtRow.Cells[0].Text.ToString();
                            var IdProducto = dtRow.Cells[1].Text.ToString();
                            var Nombre = HttpUtility.HtmlDecode(dtRow.Cells[2].Text.ToString());
                            var Cantidad = dtRow.Cells[3].Text.ToString().Replace(".", "");
                            var Precio = dtRow.Cells[4].Text.ToString().Replace(".", "");
                            var Valor = dtRow.Cells[5].Text.ToString().Replace("$", "");
                            Valor = Valor.Replace(",", "");
                            Valor = Valor.Replace(" ", "");

                            Int64 WValor = Convert.ToInt64(Precio) * Convert.ToInt64(Cantidad);

                            var IdUnidadMedida = dtRow.Cells[6].Text.ToString();
                            var NombreUnidadMedida = dtRow.Cells[7].Text.ToString();

                            Producto.Insert(Convert.ToInt32(Item), new ProductosFactura() { Item = Convert.ToInt32(Item), IdProducto = Convert.ToInt32(IdProducto), Nombre = Nombre, Cantidad = Convert.ToInt32(Cantidad), Precio = Convert.ToInt64(Precio), Valor = WValor, IdUnidadMedida = Convert.ToInt32(IdUnidadMedida), NombreUnidadMedida = NombreUnidadMedida });

                            hfUltimoItem.Value = Item;
                        }

                        GlobalData.ItemFactura = Convert.ToInt32(hfUltimoItem.Value) + 1;

                        Session.Add("_ListaProductos", Producto);
                        grvProductosCentro.DataSource = Producto;
                        grvProductosCentro.DataBind();
                        decimal TotalFactura = Producto.Sum(Tf => Tf.Valor);
                        txtValorFactura.Text = string.Format("{0:$##,###,###,##0}", Convert.ToInt64(TotalFactura.ToString()));
                    }
                }
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Factura/FacturaDiariaAFactura.aspx", false);
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

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {
            //if (grvProductosCentro.Rows.Count == 1)
            //{
            //    btnEjecutar.Enabled = false;
            //    Alerta("Atención!!!!! la Prefactura Diaria Debe tener Más de un Producto");
            //    return;
            //}

            btnEjecutar.Enabled = false;
            GrabarNumeroFactura();

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_FacturaDiariaDetalleFacturaInsert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                    cmd.Parameters.Add("@NumeroFactura", SqlDbType.BigInt).Value = Convert.ToInt64(hfdIdFactura.Value);
                    cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Alerta("Listo!!!!! La Prefactura Diaria A Prefactura Definitiva");
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
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
                    hfdIdFactura.Value = vResultado.ToString();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void grvProductosCentro_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (hfFilas.Value == "0")
                {
                    Alerta("La Prefactura Diaria está Vacía para el Usuario: " + Session["_NombreUsuario"].ToString());
                    btnEjecutar.Enabled = false;
                    return;
                }
                else
                {
                    btnEjecutar.Enabled = true;
                }
            }
        }

    }
}