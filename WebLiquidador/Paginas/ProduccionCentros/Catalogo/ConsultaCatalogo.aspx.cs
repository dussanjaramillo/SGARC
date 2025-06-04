using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.ComponentModel;
using System.Text;
using WebLiquidador.App_Code;
using System.Globalization;
using System.Threading;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Catalogo
{
    public partial class ConsultaCatalogo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }
            //if ((new List<string> { "1", "2", "3", "4", "6", "7", "8", "9" }).Contains(Session["_IdCargo"].ToString()))
            //{
            //    Response.Redirect("~/DefaultCf.aspx");
            //}

            if (!IsPostBack)
            {
                ddlCentroFormacion.Items.Insert(0, new ListItem("Seleccione...", "-1"));
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

        protected void ddlRegional_DataBound(object sender, EventArgs e)
        {
            ddlRegional.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void BuscarCentroFormacion()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            var Textocmd = "[dbo].[Usp_BuscarCentroFormacionXRegional]";
            SqlConnection con = new SqlConnection(CadenaConexion);
            SqlCommand cmd = new SqlCommand(Textocmd, con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IdRegional", Convert.ToInt16(ddlRegional.SelectedValue.ToString()));

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
            Response.Redirect("~/Paginas/ProduccionCentros/Catalogo/ConsultaCatalogo.aspx", false);
        }

        protected void ddlRegional_SelectedIndexChanged(object sender, EventArgs e)
        {
            BuscarCentroFormacion();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {

        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            try
            {
                string PathArchivo = ddlRegional.SelectedItem.ToString() + "_CatalogoProductos_" + ddlCentroFormacion.SelectedItem.ToString() + ".txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[dbo].[Usp_BuscarCatalogoXCentroFormacion]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(ddlCentroFormacion.SelectedValue);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    con.Close();

                    if (dt.Rows.Count > 0)
                    {
                        grvCatalogoCentro0.Visible = true;
                        grvCatalogoCentro0.Caption = "CatalogoProductos_Regional_" + ddlRegional.SelectedItem.ToString() + "_" + ddlCentroFormacion.SelectedItem.ToString();
                        System.Text.StringBuilder sb = new System.Text.StringBuilder();
                        System.IO.StringWriter sw = new System.IO.StringWriter(sb);
                        HtmlTextWriter htw = new HtmlTextWriter(sw);

                        Page page = new Page();
                        System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

                        grvCatalogoCentro0.AllowPaging = false;
                        grvCatalogoCentro0.AllowSorting = false;
                        grvCatalogoCentro0.EnableViewState = false;

                        // Deshabilitar la validación de eventos, sólo asp.net 2
                        page.EnableEventValidation = false;

                        // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
                        page.DesignerInitialize();

                        page.Controls.Add(form);
                        form.Controls.Add(grvCatalogoCentro0);

                        page.RenderControl(htw);

                        Response.Clear();
                        Response.Buffer = true;
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        Response.AddHeader("Content-Disposition", "attachment;filename=" + "CatalogoProductos_Regional_" + ddlRegional.SelectedItem.ToString() + "_" + ddlCentroFormacion.SelectedItem.ToString() + ".xls");
                        Response.Charset = "UTF-8";
                        Response.ContentEncoding = System.Text.Encoding.Default;
                        Response.Write(sb.ToString());
                        Response.End();
                        grvCatalogoCentro0.Visible = false;  
                    }
                    else
                    {
                        Alerta("Alerta: No Hay Cátalogo de Productos para este Centro");
                        return;
                    }
                }
            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }
        }

        protected void ddlCentroFormacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnExportar.Visible = true;
            grvCatalogoCentro.DataSource = null;
            grvCatalogoCentro.Caption = ddlCentroFormacion.SelectedItem.Text;
        }
    }
}