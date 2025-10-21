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

namespace WebLiquidador.Paginas.ProduccionCentros.InventarioAyudas
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
            //10 Control Interno

            if (!(new List<string> {"5","9" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }
            lblEstado.Text = Session["_NombreCentroFormacion"].ToString();

            hdEstadoEmergencia.Value = "0";
            BuscarEstadoEmergencia();
            if (hdEstadoEmergencia.Value =="0")
            {
                ddlProducto.Enabled = false;
                txtCantidad.Enabled = false;
                btnLimpiar.Enabled = false;
                Alerta("Atención!! Su Centro No está Difinido cómo Apoyo Emergencia Económica");
                return;
            }
            //if (Session["_ApoyoEE"].ToString() == "1")
            //{
            //    ddlProducto.Enabled = false;
            //    txtCantidad.Enabled = false;
            //    btnTerminar.Enabled = false;
            //    btnLimpiar.Enabled = false;
            //    Alerta("Atención!! Por el Momento no es Posible Ingresar");
            //    return;
            //}
            //Session["_ApoyoEE"] = "1";
        }

        private void BuscarEstadoEmergencia()
        {
            hdEstadoEmergencia.Value = "0";
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_BuscarCentroFormacionEstadoEmergencia]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hdEstadoEmergencia.Value = reader[0].ToString();
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

        protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtCantidadExistencia.Text = "";
            txtNombreUnidadMedida.Text = "";
            BuscarProducto(Convert.ToInt32(ddlProducto.SelectedValue));
            BuscarUnidadMedida(Convert.ToInt32(ddlProducto.SelectedValue));
            txtCantidad.Text = "";
            btnAgregar.Enabled = true;
            btnRestar.Enabled = true;
            txtCantidad.Enabled = true;

            if (Convert.ToInt32(txtCantidadExistencia.Text) == 0 )
            {
                btnRestar.Enabled = false;
            }
            txtCantidadExistencia.Text = string.Format("{0:###,##0}", Convert.ToDouble(txtCantidadExistencia.Text));
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
                            hdIdUnidadMedida.Value = reader[0].ToString();
                            txtNombreUnidadMedida.Text = reader[1].ToString();
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
                var Textocmd = "[CentroFormacion].[Usp_BuscarCantidadProductoAyudas]";
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
                            txtCantidadExistencia.Text = reader[1].ToString();
                        }
                        con.Close();
                    }

                    if (txtCantidadExistencia.Text == "")
                    {
                        txtCantidadExistencia.Text = "0";
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
                txtCantidad.Focus();
                return;
            }
            ProcesarProducto();
            grvInventario.DataSource = null;
            grvInventario.DataBind();
            txtCantidad.Text = "";
            txtCantidad.Enabled = false;
            txtCantidadExistencia.Text = "";
            txtNombreUnidadMedida.Text = "";
            ddlProducto.SelectedIndex = -1;
        }

        protected void btnRestar_Click(object sender, EventArgs e)
        {
            if (Convert.ToInt32(txtCantidad.Text) == 0)
            {
                Alerta("!!!Atención La Cantidad de Entrada No Puede Ser Cero");
                txtCantidad.Focus();
                return;
            }
            txtCantidadExistencia.Text = txtCantidadExistencia.Text.Replace(".", "");
            txtCantidadExistencia.Text = txtCantidadExistencia.Text.Replace(",", "");

            if (Convert.ToInt32(txtCantidad.Text) > Convert.ToInt32(txtCantidadExistencia.Text))
            {
                Alerta("!!!Atención La Cantidad No Puede Mayor a la Cantidad en Existencia");
                txtCantidad.Focus();
                return;
            }

            txtCantidad.Text = "-" + txtCantidad.Text;
            ProcesarProducto();
            grvInventario.DataSource = null;
            grvInventario.DataBind();
            txtCantidad.Text = "";
            txtCantidad.Enabled = false;
            txtCantidadExistencia.Text = "";
            txtNombreUnidadMedida.Text = "";
            ddlProducto.SelectedIndex = -1;
        }

        private void ProcesarProducto()
        {
            // 
            if (hfIdInventario.Value == "0")
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        var Textocmd = "[CentroFormacion].[Usp_InventarioInsertAyudas]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                        cmd.Parameters.Add("@IdProducto", SqlDbType.Int).Value = Convert.ToInt32(ddlProducto.SelectedValue);
                        cmd.Parameters.Add("@Cantidad", SqlDbType.Int).Value = Convert.ToInt32(txtCantidad.Text);
                        cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());
                        cmd.Parameters.Add("@IdUnidadMedida", SqlDbType.Int).Value = Convert.ToInt32(hdIdUnidadMedida.Value);


                        SqlParameter outputIdParam = new SqlParameter("@IdInventarioAyudas", SqlDbType.Int) { Direction = ParameterDirection.Output };
                        cmd.Parameters.Add(outputIdParam);

                        int vResultado;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        vResultado = Convert.ToInt32(cmd.Parameters["@IdInventarioAyudas"].Value);
                        con.Close();

                        Alerta("Producto Guardado Correctamente");
                        btnAgregar.Enabled = false;
                        btnRestar.Enabled = false;
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

                        cmd.Parameters.Add("@IdInventarioAyudas", SqlDbType.Int).Value = Convert.ToInt32(hfIdInventario.Value);
                        cmd.Parameters.Add("@Cantidad", SqlDbType.Int).Value = Convert.ToInt32(txtCantidad.Text);
                        cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());
                        cmd.Parameters.Add("@IdUnidadMedida", SqlDbType.Int).Value = Convert.ToInt32(hdIdUnidadMedida.Value);

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        btnAgregar.Enabled = false;
                        btnRestar.Enabled = false;
                    }
                    catch (SqlException ex)
                    {
                        Alerta("Error: " + ex.Message.ToString());
                    }
                }
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            //Session["_ApoyoEE"] = "0";
            Response.Redirect("~/Paginas/ProduccionCentros/InventarioAyudas/InventarioEntrada.aspx", false);
        }

        protected void btnTerminar_Click(object sender, EventArgs e)
        {
            //Session["_ApoyoEE"] = "0";
            Response.Redirect("~/DefaultCf.aspx");
            return;
        }
    }
}