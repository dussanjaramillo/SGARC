using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebLiquidador.App_Code
{
    public class ProductosFactura
    {
        public Int32 Item { get; set; }
        public Int32 IdProducto { get; set; }
        public String Nombre { get; set; }
        public Int32 Cantidad { get; set; }
        public Int64 Precio { get; set; }
        public Int64 Valor { get; set; }
        public Int32 IdUnidadMedida { get; set; }
        public String NombreUnidadMedida { get; set; }
    }
}