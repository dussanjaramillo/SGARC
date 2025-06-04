using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebLiquidador
{
    public partial class SiteCf : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }

            LblNumeroVisitante.Text = "Visitante: " + string.Format("{0:00000000}", Convert.ToInt64(Session["_NumeroVisitante"].ToString()));

            var CambioClave = (string)Session["_CambioClave"];
            var Seguimiento = (string)Session["_Seguimiento"];
            var IpTelefono = (string)Session["_IpTelefono"];
            //var ApoyoEE = (string)Session["_ApoyoEE"];

            if (CambioClave == "1" || Seguimiento == "1" || IpTelefono == "1")
            {
                NavigationMenu.Visible = false;
            }

            if (!IsPostBack)
            {
                try
                {
                    //if ((new List<string> { "10" }).Contains(Session["_IdCargo"].ToString()))
                    //{   
                    //    //Página Principal
                    //    NavigationMenu.Items[0].Enabled = false;
                    //    //NavigationMenu.Items[0].ChildItems[2].Enabled = false;

                    //    //Gestión
                    //    NavigationMenu.Items[1].Enabled = false;
                        
                    //    //Emergencia Económica
                    //    NavigationMenu.Items[2].ChildItems[0].ChildItems[0].Enabled = false;    //Emergencia Económica/Inventario/Entradas
                    //    NavigationMenu.Items[2].ChildItems[1].ChildItems[0].Enabled = false;  
                    //    NavigationMenu.Items[2].ChildItems[1].ChildItems[2].Enabled = false;

                    //    //Catálogo
                    //    NavigationMenu.Items[3].Enabled = false;

                    //    //Prefactura
                    //    NavigationMenu.Items[4].Enabled = false;

                    //    //Cargar
                    //    NavigationMenu.Items[5].Enabled = false;

                    //    //Usuario
                    //    //NavigationMenu.Items[6].Enabled = false;
                    //    NavigationMenu.Items[6].ChildItems[1].Enabled = false;
                    //    NavigationMenu.Items[6].ChildItems[3].Enabled = false;
                    //    NavigationMenu.Items[6].ChildItems[4].Enabled = false;

                    //    //Parámetro
                    //    NavigationMenu.Items[7].Enabled = false;

                    //    //Salir
                    //    //NavigationMenu.Items[8].Enabled = false;
                    //}

                    LblNombreUsuario.Text = Session["_NombreUsuario"].ToString() + " - " + Session["_NombreCargo"].ToString(); ;
                    LblNombreEntidad.Text = Session["_NombreRegionalUsuario"].ToString() + " - " + Session["_NombreCentroFormacion"].ToString();
                    LblFecha.Text = DateTime.Now.ToString("dddd, dd MMMM yyyy");
                }
                catch (Exception ex)
                {
                    LblNombreUsuario.Text = ex.Message;
                    return;
                }
            }
        }
    }
}