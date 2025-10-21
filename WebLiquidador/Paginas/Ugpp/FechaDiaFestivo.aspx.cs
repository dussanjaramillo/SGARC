using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Globalization;
using System.Threading;
using System.Data.SqlClient;
using System.Data;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador.Paginas.Ugpp
{
    public partial class FechaDiaFestivo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }
            //Cargos
            //1   01  Coordinador
            //2   02  Abogado
            //3   03  Fiscalizador
            //4   04  Técnico
            //5   05  Administrador
            //6   06  Profesional
            //7   07  Siif - Nación
            //8   08  Subdirector
            //9   09  Producción
            //10  10  Control Interno
            if (!(new List<string> { "5" }).Contains(Session["_IdCargo"].ToString()))
            {
                Response.Redirect("~/Default.aspx");
            }
           
            if (!IsPostBack)
            {
                txtFechaDiaFestivo.Focus();
                HfTransaccion.Value = "0";
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                HfTransaccion.Value = "0";
                var Textocmd = "[dbo].[Usp_BuscaFechaDiaFestivoXFechaDiaFestivo]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@FechaDiaFestivo", txtFechaDiaFestivo.Text.Trim());

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfIdFechaDiaFestivo.Value = reader[0].ToString();
                            txtFechaDiaFestivo.Text = Convert.ToDateTime(reader[1]).ToShortDateString(); 
                            txtFechaDiaFestivo.Focus();
                            HfTransaccion.Value = "1";
                        }
                        btnBuscar.Enabled = false;
                        con.Close();
                    }
                    else
                    {
                        Alerta("La Fecha Dia Festivo No Existe");
                        txtFechaDiaFestivo.Focus();
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
       
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!IsValid)
            {
                return;
            }

            //Rol Existe se hace un Update
            if (HfTransaccion.Value == "1")
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        int vResultado;
                        var Textocmd = "[dbo].[Usp_FechaDiaFestivoUpdate]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdFechaDiaFestivo", SqlDbType.BigInt).Value = Convert.ToInt32(hfIdFechaDiaFestivo.Value);
                        cmd.Parameters.Add("@FechaDiaFestivo", SqlDbType.Date).Value = Convert.ToDateTime(txtFechaDiaFestivo.Text).ToShortDateString();
                        cmd.Parameters.Add("@Estado", SqlDbType.Bit).Value = true;

                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();

                        Alerta("Fecha Dia Festivo Actualizado");
                    }
                    catch (SqlException ex)
                    {
                        Alerta("Error: " + ex.Message);
                    }
                }
            }
            else
            {
                var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
                using (SqlConnection con = new SqlConnection(CadenaConexion))
                {
                    try
                    {
                        var Textocmd = "[dbo].[Usp_FechaDiaFestivoInsert]";
                        SqlCommand cmd = new SqlCommand(Textocmd, con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@IdFechaDiaFestivo", SqlDbType.BigInt).Value = DbType.Int32;
                        cmd.Parameters.Add("@FechaDiaFestivo", SqlDbType.Date).Value = Convert.ToDateTime(txtFechaDiaFestivo.Text).ToShortDateString();
                        cmd.Parameters.Add("@Estado", SqlDbType.Bit).Value = true;

                        int vResultado = 0;
                        con.Open();
                        vResultado = cmd.ExecuteNonQuery();
                        con.Close();

                        Alerta("Fecha Dia Festivo Agregada");
                    }
                    catch (SqlException ex)
                    {
                        Alerta("Error: " + ex.Message.ToString());
                    }
                }
            }

        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/Ugpp/FechaDiaFestivo.aspx", false);
        }

        protected void gvrFechaDiaFestivo_SelectedIndexChanged(object sender, EventArgs e)
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["PlanillaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_BuscaFechaDiaFestivoXIdFechaDiaFestivo]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdFechaDiaFestivo", gvrFechaDiaFestivo.SelectedRow.Cells[1].Text);
                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            hfIdFechaDiaFestivo.Value = reader[0].ToString();
                            txtFechaDiaFestivo.Text = Convert.ToDateTime(reader[1]).ToShortDateString(); 
                            txtFechaDiaFestivo.Focus();
                            HfTransaccion.Value = "1";
                            btnBuscar.Enabled = false;
                        }
                    }
                    else
                    {
                        Alerta("Fecha Dia Festivo Incorrecta");
                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }
    }
}