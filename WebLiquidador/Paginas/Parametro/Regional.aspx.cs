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

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.Parametro
{
    public partial class Regional : System.Web.UI.Page
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
                Response.Redirect("~/Default.aspx");
            }


            if (!IsPostBack)
            {
                txtCodigoRegional.Focus();
                grvRegional.DataSource = SqlBuscarRegional_2;
                grvRegional.DataBind();
            }
            lblEstado.Text = "Agregando";
        }

        protected void ddlDepartamento_DataBound(object sender, EventArgs e)
        {
            ddlDepartamento.Items.Insert(0, new ListItem("Seleccione...", "-1"));
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

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscarRegional(txtCodigoRegional.Text, 0);
            lblEstado.Text = "Modificando";

            grvRegional.DataSource = SqlBuscarRegional_2;
            grvRegional.DataBind();
           
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
                        var Textocmd = "[dbo].[Usp_RegionalUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdRegional", SqlDbType.Int).Value = Convert.ToInt32(hfRegional.Value);
                        cmd.Parameters.Add("@CodigoRegional", SqlDbType.Text).Value = txtCodigoRegional.Text.ToString().Trim();
                        cmd.Parameters.Add("@NombreRegional", SqlDbType.Text).Value = txtNombreRegional.Text.ToString().Trim();
                        cmd.Parameters.Add("@Direccion", SqlDbType.Text).Value = txtDireccion.Text.ToString().Trim();
                        cmd.Parameters.Add("@Telefonos", SqlDbType.Text).Value = txtTelefonos.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = Convert.ToInt32(ddlMunicipio.SelectedValue.ToString());

                        if (chbEsActivo.Checked)
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true;
                        }
                        else
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false;
                        }
                        cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());
                        cmd.Parameters.Add("@Director", SqlDbType.Text).Value = txtDirector.Text.ToString().Trim();
                        cmd.Parameters.Add("@CorreoDirector", SqlDbType.Text).Value = txtCorreoDirector.Text.ToString().Trim();

                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();

                        Alerta("Regional Actualizada");
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
                hfTransaccion.Value = "2";
                //BuscarEntidadPublica(txtIdentificacion.Text, 0);
                if (hfTransaccion.Value == "1")
                {
                    Alerta("Regional Ya Existe");
                    lblEstado.Text = "Modificando";
                    return;
                }

                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        var Textocmd = "[dbo].[Usp_RegionalInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                      
                        cmd.Parameters.Add("@IdRegional", SqlDbType.Int).Value = DbType.Int32;
                        cmd.Parameters.Add("@CodigoRegional", SqlDbType.Text).Value = txtCodigoRegional.Text.ToString().Trim();
                        cmd.Parameters.Add("@NombreRegional", SqlDbType.Text).Value = txtNombreRegional.Text.ToString().Trim();
                        cmd.Parameters.Add("@Direccion", SqlDbType.Text).Value = txtDireccion.Text.ToString().Trim();
                        cmd.Parameters.Add("@Telefonos", SqlDbType.Text).Value = txtTelefonos.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = Convert.ToInt32(ddlMunicipio.SelectedValue.ToString());

                        if (chbEsActivo.Checked)
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true;
                        }
                        else
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false;
                        }
                        cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());
                        cmd.Parameters.Add("@Director", SqlDbType.Text).Value = txtDirector.Text.ToString().Trim();
                        cmd.Parameters.Add("@CorreoDirector", SqlDbType.Text).Value = txtCorreoDirector.Text.ToString().Trim();

                        int vResultado = 0;
                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();

                        lblEstado.Text = "Agregando";
                        Alerta("Regional Agregada");
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

            grvRegional.SelectedIndex = -1;

            grvRegional.DataSource = SqlBuscarRegional_2;
            grvRegional.DataBind();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/Parametro/Regional.aspx", false);
        }

        protected void BuscarRegional(string CodigoRegional, Int32 IdRegional)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_BuscarRegional_1]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@CodigoRegional", SqlDbType.Text).Value = CodigoRegional.ToString();
                cmd.Parameters.Add("@IdRegional", SqlDbType.Int).Value = IdRegional;
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfRegional.Value = reader[0].ToString();
                            txtCodigoRegional.Text = reader[1].ToString();
                            txtNombreRegional.Text = reader[2].ToString();
                            txtDireccion.Text = reader[3].ToString();
                            txtTelefonos.Text = reader[4].ToString();
                            ddlDepartamento.SelectedValue = reader[11].ToString();
                            LlenarMunicipio(Convert.ToInt32(reader[11].ToString()));
                            ddlMunicipio.SelectedValue = reader[5].ToString();
                            chbEsActivo.Checked = Convert.ToBoolean(reader[6].ToString());
                            txtDirector.Text = reader[7].ToString();
                            txtCorreoDirector.Text = reader[8].ToString();
                            hfTransaccion.Value = "1";
                        }
                        btnBuscar.Enabled = false;
                        lblEstado.Text = "Modificando";
                        con.Close();
                    }
                    else
                    {
                        if (hfTransaccion.Value == "2")
                        {
                            lblEstado.Text = "Agregando";
                            return;
                        }
                        Alerta("El Código de la Regional No Existe");
                        txtCodigoRegional.Focus();
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void grvRegional_SelectedIndexChanged(object sender, EventArgs e)
        {
            BuscarRegional("", Convert.ToInt32(grvRegional.SelectedRow.Cells[1].Text));
        }

        private void Validar_Datos()
        {
            if (txtCodigoRegional.Text == String.Empty)
            {
                Alerta("Atención, debe Escribir el Código de la Regional");
                txtCodigoRegional.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }

            if (txtNombreRegional.Text == String.Empty)
            {
                Alerta("Atención, debe Escribir el Nombre de la Regional");
                txtNombreRegional.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }

            if (txtDireccion.Text == String.Empty)
            {
                Alerta("Atención, debe Escribir la Dirección de la Regional");
                txtDireccion.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }

            if (txtTelefonos.Text == String.Empty)
            {
                Alerta("Atención, debe Escribir los Teléfonos de la Regional");
                txtTelefonos.Focus();
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

            if (txtDirector.Text == String.Empty)
            {
                Alerta("Atención, debe Escribir el Nombre Completo del Director de la Regional");
                txtDirector.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }

            if (txtCorreoDirector.Text == String.Empty)
            {
                Alerta("Atención, debe Escribir el Código del Correo del Director");
                txtCorreoDirector.Focus();
                hfErrorValidacion.Value = "1";
                return;
            }
        }

        protected void grvRegional_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvRegional.PageIndex = e.NewPageIndex;
            grvRegional.DataSource = SqlBuscarRegional_2;
            grvRegional.DataBind();
        }
    }
}