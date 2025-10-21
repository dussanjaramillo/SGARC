using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebLiquidador.App_Code
{
    public class DiasLaborales
    {
        public int DiasDisfrute(DateTime Fecha_Inicio, DateTime Fecha_Fin)
        {
            int DiasNormales;
            int DiasHabiles;
            int Contador;
            DateTime Aux_Fecha;
            int DiaSemana;

            string Aux_FechaInicio;
            string Aux_FechaFin;

            DiasNormales = 0;
            DiaSemana = 0;
            DiasHabiles = 0;
            Contador = 0;
            DiasNormales = Convert.ToInt32((Fecha_Fin - Fecha_Inicio).TotalDays);
            Aux_FechaInicio = Fecha_Inicio.ToString("dd-MM-yyyy");
            Aux_FechaFin = Fecha_Fin.ToString("dd-MM-yyyy");
            if (Aux_FechaInicio != Aux_FechaFin)
            {
                if (DiasNormales == 2)
                {
                    DiasHabiles = 1;
                }
                else
                {
                    while (Contador < DiasNormales)
                    {
                        Aux_Fecha = Fecha_Inicio.AddDays(Contador);
                        DiaSemana = GetDayWeek(Aux_Fecha);
                        if ((DiaSemana != 5) && (DiaSemana != 6))
                        {
                            DiasHabiles = DiasHabiles + 1;
                        }
                        Contador = Contador + 1;
                    }
                }
            }
            else
            {
                DiasHabiles = 0;
            }
            return DiasHabiles;
        }


        private int GetDayWeek(DateTime Fecha)
        {
            int Dia = 0;
            switch (Fecha.Date.DayOfWeek.ToString())
            {
                case "Monday":
                    Dia = 0;
                    break;
                case "Tuesday":
                    Dia = 1;
                    break;
                case "Wednesday":
                    Dia = 2;
                    break;
                case "Thursday":
                    Dia = 3;
                    break;
                case "Friday":
                    Dia = 4;
                    break;
                case "Saturday":
                    Dia = 5;
                    break;
                case "Sunday":
                    Dia = 6;
                    break;
            }
            return Dia;
        }
    }
}