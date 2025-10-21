using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.AsignacionRecursos
{
    public partial class Digeneral : System.Web.UI.Page
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

            if (!(new List<string> { "5" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/DefaultCf.aspx");
                return;
            }

            if (Session["_IdCentroFormacion"].ToString() != "118")
            {
                btnLimpiar.Enabled = false;
                grvAsignacionRecursos.Enabled = false;
                Alerta("Alerta: Usted Debe Ingresar Cómo Centro de Formación Dirección General");
            }


            if (!IsPostBack)
            {
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
                hfTransaccion.Value = "0";
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/AsignacionRecursos/Digeneral.aspx", false);
        }

        protected void grvAsignacionRecursos_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (grvAsignacionRecursos.SelectedRow.Cells[6].Text == "No Tramitada")
            {
                btnEnProceso.Enabled = true;
                btnAprobar.Enabled = false;
            }

            if (grvAsignacionRecursos.SelectedRow.Cells[6].Text == "En Proceso")
            {
                btnEnProceso.Enabled = false;
                btnAprobar.Enabled = true;
                txtObservacion.Enabled = true;
                txtNumeroResolucion.Enabled = true;
                txtFechaResolucion.Enabled = true;
                txtValorAprobado.Enabled = true;
                ddlAprobar.Enabled = true;

                txtObservacion.Text = grvAsignacionRecursos.SelectedRow.Cells[7].Text.Replace("&nbsp;", "");
                txtNumeroResolucion.Text = grvAsignacionRecursos.SelectedRow.Cells[8].Text.Replace("&nbsp;", "");
                txtFechaResolucion.Text = grvAsignacionRecursos.SelectedRow.Cells[9].Text.Replace("&nbsp;", "");
                txtValorAprobado.Text = grvAsignacionRecursos.SelectedRow.Cells[10].Text.Replace("&nbsp;", "");

                txtObservacion.Focus();
            }

            if ((grvAsignacionRecursos.SelectedRow.Cells[6].Text == "Tramitada")
                != (grvAsignacionRecursos.SelectedRow.Cells[6].Text == "Tramitada Parcialmente")
                != (grvAsignacionRecursos.SelectedRow.Cells[6].Text == "Rechazada"))
            {
                btnEnProceso.Enabled = false;
                btnAprobar.Enabled = true;
                txtObservacion.Enabled = true;
                txtNumeroResolucion.Enabled = true;
                txtFechaResolucion.Enabled = true;
                txtValorAprobado.Enabled = true;
                ddlAprobar.Enabled = true;

                txtObservacion.Text = grvAsignacionRecursos.SelectedRow.Cells[7].Text;
                txtNumeroResolucion.Text = grvAsignacionRecursos.SelectedRow.Cells[8].Text;
                txtFechaResolucion.Text = grvAsignacionRecursos.SelectedRow.Cells[9].Text;
                txtValorAprobado.Text = grvAsignacionRecursos.SelectedRow.Cells[10].Text;

                if (grvAsignacionRecursos.SelectedRow.Cells[6].Text == "Tramitada")
                { ddlAprobar.SelectedValue = "3"; }

                if (grvAsignacionRecursos.SelectedRow.Cells[6].Text == "Tramitada Parcialmente")
                { ddlAprobar.SelectedValue = "4"; }

                if (grvAsignacionRecursos.SelectedRow.Cells[6].Text == "Rechazada")
                { ddlAprobar.SelectedValue = "5"; }

            }

            hfIdAsignacionRecursos.Value = grvAsignacionRecursos.SelectedRow.Cells[1].Text;

        }

        protected void grvAsignacionRecursos_DataBound(object sender, EventArgs e)
        {

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

        protected void btnEnProceso_Click(object sender, EventArgs e)
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
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_AsignacionRecursosEnProcesoUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@IdAsignacionRecursos", SqlDbType.Int).Value = Convert.ToInt32(hfIdAsignacionRecursos.Value);
                    cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();

                    Alerta("Asignación de Recursos Actualizado En Proceso");
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
            grvAsignacionRecursos.SelectedIndex = -1;
            grvAsignacionRecursos.DataSource = null;
        }

        protected void ddlAprobar_DataBound(object sender, EventArgs e)
        {
            ddlAprobar.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnAprobar_Click(object sender, EventArgs e)
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
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_AsignacionRecursosAprobarUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@IdAsignacionRecursos", SqlDbType.Int).Value = Convert.ToInt32(hfIdAsignacionRecursos.Value);

                    cmd.Parameters.Add("@IdEstadoAsignacionRecursos", SqlDbType.Int).Value = Convert.ToInt32(ddlAprobar.SelectedValue);
                    cmd.Parameters.Add("@Observacion", SqlDbType.Text).Value = txtObservacion.Text.Trim();
                    cmd.Parameters.Add("@NumeroResolucion", SqlDbType.Text).Value = txtNumeroResolucion.Text.Trim();
                    cmd.Parameters.Add("@FechaResolucion", SqlDbType.Date).Value = txtFechaResolucion.Text.Trim();
                    txtValorAprobado.Text = txtValorAprobado.Text.Replace(",", "");
                    txtValorAprobado.Text = txtValorAprobado.Text.Replace(".", "");
                    cmd.Parameters.Add("@ValorAprobado", SqlDbType.BigInt).Value = Convert.ToInt64(txtValorAprobado.Text.Trim());
                    cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());
                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();

                    Alerta("Asignación de Recursos Actualizado");
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }

            txtObservacion.Text = "";
            txtNumeroResolucion.Text = "";
            txtFechaResolucion.Text = "";
            txtValorAprobado.Text = "";
            ddlAprobar.SelectedIndex = -1;
            grvAsignacionRecursos.SelectedIndex = -1;
            grvAsignacionRecursos.DataSource = null;
            btnAprobar.Enabled = false;
        }
    }
}