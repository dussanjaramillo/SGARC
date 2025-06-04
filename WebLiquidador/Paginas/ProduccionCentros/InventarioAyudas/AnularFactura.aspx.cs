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

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.InventarioAyudas
{
    public partial class AnularFactura : System.Web.UI.Page
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
            }

            if (!IsPostBack)
            {
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString(); 
                grvFacturaXCentro.Focus();
                //Alerta("!!! ATENCIÓN !!!! ANTES DE ANULAR EL APOYO POR FAVOR VERIFIQUE SI DICHO DOCUMENTO SE PUDE CORREGIR. GRACIAS.");
            }
        }

        protected void grvFacturaXCentro_DataBound(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (grvFacturaXCentro.Rows.Count == 0)
                {
                    ddlMotivoAnulacion.Enabled = false; 
                    Alerta("No Hay Apoyos por la Emergencia Económica");
                    return;
                }
            }
        }

        protected void grvFacturaXCentro_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (grvFacturaXCentro.SelectedRow.Cells[9].Text == "Si")
            {
                Alerta("Atención!! El Apoyo Emergencia Económica Ya Fue Anulada");
                return;
            }
            hfNumeroFactura.Value = grvFacturaXCentro.SelectedRow.Cells[6].Text;
            btnAnular.Visible = true;
            ddlMotivoAnulacion.Enabled = true;
            ddlMotivoAnulacion.Focus();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/InventarioAyudas/AnularFactura.aspx", false);
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

        protected void btnAnular_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[CentroFormacion].[Usp_AnularFacturaAyudasUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@NumeroFactura", SqlDbType.BigInt).Value = Convert.ToInt64(hfNumeroFactura.Value);
                    cmd.Parameters.Add("@IdMotivoAnulacion", SqlDbType.Int).Value = Convert.ToInt32(ddlMotivoAnulacion.SelectedValue);
                    cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                    
                    Alerta("Atención!! Apoyo Emergencia Económica Anulada");

                    grvFacturaXCentro.SelectedIndex = -1;
                    grvFacturaXCentro.DataSource = null;
                    grvFacturaXCentro.DataBind();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                    return;
                }
            }


        }

        protected void ddlMotivoAnulacion_DataBound(object sender, EventArgs e)
        {
            ddlMotivoAnulacion.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }
    }
}