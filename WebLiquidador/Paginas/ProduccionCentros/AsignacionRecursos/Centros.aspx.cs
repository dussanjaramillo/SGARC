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
    public partial class Centros : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                //Response.AppendHeader("Cache-Control", "no-store");
                //Response.AppendHeader("Cache-Control", "no-cache, no-store, must-revalidate");
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

            //if (!(new List<string> { "5" }).Contains(Session["_IdCargo"].ToString()))
            //{
            //    Response.Redirect("~/DefaultCf.aspx");
            //    return;
            //}

            if (Session["_IdCentroFormacion"].ToString() == "118")
            {
                btnGuardar.Enabled = false;
                btnLimpiar.Enabled = false;
                grvAsignacionRecursos.Enabled = false;
                Alerta("Alerta: Usted No Debe Ingresar por esta Opción es Solo Para los Centros de Formación");
            }

            if (!IsPostBack)
            {
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
                hfTransaccion.Value = "0";
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!IsValid)
            {
                return;
            }

            if (Session["_IdCentroFormacion"].ToString() == "118")
            {
                Alerta("Alerta: la Dirección General No Tiene Permitido Usar esta Opción");
                return;
            }

            if (txtRadicado.Text == "_-____-______")
            {
                Alerta("Alerta: Debe escribir el Número de Radicado");
                txtRadicado.Focus();
                return; 
            }

            if (hfTransaccion.Value == "1")
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        int vResultado;
                        var Textocmd = "[CentroFormacion].[Usp_AsignacionRecursosUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdAsignacionRecursos", SqlDbType.Int).Value = Convert.ToInt32(hfIdAsignacionRecursos.Value);
                        cmd.Parameters.Add("@Radicado", SqlDbType.Text).Value = txtRadicado.Text.Trim();
                        cmd.Parameters.Add("@FechaRadicado", SqlDbType.Date).Value = Convert.ToDateTime(txtFechaRadicado.Text.Trim());
                        cmd.Parameters.Add("@ValorSolicitado", SqlDbType.BigInt).Value = Convert.ToInt64(txtValorSolicitado.Text);

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
                hfTransaccion.Value = "0";
            }
            else
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        var Textocmd = "[CentroFormacion].[Usp_AsignacionRecursosInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdCentroFormacion"].ToString()); ;
                        cmd.Parameters.Add("@Radicado", SqlDbType.Text).Value = txtRadicado.Text.Trim();
                        cmd.Parameters.Add("@FechaRadicado", SqlDbType.Date).Value = Convert.ToDateTime(txtFechaRadicado.Text.Trim());
                        cmd.Parameters.Add("@ValorSolicitado", SqlDbType.BigInt).Value = Convert.ToInt64(txtValorSolicitado.Text);
                        cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        int vResultado = 0;
                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();
                        Alerta("Asignación de Recursos Agregado");
                    }
                    catch (SqlException ex)
                    {
                        Alerta("Error: " + ex.Message.ToString());
                    }
                }
            }
            grvAsignacionRecursos.SelectedIndex = -1;
            grvAsignacionRecursos.DataSource = null;
            txtRadicado.Text = "";
            txtFechaRadicado.Text = "";
            txtValorSolicitado.Text = "";
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
            Response.Redirect("~/Paginas/ProduccionCentros/AsignacionRecursos/Centros.aspx", false);
        }

        protected void grvAsignacionRecursos_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (grvAsignacionRecursos.SelectedRow.Cells[5].Text != "No Tramitada")
            {
                Alerta("Alerta: Ya no se Puede Modificar la Asignacion de Recursos" );
                return;
            }
            hfIdAsignacionRecursos.Value = grvAsignacionRecursos.SelectedRow.Cells[1].Text;
            txtRadicado.Text = grvAsignacionRecursos.SelectedRow.Cells[2].Text;
            txtFechaRadicado.Text = grvAsignacionRecursos.SelectedRow.Cells[3].Text;
            txtValorSolicitado.Text = grvAsignacionRecursos.SelectedRow.Cells[4].Text.Replace(",","");
            hfTransaccion.Value = "1";
        }

        protected void grvAsignacionRecursos_DataBound(object sender, EventArgs e)
        {
            if (grvAsignacionRecursos.Rows.Count == 0 )
            {
                Alerta("Alerta: Su Centro de Formación aún no Tiene Ninguna Solicitud");
            }
        }
    }
}