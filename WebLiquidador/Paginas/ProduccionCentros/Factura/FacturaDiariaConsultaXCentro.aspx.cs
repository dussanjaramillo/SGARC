using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Factura
{
    public partial class FacturaDiariaConsultaXCentro : System.Web.UI.Page
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
                lblEstado.Text = Session["_NombreCentroFormacion"].ToString();
                ddlCentroFormacion.Items.Insert(0, new ListItem("Seleccione...", "-1"));

                BuscarCentroFormacion(Session["_IdRegional"].ToString());

                if (Session["_IdCentroFormacion"].ToString() != "118")
                {
                    ddlRegional.SelectedValue = Session["_IdRegional"].ToString();
                    ddlRegional.Enabled = false;
                    ddlCentroFormacion.SelectedValue = Session["_IdCentroFormacion"].ToString();
                    ddlCentroFormacion.Enabled = false;
                }
            }
        }

        protected void BuscarCentroFormacion(String Regional)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            var Textocmd = "[dbo].[Usp_BuscarCentroFormacionXRegional]";
            SqlConnection con = new SqlConnection(CadenaConexion);
            SqlCommand cmd = new SqlCommand(Textocmd, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IdRegional", Convert.ToInt16(Regional));

            SqlDataAdapter CentroFormacion = new SqlDataAdapter(cmd);
            DataSet dsCentroFormacion = new DataSet();
            CentroFormacion.Fill(dsCentroFormacion, "CentroFormacion");

            ddlCentroFormacion.DataSource = dsCentroFormacion.Tables["CentroFormacion"].DefaultView;
            ddlCentroFormacion.DataTextField = "NombreCentroFormacion";
            ddlCentroFormacion.DataValueField = "IdCentroFormacion";
            ddlCentroFormacion.DataBind();
            ddlCentroFormacion.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Factura/FacturaDiariaConsultaXCentro.aspx", false);
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

        protected void grvProductosFacturaDiaria_DataBound(object sender, EventArgs e)
        {
            if (grvProductosFacturaDiaria.Rows.Count == 0 && ddlRegional.SelectedValue != "-1" && ddlCentroFormacion.SelectedValue != "-1")
            {
                Alerta("La Prefactura Diaria No Tiene Productos");
            }
        }

        protected void ddlRegional_SelectedIndexChanged(object sender, EventArgs e)
        {
            BuscarCentroFormacion(ddlRegional.SelectedValue.ToString());
        }

        protected void ddlCentroFormacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            grvProductosFacturaDiaria.DataSource = null;
            grvProductosFacturaDiaria.Caption = ddlCentroFormacion.SelectedItem.Text;
        }

        protected void ddlRegional_DataBound(object sender, EventArgs e)
        {
            ddlRegional.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

    }
}