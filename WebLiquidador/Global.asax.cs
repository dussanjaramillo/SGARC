using System;
using System.Web;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci 

namespace WebLiquidador
{
    public class Global : System.Web.HttpApplication
    {
        public static object ThisAddIn { get; internal set; }

        void Application_Start(object sender, EventArgs e)
        {
            // Código que se ejecuta al iniciarse la aplicación
        }

        void Application_End(object sender, EventArgs e)
        {
            //  Código que se ejecuta cuando se cierra la aplicación
            //CerrarAplicación();
        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs
            // Give the user some information, but
            // stay on the default page

            Exception exc = Server.GetLastError();
            Response.Write("<h2>Error en la Página</h2>\n");
            Response.Write("<p>" + exc.InnerException + "</p>\n");
            Response.Write("Return to the <a href='/Inicio.aspx'>" + "Inicio</a>\n");
            // Log the exception and notify system operators
            ExceptionUtility.LogException(exc, Server.GetLastError().Message);
            ExceptionUtility.NotifySystemOps(exc);

            // Clear the error from the server
            Server.ClearError();
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
            //ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        }

        public sealed class ExceptionUtility
        {
            // All methods are static, so this can be private
            private ExceptionUtility()
            { }

            // Log an Exception
            public static void LogException(Exception exc, string source)
            {
                // Include enterprise logic for logging exceptions
                // Get the absolute path to the log file
                string logFile = "~/App_Data/ErrorLog.txt";
                logFile = HttpContext.Current.Server.MapPath(logFile);

                // Open the log file for append and write the log
                StreamWriter sw = new StreamWriter(logFile, true);
                sw.Write("******************** " + DateTime.Now);
                sw.WriteLine(" ********************");
                if (exc.InnerException != null)
                {
                    sw.Write("Inner Exception Type: ");
                    sw.WriteLine(exc.InnerException.GetType().ToString());
                    sw.Write("Inner Exception: ");
                    sw.WriteLine(exc.InnerException.Message);
                    sw.Write("Inner Source: ");
                    sw.WriteLine(exc.InnerException.Source);
                    if (exc.InnerException.StackTrace != null)
                        sw.WriteLine("Inner Stack Trace: ");
                    sw.WriteLine(exc.InnerException.StackTrace);
                }
                sw.Write("Exception Type: ");
                sw.WriteLine(exc.GetType().ToString());
                sw.WriteLine("Exception: " + exc.Message);
                sw.WriteLine("Source: " + source);
                sw.WriteLine("Stack Trace: ");
                if (exc.StackTrace != null)
                    sw.WriteLine(exc.StackTrace);
                sw.WriteLine();
                sw.Close();
            }

            // Notify System Operators about an exception
            public static void NotifySystemOps(Exception exc)
            {
                // Include code for notifying IT system operators
            }
        }

        void Session_Start(object sender, EventArgs e)
        {
            // Código que se ejecuta cuando se inicia una nueva sesión
            GrabarNumeroVisitante();
        }

        void Session_End(object sender, EventArgs e)
        {
            // Código que se ejecuta cuando finaliza una sesión.
            // Nota: el evento Session_End se desencadena sólo cuando el modo sessionstate
            // se establece como InProc en el archivo Web.config. Si el modo de sesión se establece como StateServer 
            // o SQLServer, el evento no se genera.
        }

        protected void GrabarNumeroVisitante()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    long vResultado;
                    var Textocmd = "[Seguridad].[Usp_VisitaUpdate]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    SqlParameter outputIdParam = new SqlParameter("@NumeroVisita", SqlDbType.BigInt) { Direction = ParameterDirection.Output };
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(outputIdParam);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    vResultado = Convert.ToInt64(cmd.Parameters[0].Value);
                    con.Close();
                    Session["_NumeroVisitante"] = vResultado.ToString();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }

        protected void CerrarAplicacion()
        {
            var CadenaConexion = ConfigurationManager.ConnectionStrings["CentroFormacion"].ToString();
            using (SqlConnection con = new SqlConnection(CadenaConexion))
            {
                try
                {
                    int vResultado;
                    var Textocmd = "[Seguridad].[Usp_CerrarAplicacion]";
                    SqlCommand cmd = new SqlCommand(Textocmd, con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@IdUsuario", SqlDbType.BigInt).Value = Convert.ToInt32(Session["_IdUsuario"].ToString());
                    con.Open();
                    vResultado = cmd.ExecuteNonQuery();
                    con.Close();
                }
                catch (SqlException ex)
                {
                    Alerta("Error: " + ex.Message);
                }
            }
        }
    }
}
