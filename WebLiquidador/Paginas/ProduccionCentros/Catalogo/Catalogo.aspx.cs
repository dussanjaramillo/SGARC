using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Threading;
using System.IO;
using System.Text;


//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.ProduccionCentros.Catalogo
{
    public partial class Catalogo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            //if (!(new List<string> { "5" }).Contains(Session["_IdCargo"].ToString()))
            //{
            //    Response.Redirect("~/DefaultCf.aspx");
            //}

            if (!IsPostBack)
            {
                ddlGrupo.Focus();
                ddlAccion.Items.Insert(0, new ListItem("Seleccione...", "-1"));
                ddlInventariable.Items.Insert(0, new ListItem("Seleccione...", "-1"));
            }
            //lblEstado.Text = "Agregando";
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

        protected void ddlGrupo_DataBound(object sender, EventArgs e)
        {
            ddlGrupo.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlSegmento_DataBound(object sender, EventArgs e)
        {
            ddlSegmento.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlFamilia_DataBound(object sender, EventArgs e)
        {
            ddlFamilia.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlClase_DataBound(object sender, EventArgs e)
        {
            ddlClase.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlProducto_DataBound(object sender, EventArgs e)
        {
            ddlProducto.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/Catalogo/Catalogo.aspx", false);
        }

        protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Session["_IdCargo"].ToString() == "5")
            {
                hfCodigoProducto.Value = ddlProducto.SelectedItem.Text.Substring(0, 10);
                BuscarProductoInventariable();

                txtCodigoProducto.Text = "";
                txtNombreProducto.Text = "";
                txtDescripcionProducto.Text = "";

                ddlGrupo.Enabled = false;
                ddlSegmento.Enabled = false;
                ddlFamilia.Enabled = false;
                ddlClase.Enabled = false;
                ddlDescripcionProducto.Enabled = false;

                ddlAccion.Enabled = true;
                ddlAccion.SelectedIndex = -1;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            BuscarCodigoProducto();

            if (hfTransaccion.Value == "1" && ddlAccion.SelectedValue == "2")
            {
                Alerta("Atención!!!! El Código del Producto ya Existe");
                return;
            }

            //Existe Registro se hace un Update
            if (ddlAccion.SelectedValue == "1")
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        int vResultado;
                        var Textocmd = "[UNSPSC].[Usp_ProductoUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdProducto", SqlDbType.Int).Value = Convert.ToInt32(hfIdProducto.Value);

                        cmd.Parameters.Add("@IdClase", SqlDbType.Int).Value = Convert.ToInt32(ddlClase.SelectedValue);
                        cmd.Parameters.Add("@CodigoProducto", SqlDbType.Text).Value = txtCodigoProducto.Text.ToString().Trim();
                        cmd.Parameters.Add("@NombreProducto", SqlDbType.Text).Value = txtNombreProducto.Text.ToString().Trim();
                        cmd.Parameters.Add("@DescripcionProducto", SqlDbType.Text).Value = txtDescripcionProducto.Text.Trim();

                        if (chbEsActivo.Checked)
                        { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true; }
                        else
                        { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false; }

                        cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Session["_IdUsuario"].ToString();
                        cmd.Parameters.Add("@Inventariable", SqlDbType.Text).Value = ddlInventariable.SelectedValue;

                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();
                        Alerta("Listo!!!! Producto Actualizado Correctamente");
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
                        var Textocmd = "[UNSPSC].[Usp_ProductoInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdClase", SqlDbType.Int).Value = Convert.ToInt32(ddlClase.SelectedValue) ;
                        cmd.Parameters.Add("@CodigoProducto", SqlDbType.Text).Value = txtCodigoProducto.Text.ToString().Trim();
                        cmd.Parameters.Add("@NombreProducto", SqlDbType.Text).Value = txtNombreProducto.Text.ToString().Trim();
                        cmd.Parameters.Add("@DescripcionProducto", SqlDbType.Text).Value = txtDescripcionProducto.Text.Trim();

                        if (chbEsActivo.Checked)
                        { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true; }
                        else
                        { cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false; }

                        cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Session["_IdUsuario"].ToString();
                        cmd.Parameters.Add("@Inventariable", SqlDbType.Text).Value = ddlInventariable.SelectedValue;

                        SqlParameter outputIdParam = new SqlParameter("@IdProducto", SqlDbType.Int) { Direction = ParameterDirection.Output };
                        cmd.Parameters.Add(outputIdParam);
                        int vResultado;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        vResultado = Convert.ToInt32(cmd.Parameters["@IdProducto"].Value);
                        con.Close();
                        Alerta("Listo!!! Producto Guardado Correctamente");
                    }
                    catch (SqlException ex)
                    {
                        Alerta("Error: " + ex.Message.ToString());
                    }
                }
            }
            btnGuardar.Enabled = false;
            ddlAccion.SelectedIndex = -1;
            ddlAccion.Enabled = false;
        }

        protected void BuscarCodigoProducto()
        {
            hfTransaccion.Value = "0";
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[UNSPSC].[Usp_BuscarProductoXCodigoProducto]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@CodigoProducto", SqlDbType.Text).Value = txtCodigoProducto.Text.Trim();

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfTransaccion.Value = "1";
                            hfIdProducto.Value = reader[0].ToString();
                        }
                        con.Close();
                    }
                    else
                    {
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void BuscarProductoInventariable()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[UNSPSC].[Usp_BuscarProductoXCodigoProducto]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@CodigoProducto", SqlDbType.Text).Value = hfCodigoProducto.Value;

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            if (reader[4].ToString() == "1")
                            {chbEsActivo.Checked = true; }
                            else
                            {chbEsActivo.Checked = false;}

                            ddlInventariable.SelectedValue = reader[5].ToString();
                        }
                        con.Close();
                    }
                    else
                    {
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void ddlGrupo_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlSegmento.SelectedIndex = -1;
            ddlFamilia.SelectedIndex = -1;
            ddlClase.SelectedIndex = -1;
            ddlProducto.SelectedIndex = -1;
            ddlSegmento.Focus();
        }

        protected void ddlSegmento_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlClase.SelectedIndex = -1;
            ddlProducto.SelectedIndex = -1;
            ddlFamilia.SelectedIndex = -1;
            ddlFamilia.Focus();
        }

        protected void ddlFamilia_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlProducto.SelectedIndex = -1;
            ddlClase.SelectedIndex = -1;
            ddlClase.Focus();            
        }

        protected void ddlClase_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlProducto.SelectedIndex = -1;
            ddlProducto.Focus();
        }

        protected void ddlAccion_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlAccion.SelectedValue == "1")
            {
                txtCodigoProducto.Text = ddlProducto.SelectedItem.Text.Substring(0, 10);
                txtNombreProducto.Text = ddlProducto.SelectedItem.Text.Substring(11, ddlProducto.SelectedItem.Text.Length - 11);
                txtDescripcionProducto.Text = ddlDescripcionProducto.SelectedItem.Text;
                txtCodigoProducto.Enabled = false;
                txtNombreProducto.Enabled = true;
                txtDescripcionProducto.Enabled = true;
                ddlInventariable.Enabled = true;
            }
            else
            {
                txtCodigoProducto.Text = "";
                txtCodigoProducto.Enabled = true;
                txtNombreProducto.Text = "";
                txtDescripcionProducto.Text = "";
                txtNombreProducto.Enabled = true;
                txtDescripcionProducto.Enabled = true;
                ddlInventariable.Enabled = true;
                txtCodigoProducto.Focus();
            }
            chbEsActivo.Enabled = true;
            chbEsActivo.Checked = true;
            btnGuardar.Enabled = true;
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            if (grvCatalogoUNSPSC.Rows.Count == 0)
            {
                Alerta("Atención, No hay Productos en UNSPSC");
                return;
            }

            if (ddlTipoArchivo.SelectedValue == "1")
            {
                ExportarTxt();
            }
            else
            {
                ExportarExcel();
            }
        }

        protected void ExportarTxt()
        {
            try
            {
                string PathArchivo = "CatalogoProductos_UNSPSC_" + DateTime.Now.ToShortDateString().Replace("/", "_") + ".txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[CentroFormacion].[Usp_BuscarCatalogoUNSPSC]";

                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandTimeout = 0;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    con.Close();

                    if (dt.Rows.Count > 0)
                    {
                        StringBuilder sb = new StringBuilder();
                        IEnumerable<string> columnNames = dt.Columns.Cast<DataColumn>().Select(column => column.ColumnName);
                        sb.AppendLine(string.Join("|", columnNames));

                        foreach (DataRow row in dt.Rows)
                        {
                            IEnumerable<string> fields = row.ItemArray.Select(field => field.ToString());
                            sb.AppendLine(string.Join("|", fields));
                        }

                        if (sb.Length > 0)
                        {
                            Response.Clear();
                            Response.Buffer = true;
                            Response.ContentType = "application/text/plain";
                            Response.AddHeader("Content-Disposition", "attachment;filename=" + PathArchivo);
                            Response.Charset = "UTF-8";
                            Response.ContentEncoding = System.Text.Encoding.Default;
                            Response.Write(sb.ToString());
                            Response.End();
                        }
                    }
                    else
                    {
                        Alerta("Atención: No Hay Registros");
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

        protected void ExportarExcel()
        {
            grvCatalogoUNSPSC.Visible = true;
            grvCatalogoUNSPSC.Caption = "Catálogo Productos UNSPSC";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);

            Page page = new Page();
            System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();

            grvCatalogoUNSPSC.AllowPaging = false;
            grvCatalogoUNSPSC.AllowSorting = false;
            grvCatalogoUNSPSC.EnableViewState = false;

            // Deshabilitar la validación de eventos, sólo asp.net 2
            page.EnableEventValidation = false;

            // Realiza las inicializaciones de la instancia de la clase Page que requieran los diseñadores RAD.
            page.DesignerInitialize();

            page.Controls.Add(form);
            form.Controls.Add(grvCatalogoUNSPSC);

            page.RenderControl(htw);

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "CatalogoProductos_UNSPSC.xls");
            Response.Charset = "UTF-8";
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Write(sb.ToString());
            Response.End();
            grvCatalogoUNSPSC.Visible = false;

        }

    }
}