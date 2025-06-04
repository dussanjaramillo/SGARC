using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebLiquidador.App_Code
{
    public class PagoRecibidoCpp
    {
        public Int32 Item { get; set; }
        public Int32 IdEntidad { get; set; }
        public Int32 IdPensionado { get; set; }
        public Int32 IdCuponPago { get; set; }
        public Decimal Capital { get; set; }
        public Decimal InteresMora { get; set; }
        public Decimal CapitalSalud { get; set; }
        public Decimal InteresMoraSalud { get; set; }
        public DateTime FechaPago { get; set; }
        public String TicketId { get; set; }
    }
}