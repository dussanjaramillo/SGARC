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

namespace WebLiquidador.Paginas.ProduccionCentros.Catalogo
{
    public partial class CatalogoProducto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            if ((new List<string> { "1", "2", "3", "4", "6", "7" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
            }

            if (!IsPostBack)
            {
                ddlProducto.Items.Insert(0, new ListItem("Seleccione...", "-1"));
                BuscarControlCentroFormacion();
                txtNombreProducto.Focus();
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString(); 
            }
        }

        protected void ddlProducto_DataBound(object sender, EventArgs e)
        {
            ddlProducto.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            if (txtNombreProducto.Text.Length < 3)
            {
                Alerta("Alerta el Nombre del Producto a Buscar debe tener Mínimo 3 caracteres");
                txtNombreProducto.Focus();
                return;
            }
            btnBuscar.Enabled = false;
            txtNombreProducto.Enabled = false;
            BuscarProducto();
        }

        protected void ddlUnidadMedida_DataBound(object sender, EventArgs e)
        {
            ddlUnidadMedida.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlUnidadMedida.Enabled = true;
            ddlUnidadMedida.SelectedValue = "-1";
            txtPrecioMinimo.Enabled = true;
            txtPrecioMinimo.Text = "";
            txtPrecioMaximo.Enabled = true;
            txtPrecioMaximo.Text = "";
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Catalogo/CatalogoProducto.aspx", false);
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

                if (Convert.ToInt32(txtPrecioMinimo.Text) < Convert.ToInt32(hfPrecioMinimo.Value))
                {
                    Alerta("Atención: el Precio Mínimo debe ser Mayor o Igual que $" + hfPrecioMinimo.Value);
                    return;
                }

                if (Convert.ToInt32(txtPrecioMaximo.Text) > Convert.ToInt32(hfPrecioMaximo.Value))
                {
                    Alerta("Atención: el Precio Maximo debe ser Menor o Igual que $" + hfPrecioMaximo.Value);
                    return;
                }
                
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        int vResultado;
                        var Textocmd = "[dbo].[Usp_CatalogoCentroUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add("@IdCatalogoCentro", SqlDbType.Int).Value = Convert.ToInt32(hfdCatalogoCentro.Value);
                        cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                        cmd.Parameters.Add("@IdProducto", SqlDbType.Int).Value = Convert.ToInt32(hfdProductoCatalogo.Value);
                        cmd.Parameters.Add("@PrecioMinimo", SqlDbType.Int).Value = Convert.ToInt32(txtPrecioMinimo.Text);
                        cmd.Parameters.Add("@PrecioMaximo", SqlDbType.Int).Value = Convert.ToInt32(txtPrecioMaximo.Text);

                        if (chbEsActivo.Checked)
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true;
                        }
                        else
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false;
                        }

                        cmd.Parameters.Add("@IdUnidadMedida", SqlDbType.Int).Value = Convert.ToInt32(ddlUnidadMedida.SelectedValue.ToString());
                        cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();

