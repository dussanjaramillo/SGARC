using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//--- Autor: Ingeniero Ricardo Vanegas Ricci
//--- Celular 314 35 65 719 
//--- Derechos de Autor: Ricardo Vanegas Ricci

namespace WebLiquidador
{

    public partial class AboutCf : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_NombreUsuario"] == null)
            {
                Response.Redirect("~/Inicio.aspx", false);
                return;
            }
            IsValidNit("8999990341");
        }

        bool IsValidNit(string nit)
        {
            if (nit == null)
                throw new ArgumentNullException(nameof(nit));
            if (nit.Length != 10)
                return false;
            var digitos = new byte[10];
            for (int i = 0; i < nit.Length; i++)
            {
                if (!char.IsDigit(nit[i]))
                    return false;
                digitos[i] = byte.Parse(nit[i].ToString());
            }
            var v = 41 * digitos[0] +
                    37 * digitos[1] +
                    29 * digitos[2] +
                    23 * digitos[3] +
                    19 * digitos[4] +
                    17 * digitos[5] +
                    13 * digitos[6] +
                    7 * digitos[7] +
                    3 * digitos[8];
            v = v % 11;
            if (v >= 2)
                v = 11 - v;
            return v == digitos[9];
        }
    }
}