using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace WebLiquidador.Paginas.CostasProcesales.Obligacion
{
    public partial class Obligacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            //1 Coordinador
            //2 Abogado
            //3 Fiscalizador
            //4 Técnico
            //5 Administrador
            //6 Profesional
            //7 Siif - Nación
            //8 Subdirector
            //9 Producción

            //if ((new List<string> { "1", "2", "3", "4", "6", "7", "8", "9" }).Contains(Session["_IdCargo"].ToString()))
            //{
            //    Response.Redirect("~/DefaultCf.aspx");
            //}

            if (!IsPostBack)
            {
                if (Request.QueryString.Get("id") != null)
                {
                    txtIdentificacion.Text = Request.QueryString.Get("id");
                }
                txtIdentificacion.Focus();
            }
            lblEstado.Text = Session["_NombreRegionalUsuario"].ToString();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscarDeudor(txtIdentificacion.Text, 0);
            btnAgregar.Enabled = true;
            btnImprimir.Enabled = true;
        }

        protected void BuscarDeudor(string Identificacion, Int32 IdDeudor)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CostasProcesales].[Usp_BuscarDeudor]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdDeudor", SqlDbType.Int).Value = IdDeudor;
                cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Identificacion.ToString();
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfIdDeudor.Value = reader[0].ToString();
                            txtNombre.Text = reader[2].ToString();
                        }
                        btnBuscar.Enabled = false;
                        txtIdentificacion.Enabled = false;
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

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/CostasProcesales/Obligacion/Obligacion.aspx", false);
        }
        
        protected void grvObligaciones_SelectedIndexChanged(object sender, EventArgs e)
        { 
            hfIdObligacion.Value = grvObligaciones.SelectedRow.Cells[1].Text;
            hfTransaccion.Value = "1";
            ObligacionXIdOblicacion(hfIdObligacion.Value);
            btnAgregar.Enabled = false;
            btnImprimir.Enabled = false;
            grvObligaciones.Enabled = false;
        }

        protected void ObligacionXIdOblicacion(string IdOblicacion)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CostasProcesales].[Usp_BuscarObligacionXIdObligacion]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdObligacion", SqlDbType.Int).Value = IdOblicacion.ToString();
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            ddlTipoObligacion.SelectedValue = reader[0].ToString();
                            ddlRegional.SelectedValue = reader[1].ToString();
                            ddlDepartamento.SelectedValue = reader[14].ToString();
                            LlenarMunicipio(Convert.ToInt32(reader[14].ToString()));
                            ddlMunicipio.SelectedValue = reader[13].ToString();
                            LlenarJuzgado(Convert.ToInt32(reader[13].ToString()));
                            ddlJuzgado.SelectedValue = reader[2].ToString();
                            LlenarAbogado(Convert.ToInt32(reader[1].ToString()));
                            ddlAbogado.SelectedValue = reader[3].ToString();
                            txtNumeroProceso.Text = reader[4].ToString();
                            txtFechaEjecutoria.Text = Convert.ToDateTime(reader[5]).ToShortDateString();
                            txtPrimeraInstancia.Text = reader[6].ToString();
                            txtSegundaInstancia.Text = reader[7].ToString();
                            txtSedeCasacion.Text = reader[8].ToString();
                            txtValorCostas.Text = reader[9].ToString();
                            txtSaldoCostas.Text = reader[10].ToString();
                            txtFechaSaldo.Text = Convert.ToDateTime(reader[11]).ToShortDateString();
                            if (reader[12].ToString() == "")
                            {
                                chbEsActivo.Checked = false;
                            }
                            else
                            {
                                chbEsActivo.Checked = true;
                            }
                        }
                        con.Close();
                        btnGuardar.Enabled = true; 
                        grvObligaciones.Enabled = true;
                        ddlTipoObligacion.Enabled = true;
                        txtFechaEjecutoria.Enabled = true;
                        txtNumeroProceso.Enabled = true;
                        txtPrimeraInstancia.Enabled = true;
                        txtSegundaInstancia.Enabled = true;
                        txtSaldoCostas.Enabled = true;
                        txtSedeCasacion.Enabled = true;
                        txtFechaSaldo.Enabled = true;
                        ddlRegional.Enabled = true;
                        ddlAbogado.Enabled = true;
                        ddlDepartamento.Enabled = true;
                        ddlMunicipio.Enabled = true;
                        ddlJuzgado.Enabled = true;

                        if (Session["_IdCargo"].ToString() != "5")
                        {
                            ddlRegional.Enabled = false;
                        }
                    }
                    else
                    {
                        Alerta("La Obligacion No Existe");
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
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
                ddlMunicipio.DataSource = null;
                ddlMunicipio.DataBind();
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }

        protected void LlenarJuzgado(Int32 IdMunicipio)
        {
            try
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                var Textocmd = "[CostasProcesales].[Usp_BuscarJuzgadoXIdMunicipio]";
                SqlConnection con = new SqlConnection(CadenaConexion);
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdMunicipio", SqlDbType.Int).Value = IdMunicipio;

                SqlDataAdapter Juzgado = new SqlDataAdapter(cmd);
                DataSet dsJuzgado = new DataSet();
                Juzgado.Fill(dsJuzgado, "Juzgado");

                ddlJuzgado.DataSource = dsJuzgado.Tables["Juzgado"].DefaultView;
                ddlJuzgado.DataTextField = "Nombre";
                ddlJuzgado.DataValueField = "IdJuzgado";
                ddlJuzgado.DataSource = null;
                ddlJuzgado.DataBind();
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }

        protected void LlenarAbogado(Int32 IdRegional)
        {
            try
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                var Textocmd = "[CostasProcesales].[Usp_BuscarAbogadoXIdRegional]";
                SqlConnection con = new SqlConnection(CadenaConexion);
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdRegional", SqlDbType.Int).Value = IdRegional;

                SqlDataAdapter Abogado = new SqlDataAdapter(cmd);
                DataSet dsAbogado = new DataSet();
                Abogado.Fill(dsAbogado, "Abogado");

                ddlAbogado.DataSource = dsAbogado.Tables["Abogado"].DefaultView;
                ddlAbogado.DataTextField = "Nombre";
                ddlAbogado.DataValueField = "IdAbogado";
                ddlAbogado.DataSource = null;
                ddlAbogado.DataBind();
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            hfTransaccion.Value = "0";
            grvObligaciones.Enabled = false;
            ddlTipoObligacion.Enabled = true;
            txtFechaEjecutoria.Enabled = true;
            txtNumeroProceso.Enabled = true;
            txtPrimeraInstancia.Enabled = true;
            txtSegundaInstancia.Enabled = true;
            txtSedeCasacion.Enabled = true;
            //txtSaldoCostas.Enabled = true;
            //txtFechaSaldo.Enabled = true;
            ddlRegional.Enabled = true;
            ddlAbogado.Enabled = true;
            ddlDepartamento.Enabled = true;
            ddlMunicipio.Enabled = true;
            ddlJuzgado.Enabled = true;

            txtPrimeraInstancia.Text = "0";
            txtSegundaInstancia.Text = "0";
            txtSedeCasacion.Text = "0";

            btnGuardar.Enabled = true;  
            btnAgregar.Enabled = false;
            btnImprimir.Enabled = false;

            if (Session["_IdCargo"].ToString() != "5")
            {
                ddlRegional.SelectedValue = Session["_IdRegional"].ToString();
                ddlRegional.Enabled = false;
            }
            
            grvObligaciones.Focus();
        }

        protected void ddlTipoObligacion_DataBound(object sender, EventArgs e)
        {
            ddlTipoObligacion.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            //Page.Validate();
            //if (Page.IsValid == false)
            //{
            //    return;
            //}

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
                        var Textocmd = "[CostasProcesales].[Usp_ObligacionUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdObligacion", SqlDbType.Int).Value = Convert.ToInt32(hfIdObligacion.Value);
                        cmd.Parameters.Add("@IdDeudor", SqlDbType.Int).Value = Convert.ToInt32(hfIdDeudor.Value);
                        cmd.Parameters.Add("@IdTipoObligacion", SqlDbType.Int).Value = Convert.ToInt32(ddlTipoObligacion.SelectedValue.ToString());
                        cmd.Parameters.Add("@IdRegional", SqlDbType.Int).Value = Convert.ToInt32(ddlRegional.SelectedValue.ToString());
                        cmd.Parameters.Add("@IdJuzgado", SqlDbType.Int).Value = Convert.ToInt32(ddlJuzgado.SelectedValue.ToString());
                        cmd.Parameters.Add("@IdAbogado", SqlDbType.Int).Value = Convert.ToInt32(ddlAbogado.SelectedValue.ToString());
                        cmd.Parameters.Add("@NumeroProceso", SqlDbType.Text).Value = txtNumeroProceso.Text.ToString().Trim();
                        cmd.Parameters.Add("@FechaEjecutoria", SqlDbType.Date).Value = Convert.ToString(Convert.ToDateTime(txtFechaEjecutoria.Text.ToString().Trim()));
                        cmd.Parameters.Add("@ValorPrimeraInstancia", SqlDbType.BigInt).Value = Convert.ToInt64(txtPrimeraInstancia.Text.ToString().Trim());
                        cmd.Parameters.Add("@ValorSegundaInstancia", SqlDbType.BigInt).Value = Convert.ToInt64(txtSegundaInstancia.Text.ToString().Trim());
                        cmd.Parameters.Add("@ValorSedeCasacion", SqlDbType.BigInt).Value = Convert.ToInt64(txtSedeCasacion.Text.ToString().Trim());
                        cmd.Parameters.Add("@ValorCostas", SqlDbType.BigInt).Value = Convert.ToInt64(txtValorCostas.Text.ToString().Trim());
                        cmd.Parameters.Add("@SaldoCostas", SqlDbType.BigInt).Value = Convert.ToInt64(txtSaldoCostas.Text.ToString().Trim());
                        cmd.Parameters.Add("@FechaSaldoCostas", SqlDbType.Date).Value = Convert.ToString(Convert.ToDateTime(txtFechaSaldo.Text.ToString().Trim()));

                        if (chbEsActivo.Checked)
                        {cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true;}
                        else
                        {cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false;}

                        cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();

                        Alerta("Obligacion Actualizada");
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
                        var Textocmd = "[CostasProcesales].[Usp_ObligacionInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdDeudor", SqlDbType.Int).Value = Convert.ToInt32(hfIdDeudor.Value);
                        cmd.Parameters.Add("@IdTipoObligacion", SqlDbType.Int).Value = Convert.ToInt32(ddlTipoObligacion.SelectedValue.ToString());
                        cmd.Parameters.Add("@IdRegional", SqlDbType.Int).Value = Convert.ToInt32(ddlRegional.SelectedValue.ToString());
                        cmd.Parameters.Add("@IdJuzgado", SqlDbType.Int).Value = Convert.ToInt32(ddlJuzgado.SelectedValue.ToString());
                        cmd.Parameters.Add("@IdAbogado", SqlDbType.Int).Value = Convert.ToInt32(ddlAbogado.SelectedValue.ToString());
                        cmd.Parameters.Add("@NumeroProceso", SqlDbType.Text).Value = txtNumeroProceso.Text.ToString().Trim();
                        cmd.Parameters.Add("@FechaEjecutoria", SqlDbType.Date).Value = Convert.ToString(Convert.ToDateTime(txtFechaEjecutoria.Text.ToString().Trim()));
                        cmd.Parameters.Add("@ValorPrimeraInstancia", SqlDbType.BigInt).Value = Convert.ToInt64(txtPrimeraInstancia.Text.ToString().Trim());
                        cmd.Parameters.Add("@ValorSegundaInstancia", SqlDbType.BigInt).Value = Convert.ToInt64(txtSegundaInstancia.Text.ToString().Trim());
                        cmd.Parameters.Add("@ValorSedeCasacion", SqlDbType.BigInt).Value = Convert.ToInt64(txtSedeCasacion.Text.ToString().Trim());
                        cmd.Parameters.Add("@ValorCostas", SqlDbType.BigInt).Value = Convert.ToInt64(txtValorCostas.Text.ToString().Trim());
                        cmd.Parameters.Add("@SaldoCostas", SqlDbType.BigInt).Value = Convert.ToInt64(txtSaldoCostas.Text.ToString().Trim());
                        cmd.Parameters.Add("@FechaSaldoCostas", SqlDbType.Date).Value = Convert.ToString(Convert.ToDateTime(txtFechaSaldo.Text.ToString().Trim()));

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

                        Alerta("Obligación Agregada");
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

            grvObligaciones.Enabled = false;
            ddlTipoObligacion.Enabled = false;
            txtFechaEjecutoria.Enabled = false;
            txtNumeroProceso.Enabled = false;
            txtPrimeraInstancia.Enabled = false;
            txtSegundaInstancia.Enabled = false;
            txtSedeCasacion.Enabled = false;
            txtSaldoCostas.Enabled = false;
            txtFechaSaldo.Enabled = false;
            ddlRegional.Enabled = false;
            ddlAbogado.Enabled = false;
            ddlDepartamento.Enabled = false;
            ddlMunicipio.Enabled = false;
            ddlJuzgado.Enabled = false;

            btnAgregar.Enabled = false;
            grvObligaciones.SelectedIndex = -1;
            grvObligaciones.DataSource = null;
            grvObligaciones.DataBind();
            btnGuardar.Enabled = false;
            btnImprimir.Enabled = true;
        }

        private void Validar_Datos()
        {
            if (ddlTipoObligacion.SelectedIndex == 0)
            {
                Alerta("Atención, debe seleccionar la Oblicación");
                ddlTipoObligacion.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                ddlTipoObligacion.Focus();
                return;
            }
            ddlTipoObligacion.BackColor = System.Drawing.Color.Empty;

            if (txtFechaEjecutoria.Text == String.Empty)
            {
                Alerta("Atención, debe escribir la Fecha Ejecutoria");
                txtFechaEjecutoria.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                txtFechaEjecutoria.Focus();
                return;
            }
            txtFechaEjecutoria.BackColor = System.Drawing.Color.Empty;

            if (txtNumeroProceso.Text == "" )
            {
                Alerta("Atención, debe escribir el Número de la Sentencia");
                txtNumeroProceso.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                txtNumeroProceso.Focus();
                return;
            }
            txtNumeroProceso.BackColor = System.Drawing.Color.Empty;

            if (txtFechaEjecutoria.Text == String.Empty)
            {
                Alerta("Atención, debe escribir la Fecha de Ejecutoria");
                txtFechaEjecutoria.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                txtFechaEjecutoria.Focus();
                return;
            }
            txtFechaEjecutoria.BackColor = System.Drawing.Color.Empty;
            
            if ((Convert.ToInt64(txtPrimeraInstancia.Text) == 0) && (Convert.ToInt64(txtSegundaInstancia.Text) == 0) && (Convert.ToInt64(txtSedeCasacion.Text) == 0))
            {
                Alerta("Atención, debe escribir al menos Uno de los Tres Valores");
                txtPrimeraInstancia.BackColor = System.Drawing.Color.Aqua;
                txtSegundaInstancia.BackColor = System.Drawing.Color.Aqua;
                txtSedeCasacion.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                txtPrimeraInstancia.Focus();
                return;
            }
            txtPrimeraInstancia.BackColor = System.Drawing.Color.Empty;
            txtSegundaInstancia.BackColor = System.Drawing.Color.Empty;
            txtSedeCasacion.BackColor = System.Drawing.Color.Empty;

            Int64 ValorCostas = Convert.ToInt64(txtPrimeraInstancia.Text) + Convert.ToInt64(txtSegundaInstancia.Text) + Convert.ToInt64(txtSedeCasacion.Text);
            
            txtValorCostas.Text = ValorCostas.ToString();
            txtSaldoCostas.Text = ValorCostas.ToString();
            txtFechaSaldo.Text = txtFechaEjecutoria.Text;


            //if (txtSaldoCostas.Text == String.Empty)
            //{
            //    Alerta("Atención, debe escribir el Saldo");
            //    txtSaldoCostas.BackColor = System.Drawing.Color.Aqua;
            //    hfErrorValidacion.Value = "1";
            //    txtSaldoCostas.Focus();
            //    return;
            //}
            //txtSaldoCostas.BackColor = System.Drawing.Color.Empty;

            //if (Convert.ToInt64(txtSaldoCostas.Text) > Convert.ToInt64(txtValorCostas.Text))
            //{
            //    Alerta("Atención, el Saldo de las Costas No puede ser Mayor al Valor de las Costas");
            //    txtSaldoCostas.BackColor = System.Drawing.Color.Aqua;
            //    hfErrorValidacion.Value = "1";
            //    txtSaldoCostas.Focus();
            //    return;
            //}
            //txtSaldoCostas.BackColor = System.Drawing.Color.Empty;



            if (txtFechaSaldo.Text == String.Empty)
            {
                Alerta("Atención, debe escribir la Fecha del Saldo");
                txtFechaSaldo.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                txtFechaSaldo.Focus();
                return;
            }
            txtFechaSaldo.BackColor = System.Drawing.Color.Empty;

            if (ddlRegional.SelectedIndex == 0)
            {
                Alerta("Atención, debe seleccionar la Regional del Abogado");
                ddlRegional.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                ddlRegional.Focus();
                return;
            }
           ddlRegional.BackColor = System.Drawing.Color.Empty;

            if (ddlDepartamento.SelectedIndex == 0)
            {
                Alerta("Atención, debe seleccionar el Departamento del Juzgado");
                ddlDepartamento.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                ddlDepartamento.Focus();
                return;
            }
            ddlDepartamento.BackColor = System.Drawing.Color.Empty;

            if (ddlMunicipio.SelectedIndex == 0)
            {
                Alerta("Atención, debe seleccionar el Municipio del Juzgado");
                ddlMunicipio.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                ddlMunicipio.Focus();
                return;
            }
            ddlMunicipio.BackColor = System.Drawing.Color.Empty;
            
            if (ddlJuzgado.SelectedIndex == 0)
            {
                Alerta("Atención, debe seleccionar el Juzgado");
                ddlJuzgado.BackColor = System.Drawing.Color.Aqua;
                hfErrorValidacion.Value = "1";
                ddlJuzgado.Focus();
                return;
            }
            ddlJuzgado.BackColor = System.Drawing.Color.Empty;
        }

        protected void btnImprimir_Click(object sender, EventArgs e)
        {
            Session["_Identificacion"] = txtIdentificacion.Text;
            string _open = "window.open('VisorObligacion.aspx', '_blank');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), _open, true);
        }

        protected void ddlRegional_DataBound(object sender, EventArgs e)
        {
            ddlRegional.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlDepartamento_DataBound(object sender, EventArgs e)
        {
            ddlDepartamento.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlJuzgado_DataBound(object sender, EventArgs e)
        {
            ddlJuzgado.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlAbogado_DataBound(object sender, EventArgs e)
        {
            ddlAbogado.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlMunicipio_DataBound(object sender, EventArgs e)
        {
            ddlMunicipio.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void grvObligaciones_DataBound(object sender, EventArgs e)
        {
            if (grvObligaciones.Rows.Count == 0)
            {
                btnImprimir.Enabled = false;
            }
        }
    
    }
}