                        Alerta("Producto del Catalogo Actualizado");
                    }
                    catch (SqlException ex)
                    {
                        Alerta("Error: " + ex.Message);
                    }
                }
            }
            else
            {
                hfdExisteProducto.Value = "0";
                BuscarProducto(Convert.ToInt32(ddlProducto.SelectedValue));

                if (hfdExisteProducto.Value == "1")
                {
                    Alerta("Atención el Producto ya Existe en el Catalogo");
                    txtNombreProducto.Focus();
                    return;
                }

                if (Convert.ToInt32(txtPrecioMinimo.Text) < Convert.ToInt32(hfPrecioMinimo.Value))
                {
                    Alerta("Atención: el Precio Mínimo debe ser Mayor o Igual que $" + hfPrecioMinimo.Value);
                    return;
                }

                if (Convert.ToInt32(txtPrecioMaximo.Text) > Convert.ToInt32(hfPrecioMaximo.Value))
                {
                    Alerta("Atención: el Precio Maximo debe ser Menor o Igual que $" + hfPrecioMaximo.Value);
                    return;
                }

                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        var Textocmd = "[dbo].[Usp_CatalogoCentroInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdCatalogoCentro", SqlDbType.Int).Value = DbType.Int32;
                        cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
                        cmd.Parameters.Add("@IdProducto", SqlDbType.Int).Value = Convert.ToInt32(ddlProducto.SelectedValue.ToString());
                        cmd.Parameters.Add("@PrecioMinimo", SqlDbType.Int).Value = Convert.ToInt32(txtPrecioMinimo.Text);
                        cmd.Parameters.Add("@PrecioMaximo", SqlDbType.Int).Value = Convert.ToInt32(txtPrecioMaximo.Text);
                      
                        
                        cmd.Parameters.Add("@IdUnidadMedida", SqlDbType.Int).Value = Convert.ToInt32(ddlUnidadMedida.SelectedValue.ToString());

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
                        Alerta("Producto Agregado al Catalogo del Centro");
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
            ActualizarGrilla();

            btnBuscar.Enabled = true;
            txtNombreProducto.Enabled = true;
            txtNombreProducto.Text = "";
            btnExportar.Enabled = true;
        }

        private void Validar_Datos()
        {
            if (Convert.ToInt32(txtPrecioMinimo.Text) < Convert.ToInt32(hfPrecioMinimo.Value))
            {
                Alerta("Error, el Precio Mímimo debe ser Mayor o Igual a: " + hfPrecioMinimo.Value);
                txtPrecioMinimo.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }

            if (Convert.ToInt32(txtPrecioMaximo.Text) > Convert.ToInt32(hfPrecioMaximo.Value))
            {
                Alerta("Error, el Precio Máximo debe ser Menor o Igual a " + hfPrecioMaximo.Value);
                txtPrecioMaximo.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }

            if (Convert.ToInt32(txtPrecioMinimo.Text) > Convert.ToInt32(txtPrecioMaximo.Text))
            {
                Alerta("Error, el Precio Mímimo debe ser Menor al Precio Máximo");
                txtPrecioMinimo.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }

            if (Convert.ToInt32(txtPrecioMaximo.Text) < Convert.ToInt32(txtPrecioMinimo.Text))
            {
                Alerta("Error, el Precio Máximo no puede ser Menor al Precio Mímimo");
                txtPrecioMaximo.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }
        }

        private void BuscarProducto()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            var Textocmd = "[dbo].[Usp_NombreProductoBuscar]";
            SqlConnection con = new SqlConnection(CadenaConexion);
            SqlCommand cmd = new SqlCommand(Textocmd, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("@NombreProducto", SqlDbType.Text).Value = txtNombreProducto.Text.Trim();

            SqlDataAdapter NombreProducto = new SqlDataAdapter(cmd);
            DataSet dsNombreProducto = new DataSet();
            NombreProducto.Fill(dsNombreProducto, "NombreProducto");

            ddlProducto.DataSource = dsNombreProducto.Tables["NombreProducto"].DefaultView;
            ddlProducto.DataTextField = "NombreProducto";
            ddlProducto.DataValueField = "IdProducto";
            ddlProducto.DataBind();
            ddlProducto.Items.Insert(0, new ListItem("Seleccione...", "-1"));


            grvProductosCentro.SelectedIndex = -1;
            btnGuardar.Enabled = false;
            txtPrecioMinimo.Text = "";
            txtPrecioMaximo.Text = "";

            ddlUnidadMedida.Enabled = false;
            ddlUnidadMedida.SelectedValue = "-1";

            if (ddlProducto.Items.Count > 1)
            {
                ddlProducto.Enabled = true;
                txtPrecioMinimo.Enabled = true;
                txtPrecioMaximo.Enabled = true;
                ddlUnidadMedida.Enabled = true;
                chbEsActivo.Enabled = true;
                ddlProducto.Focus();
                btnExportar.Enabled = true;
            }
        }

        private void ActualizarGrilla()
        {
            var CadenaConexion1 = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            var Textocmd1 = "[dbo].[Usp_CatalogoCentroBuscarXIdCentroFormacion]";
            SqlConnection con1 = new SqlConnection(CadenaConexion1);
            SqlCommand cmd1 = new SqlCommand(Textocmd1, con1);
            cmd1.CommandType = System.Data.CommandType.StoredProcedure;
            cmd1.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString());
            grvProductosCentro.DataBind();
            grvProductosCentro.SelectedIndex = -1;

            btnGuardar.Enabled = false;
            btnBorrar.Enabled = false;
            btnActualizar.Enabled = false;

            txtPrecioMinimo.Text = "";
            txtPrecioMinimo.Enabled = false;

            txtPrecioMaximo.Text = "";
            txtPrecioMaximo.Enabled = false;

            ddlUnidadMedida.Enabled = false;
            ddlUnidadMedida.SelectedValue = "-1";

            btnBorrar.BackColor = Color.Empty;
            btnActualizar.BackColor = Color.Empty;
            btnGuardar.BackColor = Color.Empty;

            txtPrecioMinimo.BackColor = Color.Empty;
            txtPrecioMaximo.BackColor = Color.Empty;

            ddlUnidadMedida.BackColor = Color.Empty;

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
                            hfdExisteProducto.Value = "1";
                            txtPrecioMinimo.Text = reader[1].ToString();
                            txtPrecioMaximo.Text = reader[2].ToString();
                            ddlUnidadMedida.SelectedValue = reader[3].ToString();
                            hfdInventariable.Value = reader[4].ToString();
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
            txtNombreProducto.Enabled = false;
            btnBuscar.Enabled = false;

            BuscarProducto(Convert.ToInt32(hfdProductoCatalogo.Value));

            txtPrecioMinimo.Enabled = true;
            txtPrecioMinimo.BackColor = Color.Aqua;

            txtPrecioMaximo.Enabled = true;
            txtPrecioMaximo.BackColor = Color.Aqua;

            ddlUnidadMedida.Enabled = true;
            ddlUnidadMedida.BackColor = Color.Aqua;

            btnGuardar.Enabled = true;
            btnGuardar.BackColor = Color.Aqua;

            btnActualizar.Enabled = false;
            btnActualizar.BackColor = Color.Empty;

            btnBorrar.Enabled = false;
            btnBorrar.BackColor = Color.Empty;

            hfTransaccion.Value = "1";

            if (hfdInventariable.Value == "Si" )
            {
                if (Session["_IdCargo"].ToString() != "5")
                { 
                ddlUnidadMedida.Enabled = false;
                ddlUnidadMedida.BackColor = Color.Empty;
                }
            }

            txtPrecioMinimo.Focus();
        }

        protected void btnBorrar_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CentroFormacion].[Usp_CatalogoCentroDesactivar]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdCatalogoCentro", SqlDbType.Int).Value = Convert.ToInt32(hfdCatalogoCentro.Value);
                    cmd.Parameters.Add("@IdProducto", SqlDbType.Int).Value = Convert.ToInt32(hfdProductoCatalogo.Value);
                    cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    Alerta("Listo: Producto Desactivado del Catalogo del Centro");
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                }
            }
            ActualizarGrilla();
            btnBuscar.Enabled = true;
            txtNombreProducto.Enabled = true;
            txtNombreProducto.Text = "";
        }

        protected void grvProductosCentro_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfdCatalogoCentro.Value = grvProductosCentro.SelectedRow.Cells[1].Text;
            hfdProductoCatalogo.Value = grvProductosCentro.SelectedRow.Cells[2].Text;
            btnBorrar.Enabled = true;
            btnActualizar.Enabled = true;
            txtNombreProducto.Enabled = false;
            btnBuscar.Enabled = false;
            btnActualizar.BackColor = Color.Aqua;
            btnBorrar.BackColor = Color.Aqua;
            btnExportar.Enabled = false; 
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            if (Session["_IdCentroFormacion"].ToString() == "")
            {
                Alerta("Alerta: Usted No Pertenece a Ningun Centro de Formacion");
                return;
            }

            grvCatalogoCentro.Visible = true;
            grvCatalogoCentro.Caption = "CatalogoProductos_Regional_" + Session["_NombreRegionalUsuario"].ToString() + "_" + Session["_NombreCentroFormacion"].ToString();
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvCatalogoCentro.AllowPaging = false;
            grvCatalogoCentro.AllowSorting = false;
            grvCatalogoCentro.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvCatalogoCentro);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "CatalogoProductos_Regional_" + Session["_NombreRegionalUsuario"].ToString() + "_" + Session["_NombreCentroFormacion"].ToString() + ".xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvCatalogoCentro.Visible = false;
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
                            hfPrecioMinimo.Value = reader[0].ToString();
                            hfPrecioMaximo.Value = reader[1].ToString();
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
    }
}