using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace WebLiquidador.Paginas.CostasProcesales.Cuota
{
    public partial class PlanAmortizacion : System.Web.UI.Page
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
                txtIdentificacion.Focus();
                //ddlMunicipio.Items.Insert(0, new ListItem("Seleccione...", "-1"));
            }
            lblEstado.Text = Session["_NombreRegionalUsuario"].ToString();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            BuscarDeudor(txtIdentificacion.Text, 0);
            //btnGuardar.Enabled = true;
            ddlMesesPlazo.Focus();
        }

        protected void BuscarDeudor(string Identificacion, Int32 IdDeudor)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[CostasProcesales].[Usp_BuscarDeudor]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdDeudor", SqlDbType.Int).Value = IdDeudor;
                cmd.Parameters.Add("@Identificacion", SqlDbType.Text).Value = Identificacion.ToString();
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfIdDeudor.Value = reader[0].ToString();
                            txtNombre.Text = reader[2].ToString();
                        }
                        btnBuscar.Enabled = false;
                        txtIdentificacion.Enabled = false;
                        con.Close();
                    }
                    else
                    {
                        Alerta("La Identificacion del Deudor No Existe");
                        txtIdentificacion.Focus();
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
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

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/CostasProcesales/Cuota/PlanAmortizacion.aspx", false);
        }

        protected void btnCalcular_Click(object sender, EventArgs e)
        {
            grvPlan.Visible = true;
            btnImprimir.Enabled = true;
            double t = Convert.ToDouble(txtTasa.Text) / 1200;
            double b = Math.Pow((1 + t), Convert.ToDouble(ddlMesesPlazo.SelectedItem.Text));
            double ValorCuota = t * Convert.ToDouble(txtSaldoCapital.Text) * b / (b - 1);

            double prestamo = Convert.ToDouble(txtSaldoCapital.Text);
            double plazo = Convert.ToDouble(ddlMesesPlazo.SelectedItem.Text);
            double interesporcentaje = Convert.ToDouble(txtTasa.Text);

            double saldo = prestamo;
            double interes = 0;
            double cuotamensual = Math.Round(ValorCuota, 0);
            double capital = 0;
            double TInteres = 0;
            double TCapital = 0;
            double TPagado = 0;

            DataTable dt = new DataTable();
            dt.Columns.Add("Mes", typeof(string));
            dt.Columns.Add("Abono a Capital", typeof(string));
            dt.Columns.Add("Valor Interes", typeof(string));
            dt.Columns.Add("Valor Cuota", typeof(string));
            dt.Columns.Add("Nuevo Saldo", typeof(string));

            for (int i = 1; i <= plazo; i++)
            {
                interes = Math.Round((saldo * interesporcentaje) / 1200, 0);
                capital = Math.Round(cuotamensual - interes, 0);
                saldo = Math.Round(saldo - capital, 0);
                dt.Rows.Add(Convert.ToString(i), string.Format("{0:##,###,###,##0}", Convert.ToInt64(Math.Round(capital, 0))), string.Format("{0:##,###,###,##0}", Convert.ToInt64(Math.Round(interes, 0))), string.Format("{0:##,###,###,##0}", Convert.ToInt64(Math.Round(cuotamensual, 0))), string.Format("{0:##,###,###,##0}", Convert.ToInt64(Math.Round(saldo, 0))));
                TInteres = TInteres + interes;
                TCapital = TCapital + capital;
                TPagado = TPagado + ValorCuota;
            }
            dt.Rows.Add("Totales", string.Format("{0:##,###,###,##0}", Convert.ToInt64(Math.Round(TCapital, 0))), string.Format("{0:##,###,###,##0}", Convert.ToInt64(Math.Round(TInteres, 0))), string.Format("{0:##,###,###,##0}", Convert.ToInt64(Math.Round(TPagado, 0))), "");

            grvPlan.DataSource = dt;
            grvPlan.DataBind();
        }

        protected void btnImprimir_Click(object sender, EventArgs e)
        {
            BorrarPlanAmortizacion();

            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CostasProcesales].[Usp_PlanAmortizacionInsert]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    con.Open();

                    foreach (GridViewRow row in grvPlan.Rows)
                    {
                        if (row.Cells[0].Text == "Totales")
                        { break; }

                        cmd.Parameters.Clear();

                        cmd.Parameters.Add("@IdObligacion", SqlDbType.Int).Value = Convert.ToInt32(hfIdObligacion.Value);
                        cmd.Parameters.Add("@Plazo", SqlDbType.Int).Value = Convert.ToInt32(ddlMesesPlazo.SelectedItem.Text);
                        cmd.Parameters.Add("@Tasa", SqlDbType.Text).Value = txtTasa.Text.ToString();
                        cmd.Parameters.Add("@Mes", SqlDbType.Int).Value = Convert.ToInt32(row.Cells[0].Text);
                        cmd.Parameters.Add("@Capital", SqlDbType.BigInt).Value = Convert.ToInt64(row.Cells[1].Text.Replace(".",""));
                        cmd.Parameters.Add("@Interes", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[2].Text.Replace(".", ""));
                        cmd.Parameters.Add("@Cuota", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[3].Text.Replace(".", ""));
                        cmd.Parameters.Add("@Saldo", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[4].Text.Replace(".", ""));
                        //cmd.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());

                        cmd.ExecuteNonQuery();
                    }
                    con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message.ToString());
                    return;
                }
                Session["_IdObligacion"] = hfIdObligacion.Value;

                string _open = "window.open('VisorPlanAmortizacion.aspx', '_blank');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), _open, true);

             
                //foreach (DataRow row in dt.Rows)
                //{
                //    string valor1 = Convert.ToString(row["Mes"]);
                //    string valor2 = Convert.ToString(row["Abono a Capital"]);
                //    string valor3 = Convert.ToString(row["Valor Interes"]);
                //    string valor4 = Convert.ToString(row["Valor Cuota"]);
                //    string valor5 = Convert.ToString(row["Nuevo Saldo"]);
                //}
            }
        }

        protected void BorrarPlanAmortizacion()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    var Textocmd = "[CostasProcesales].[Usp_PlanAmortizacionDelete]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdObligacion", SqlDbType.Int).Value = Convert.ToInt32(hfIdObligacion.Value);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }


        protected void grvObligaciones_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfIdObligacion.Value = grvObligaciones.SelectedRow.Cells[1].Text;
            txtSaldoCapital.Text = grvObligaciones.SelectedRow.Cells[9].Text;
            txtTasa.Enabled = true;
            ddlMesesPlazo.Enabled = true;
            btnCalcular.Enabled = true;
            ddlMesesPlazo.Focus();
            grvPlan.Visible = false;
            btnImprimir.Enabled = false;
            grvObligaciones.Enabled = false;
        }

        protected void grvObligaciones_DataBound(object sender, EventArgs e)
        {
            if (grvObligaciones.Rows.Count == 0)
            {
                btnImprimir.Enabled = false;
            }
        }

        //protected void ObligacionXIdOblicacion(string IdOblicacion)
        //{
        //    var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
        //    using (SqlConnection con = new SqlConnection(CadenaConexion))
        //    {
        //        var Textocmd = "[CostasProcesales].[Usp_BuscarObligacionXIdObligacion]";
        //        SqlCommand cmd = new SqlCommand(Textocmd, con);
        //        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        //        cmd.Parameters.Add("@IdObligacion", SqlDbType.Int).Value = IdOblicacion.ToString();
        //        try
        //        {
        //            con.Open();
        //            SqlDataReader reader = cmd.ExecuteReader();
        //            if (reader.HasRows)
        //            {
        //                while (reader.Read())
        //                {
        //                    ddlTipoObligacion.SelectedValue = reader[0].ToString();
        //                    ddlRegional.SelectedValue = reader[1].ToString();
        //                    ddlDepartamento.SelectedValue = reader[15].ToString();
        //                    LlenarMunicipio(Convert.ToInt32(reader[15].ToString()));
        //                    ddlMunicipio.SelectedValue = reader[14].ToString();
        //                    LlenarJuzgado(Convert.ToInt32(reader[14].ToString()));
        //                    ddlJuzgado.SelectedValue = reader[2].ToString();
        //                    LlenarAbogado(Convert.ToInt32(reader[1].ToString()));
        //                    ddlAbogado.SelectedValue = reader[3].ToString();
        //                    txtNumeroProceso.Text = reader[4].ToString();
        //                    txtFechaEjecutoria.Text = Convert.ToDateTime(reader[5]).ToShortDateString();
        //                    txtPrimeraInstancia.Text = reader[6].ToString();
        //                    txtSegundaInstancia.Text = reader[7].ToString();
        //                    txtSedeCasacion.Text = reader[8].ToString();
        //                    txtValorCostas.Text = reader[9].ToString();
        //                    txtSaldoCostas.Text = reader[10].ToString();
        //                    txtFechaSaldo.Text = Convert.ToDateTime(reader[11]).ToShortDateString();
        //                    ddlTasaInteres.SelectedValue = reader[12].ToString();
        //                    if (reader[13].ToString() == "")
        //                    {
        //                        chbEsActivo.Checked = false;
        //                    }
        //                    else
        //                    {
        //                        chbEsActivo.Checked = true;
        //                    }
        //                }
        //                con.Close();
        //                btnGuardar.Enabled = true;
        //                grvObligaciones.Enabled = true;
        //                ddlTipoObligacion.Enabled = true;
        //                txtFechaEjecutoria.Enabled = true;
        //                txtNumeroProceso.Enabled = true;
        //                txtPrimeraInstancia.Enabled = true;
        //                txtSegundaInstancia.Enabled = true;
        //                txtSaldoCostas.Enabled = true;
        //                txtSedeCasacion.Enabled = true;
        //                txtFechaSaldo.Enabled = true;
        //                ddlTasaInteres.Enabled = true;
        //                ddlRegional.Enabled = true;
        //                ddlAbogado.Enabled = true;
        //                ddlDepartamento.Enabled = true;
        //                ddlMunicipio.Enabled = true;
        //                ddlJuzgado.Enabled = true;
        //            }
        //            else
        //            {
        //                Alerta("La Obligacion No Existe");
        //                con.Close();
        //            }
        //        }
        //        catch (SqlException ex)
        //        {
        //            Alerta("Error: " + ex.Message);
        //        }
        //    }
        //}

        //protected void grvObligaciones_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    hfIdObligacion.Value = grvObligaciones.SelectedRow.Cells[1].Text;
        //    txtSaldoCapital.Text = grvObligaciones.SelectedRow.Cells[8].Text;
        //    txtTasa.Enabled = true;
        //    ddlMesesPlazo.Enabled = true;
        //    btnCalcular.Enabled = true;
        //    ddlMesesPlazo.Focus();
        //    grvPlan.Visible = false;
        //    btnImprimir.Enabled = false;
        //}

    }
}