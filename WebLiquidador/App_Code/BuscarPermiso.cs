using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace WebLiquidador.App_Code
{
    public class BuscarPermiso
    {
        public Permisos BuscarPermisoUsuario(string CodigoUsuario, string NombrePrograma)
        {
            Permisos oPermiso = new Permisos();
            var CadenaConexion = ConfigurationManager.ConnectionStrings["RuptaConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                var Textocmd = "[dbo].[Usp_PermisoConsultarXUsuario]";
                SqlCommand cmd = new SqlCommand(Textocmd, con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@CodigoUsuario", SqlDbType.Text).Value = CodigoUsuario;
                cmd.Parameters.Add("@NombrePrograma", SqlDbType.Text).Value = NombrePrograma;
                try
                {
                    Boolean Agregar = false;
                    Boolean Modificar = false;
                    Boolean Consultar = false;

                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Agregar = Convert.ToBoolean(reader[0]);
                            Modificar = Convert.ToBoolean(reader[1]);
                            Consultar = Convert.ToBoolean(reader[2]);
                        }
                        con.Close();
                        oPermiso.Agregar = Agregar;
                        oPermiso.Modificar = Modificar;
                        oPermiso.Consultar = Consultar;
                    }
                }
                catch (Exception ex)
                {
                    string cad = ex.Message;
                }
                return oPermiso;
            }
        }
    }
}