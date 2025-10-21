using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;

namespace WebLiquidador.Paginas.AtencionCiudadano
{
    public partial class EstadoPagoPila : System.Web.UI.Page
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
                BuscarPeriodoInicial();
                grvLosPagos.Caption = "Pagos Aportes Parafiscales desde: " + hfVigenciaMesMin.Value + " hasta: " + hfVigenciaMesMax.Value;
            }
        }

        protected void BuscarPeriodoInicial()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_BuscarPrimerPeriodo]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfVigenciaMesMin.Value = reader[0].ToString().Substring(0, 4) + "-" + reader[0].ToString().Substring(4, 2);
                            hfVigenciaMesMax.Value = reader[1].ToString().Substring(0, 4) + "-" + reader[1].ToString().Substring(4, 2);
                        }
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void BuscarUltimopago()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_BuscarPagosAportanteUltimoPago]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Identificacion", txtIdentificacion.Text.Trim()));
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfUltimoPeriodo.Value = reader[0].ToString();
                            lbValorPresuntivo.Text = reader[1].ToString();
                            lbIntereses.Text = reader[2].ToString();
                        }
                        con.Close();
                        lbTotal.Text = string.Format("{0:###,###,##0}", Convert.ToInt64(lbValorPresuntivo.Text) + Convert.ToInt64(lbIntereses.Text));
                        lbIntereses.Text = string.Format("{0:###,###,##0}", Convert.ToInt64(lbIntereses.Text));
                        lbValorPresuntivo.Text = string.Format("{0:###,###,##0}", Convert.ToInt64(lbValorPresuntivo.Text));
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            if (txtIdentificacion.Text == string.Empty)
            {
                Alerta("Error, Falta el Numero de Identificación");
                txtIdentificacion.Focus();
                return;
            }
            btnBuscar. Enabled = false;  
        }

        protected void BuscarAportante()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_BuscarPrimerPeriodo]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfVigenciaMesMin.Value = reader[0].ToString().Substring(0, 4) + "-" + reader[0].ToString().Substring(4, 2);
                            hfVigenciaMesMax.Value = reader[1].ToString().Substring(0, 4) + "-" + reader[1].ToString().Substring(4, 2);
                        }
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }


        protected void btn_Limpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/AtencionCiudadano/EstadoPagoPila.aspx", false);
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

        //protected void grvAportantes_DataBound(object sender, EventArgs e)
        //{
        //    if (IsPostBack)
        //    {
        //        if (grvAportantes.Rows.Count == 0)
        //        {
        //            Alerta("Atención, La identificación no sé ha reportado a la Ugpp");
        //            txtIdentificacion.Enabled = true;
        //            btnBuscar.Enabled = true;
        //            grvLosPagos.Visible = false;
        //            grvPeriodoDesactivados.Visible = false;
        //            grvPeriodoExentos.Visible = false;
        //            txtIdentificacion.Focus();
        //        }
        //        else
        //        {
        //            BuscarUltimopago();
        //            BuscarPeriodoExentos();
        //            txtIdentificacion.Enabled = false;
        //            btnBuscar.Enabled = false;
        //        }
        //    }
        //}

        private void BuscarPeriodoExentos()
        {
            try
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["AportesDConnectionString"].ToString();
                OracleCommand cmd = new OracleCommand();
                DataTable dt = new DataTable();
                using (OracleConnection con = new OracleConnection(CadenaConexion))
                {
                    cmd.Connection = con;
                    cmd.CommandText = "SELECT DISTINCT VIGENCIA Año, Meses, 'Si' Ene, 'Si' Feb, 'Si' Mar, 'Si' Abr, 'Si' May, 'Si' Jun, 'Si' Jul, 'Si' Ago, 'Si' Sep, 'Si' Oct, 'Si' Nov, 'Si' Dic FROM APORTES.AP_MESES_EXENTOS WHERE NIT = '" + txtIdentificacion.Text.Trim() + "' ORDER BY 1";
                    cmd.CommandType = System.Data.CommandType.Text;
                    using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                    {
                        dt = new DataTable();
                        da.Fill(dt);
                        grvPeriodoExentos.DataSource = dt;
                        grvPeriodoExentos.DataBind();
                    }
                    cmd.Dispose();
                    con.Close();
                }
            }
            catch (OracleException ex)
            {
                Alerta("Error: " + ex.Message);
                return;
            }

            int Filas = grvPeriodoExentos.Rows.Count;

            if (Filas > 0)
            {
                foreach (GridViewRow row in grvPeriodoExentos.Rows)
                {
                    //string VigenciaExenta = row.Cells[0].Text;
                    string MesesExentos = row.Cells[1].Text;

                    for (int i = 0; i < MesesExentos.Length; i++)
                    {
                        if (MesesExentos.Substring(i, 1) == "0")
                        {
                            row.Cells[i + 2].Text = row.Cells[i + 2].Text = "No";
                        }
                    }
                }
            }
        }

        protected void grvLosPagos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    string _Año = e.Row.Cells[0].Text.ToString();

                    if (_Año == hfUltimoPeriodo.Value.Substring(0,4))
                    {
                        int Colummna = Convert.ToInt32(hfUltimoPeriodo.Value.Substring(4, 2))+ Convert.ToInt32(hfUltimoPeriodo.Value.Substring(4, 2)) - 1;
                        e.Row.Cells[Colummna].BackColor = Color.Yellow; ;
                        e.Row.Cells[Colummna].BackColor = Color.Yellow;
                        e.Row.Cells[Colummna].Font.Bold = true;

                        e.Row.Cells[Colummna+1].BackColor = Color.Yellow;
                        e.Row.Cells[Colummna+1].Font.Bold = true;
                    }
                }
            }
            catch (Exception err)
            {
                string error = err.Message.ToString() + " - " + err.Source.ToString();
            }
        }

        protected void grvLosPagos_DataBound(object sender, EventArgs e)
        {
            if (grvLosPagos.Rows.Count == 0 && IsPostBack )
            {
                lblSinPagos.Visible = true;
                lblSinPagos.Text = "No Hay Pagos de Aportes Parafiscales desde el periodo: " + hfVigenciaMesMin.Value + " hasta el periodo: " + hfVigenciaMesMax.Value;
            }
        }
    }
}