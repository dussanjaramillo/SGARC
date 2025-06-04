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
using WebLiquidador.App_Code;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros
{
    public partial class MantenimientoMensajesUsuarios : System.Web.UI.Page
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

            if (!IsPostBack)
            {
                txtMensajeUsuario.Focus();
                lblEstado.Text = "Agregando";
                hfTransaccion.Value = "0";
                BindData();
            }
        }

        protected void BindData()
        {
            grvMensajeUsuarios.DataSource = null;
            grvMensajeUsuarios.DataBind();
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

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            //Usuario Existe se hace un Update
            if (hfTransaccion.Value == "1")
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        int vResultado;
                        var Textocmd = "[CentroFormacion].[Usp_MensajeUsuariosUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdMensajeUsuarios", SqlDbType.Int).Value = Convert.ToInt32(hfMensajeUsuarios.Value);
                        cmd.Parameters.Add("@MensajeUsuarios", SqlDbType.Text).Value = txtMensajeUsuario.Text.ToString().Trim();
                        if (chbEsActivo.Checked)
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true;
                        }
                        else
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false;
                        }

                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();

                        Alerta("Mensaje Usuarios Actualizado");
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
                        var Textocmd = "[CentroFormacion].[Usp_MensajeUsuariosInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@MensajeUsuarios", SqlDbType.Text).Value = txtMensajeUsuario.Text.ToString().Trim();
                        if (chbEsActivo.Checked)
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true;
                        }
                        else
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false;
                        }

                        int vResultado = 0;
                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();
                        Alerta("Mensaje Usuario Agregado");
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
            txtMensajeUsuario.Text = "";
            chbEsActivo.Checked = false;
            grvMensajeUsuarios.SelectedIndex = -1;
            BindData();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/MantenimientoMensajesUsuarios.aspx", false);
        }

        protected void grvMensajeUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblEstado.Text = "Modificando";
            hfTransaccion.Value = "1";
            hfMensajeUsuarios.Value = grvMensajeUsuarios.SelectedRow.Cells[1].Text;
            txtMensajeUsuario.Text = HttpUtility.HtmlDecode(grvMensajeUsuarios.SelectedRow.Cells[2].Text);

            if (grvMensajeUsuarios.SelectedRow.Cells[3].Text == "Si")
            {
                chbEsActivo.Checked = true;
            }
            else
            {
                chbEsActivo.Checked = false;
            }
        }
    }
}