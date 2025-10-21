using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Text;


namespace WebLiquidador.Paginas.ProduccionCentros
{
    public partial class UnidadProductiva : System.Web.UI.Page
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
                lblEstado.Text = "Agregando";
            }
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
                        var Textocmd = "[CentroFormacion].[Usp_UnidadProductivaUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdUnidadProductiva", SqlDbType.Int).Value = Convert.ToInt32(hfIdUnidadProductiva.Value);
                        cmd.Parameters.Add("@NombreUnidadProductiva", SqlDbType.Text).Value = txtNombreUnidadProductiva.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(ddlCentroFormacion.SelectedValue.ToString());
                        if (chbEsActivo.Checked)
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = true;
                        }
                        else
                        {
                            cmd.Parameters.Add("@EsActivo", SqlDbType.Bit).Value = false;
                        }
                        cmd.Parameters.Add("@IdUsuarioModifica", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();

                        Alerta("Centro Formación Actualizado");
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
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        var Textocmd = "[CentroFormacion].[Usp_UnidadProductivaInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@NombreUnidadProductiva", SqlDbType.Text).Value = txtNombreUnidadProductiva.Text.ToString().Trim();
                        cmd.Parameters.Add("@IdCentroFormacion", SqlDbType.Int).Value = Convert.ToInt32(ddlCentroFormacion.SelectedValue.ToString());
                        cmd.Parameters.Add("@IdUsuarioCrea", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        int vResultado = 0;
                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();

                        lblEstado.Text = "Agregando";
                        Alerta("Unidad Productiva Agregada");
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
            grvUnidadProductiva.DataSource = null;
            grvUnidadProductiva.DataBind();
            txtNombreUnidadProductiva.Text = "";
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/ProduccionCentros/UnidadProductiva.aspx", false);
        }

        protected void ddlRegional_DataBound(object sender, EventArgs e)
        {
            ddlRegional.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void ddlRegional_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlCentroFormacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnGuardar.Enabled = true; 
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

        protected void ddlCentroFormacion_DataBound(object sender, EventArgs e)
        {
            ddlCentroFormacion.Items.Insert(0, new ListItem("Seleccione...", "-1"));
        }

        protected void grvUnidadProductiva_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfIdUnidadProductiva.Value = grvUnidadProductiva.SelectedRow.Cells[3].Text;
            BuscarUnidadProductiva(Convert.ToInt32(grvUnidadProductiva.SelectedRow.Cells[3].Text));
        }

        protected void BuscarUnidadProductiva(Int32 IdUnidadProductiva)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CentroFormacion].[Usp_UnidadProductivaXIdBuscar]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdUnidadProductiva", SqlDbType.Int).Value = IdUnidadProductiva;
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            ddlRegional.SelectedValue = reader[0].ToString();
                            hfIdCentroFormacion.Value = reader[2].ToString();
                            txtNombreUnidadProductiva.Text = reader[4].ToString();
                            chbEsActivo.Checked = Convert.ToBoolean(reader[5].ToString());
                            hfTransaccion.Value = "1";
                        }

                        ddlCentroFormacion.DataSource = null;
                        ddlCentroFormacion.DataBind();
                        ddlCentroFormacion.SelectedValue = hfIdCentroFormacion.Value;

                        lblEstado.Text = "Modificando";
                        btnGuardar.Enabled = true;
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void btnExportar_Click(object sender, EventArgs e)
        {
            try
            {
                string PathArchivo = "UnidadProductiva.txt";
                var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    var Textocmd = "[CentroFormacion].[Usp_UnidadProductivaBuscarUnicos]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
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
                        else
                        {
                            Alerta("Alerta: No Hay Registros");
                            return;
                        }
                    }
                }

            }
            catch (SqlException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }
        }
    }
}