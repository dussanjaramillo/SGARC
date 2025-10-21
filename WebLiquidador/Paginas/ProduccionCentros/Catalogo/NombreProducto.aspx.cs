using System;
using System.Data;
using System.Web.UI.WebControls;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Catalogo
{
    public partial class NombreProducto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }
            if (!IsPostBack)
            {
                txtNombreProducto.Focus();
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
           txtNombreProducto.Text = txtNombreProducto.Text.Trim();

            if (ddlProducto.SelectedValue == "1")
            {
                if (txtNombreProducto.Text.Trim().Length < 3)
                {
                    Alerta("Alerta el Nombre del Producto a Buscar debe tener Mínimo 3 Caracteres");
                    txtNombreProducto.Focus();
                    return;
                }
            }

            if (ddlProducto.SelectedValue == "2")
            {
                if (txtNombreProducto.Text.Trim().Length < 10 || txtNombreProducto.Text.Trim().Length > 10)
                {
                    Alerta("Alerta el Código del Producto a Buscar debe tener 10 Caracteres");
                    txtNombreProducto.Focus();
                    return;
                }
            }
            ddlProducto.Enabled = false;
            btnBuscar.Enabled = false;
            txtNombreProducto.Enabled = false;


        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Catalogo/NombreProducto.aspx", false);
        }

        protected void Alerta(string Mensaje)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("alert('");
            sb.Append(Mensaje.Replace("'", "").Replace("\r\n", ""));
            sb.Append("')};");
            sb.Append("</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        }

        protected void grvNombreProducto_DataBound(object sender, EventArgs e)
        {
            if (grvNombreProducto.Rows.Count == 0 && IsPostBack)
            {
                Alerta("Atención!!!! No hay Productos con el " + ddlProducto.SelectedItem + " Especificado");
            }
        }

    }
}