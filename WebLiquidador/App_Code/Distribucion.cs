using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebLiquidador.App_Code
{
    public class Distribucion
    {
        public Int32 Item { get; set; }
        public Int32 IdCentroProduccion { get; set; }
        public String NombreCentroProduccion { get; set; }
        public Int64 ValorCupon { get; set; }
    }
}