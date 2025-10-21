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
using System.Drawing;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Inventario
{
    public partial class InventarioEntrada : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if ((new List<string> { "1", "2", "3", "4", "6", "7", "8", "9" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }
            lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
            //grvInventario.DataSource = SdsInventarioProductos;
            //grvInventario.DataBind();
        }

        protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
        {
            BuscarProducto(Convert.ToInt32(ddlProducto.SelectedValue));
            BuscarUnidadMedida(Convert.ToInt32(ddlProducto.SelectedValue));
            txtCantidad.Text = "";
            txtCantidad.Focus();
        }

        private void BuscarUnidadMedida(int Producto)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarUnidadMedidaProducto]";
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
                            txtNombreUnidadMedida.Text = reader[0].ToString();  
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


        private void BuscarProducto(int Producto)
        {
            hfIdInventario.Value = "0";
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarCantidadProducto]";
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
                            hfIdInventario.Value = reader[0].ToString();
                            txtCantidadExistencia.Text = string.Format("{0:###,##0}", Convert.ToDouble(reader[1].ToString()));
                        }
                        con.Close();
                    }

                    if (txtCantidadExistencia.Text == "")
                    {
                        txtCantidadExistencia.Text = "No Hay Existencia";
                        hfIdInventario.Value = "0";
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

        protected void ddlProducto_DataBound(object sender, EventArgs e)
        {
            ddlProducto.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            if (Convert.ToInt32(txtCantidad.Text) == 0)
            {
                Alerta("!!!Atención La Cantidad de Entrada No Puede Ser Cero");
                return;
            }

            // 
            if (hfIdInventario.Value == "0")
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        var Textocmd = "[CentroFormacion].[Usp_InventarioInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                        cmd.Parameters.Add("@IdProducto", SqlDbType.Int).Value = Convert.ToInt32(ddlProducto.SelectedValue);
                        cmd.Parameters.Add("@Cantidad", SqlDbType.Int).Value = Convert.ToInt32(txtCantidad.Text);
                        cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        SqlParameter outputIdParam = new SqlParameter("@IdInventario", SqlDbType.Int) { Direction = ParameterDirection.Output };
                        cmd.Parameters.Add(outputIdParam);

                        int vResultado;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        vResultado = Convert.ToInt32(cmd.Parameters["@IdInventario"].Value);
                        con.Close();
                        //Session["_IdFactura"] = vResultado.ToString();

                        Alerta("Producto Guardado Correctamente");
                        btnAgregar.Enabled = false;

                    }
                    catch (SqlException ex)
                    {
                        Alerta("Error: " + ex.Message.ToString());
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
                        var Textocmd = "[CentroFormacion].[Usp_InventarioUpdateAyudas]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdInventario", SqlDbType.Int).Value = Convert.ToInt32(hfIdInventario.Value);
                        cmd.Parameters.Add("@Cantidad", SqlDbType.Int).Value = Convert.ToInt32(txtCantidad.Text);
                        cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());
                        
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        //Alerta("Cantidad del Producto Actualizada Correctamente");
                        btnAgregar.Enabled = false;
                    }
                    catch (SqlException ex)
                    {
                        Alerta("Error: " + ex.Message.ToString());
                    }
                }
            }

            grvInventario.DataSource = null;
            grvInventario.DataBind();
            txtCantidad.Text = "";
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Inventario/InventarioEntrada.aspx", false);
        }
    }
}