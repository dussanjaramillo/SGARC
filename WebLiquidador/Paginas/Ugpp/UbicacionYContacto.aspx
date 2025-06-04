<%@ Page Title="Ugpp - Ubicación y Contacto" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UbicacionYContacto.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.UbicacionYContacto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

        <script type="text/javascript">
        (function () {
            // Union of Chrome, Firefox, IE, Opera, and Safari console methods
            var methods = ["assert", "cd", "clear", "count", "countReset",
              "debug", "dir", "dirxml", "error", "exception", "group", "groupCollapsed",
              "groupEnd", "info", "log", "markTimeline", "profile", "profileEnd",
              "select", "table", "time", "timeEnd", "timeStamp", "timeline",
              "timelineEnd", "trace", "warn"];
            var length = methods.length;
            var console = (window.console = window.console || {});
            var method;
            var noop = function () { };
            while (length--) {
                method = methods[length];
                // define undefined methods as noops to prevent errors
                if (!console[method])
                    console[method] = noop;
            }
        })();
    </script>



        <style type="text/css">
            .auto-style8 {
                width: 624%;
            }
            .auto-style9 {
                text-align: center;
            }
            .auto-style10 {
                text-align: center;
                font-size: large;
            }
        </style>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td class="auto-style7" colspan="8"><h2 class="auto-style8">Ubicación y Contacto</h2></td>
        </tr>
        <tr>
            <td rowspan="7" class="auto-style10">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Image ID="Image1" runat="server" Height="91px" ImageUrl="~/Imagenes/Logo_Ugpp.png" Width="176px" />
            </td>
            <td class="auto-style11" colspan="2">Vigencia</td>
            <td class="auto-style21">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style14" colspan="3">
                <asp:TextBox ID="txtVigencia" runat="server" Width="170px" MaxLength="4"></asp:TextBox>
                <Ajax:CalendarExtender ID="txtVigencia_CalendarExtender" runat="server" BehaviorID="txtVigencia_CalendarExtender" Format="yyyy" TargetControlID="txtVigencia" />
            </td>
            <td class="auto-style15"></td>
            <td class="auto-style15"></td>
            <td class="auto-style15"></td>
            <td class="auto-style15"></td>
        </tr>
        <tr>
            <td class="auto-style10" style="background-color: #E48F43" colspan="7"><strong>Este reporte debe Generarse en el Sirec, dado que la Cartera se encuentra en la Base de Datos del SIREC</strong></td>
        </tr>
        <tr>
            <td class="auto-style16" colspan="6"><strong>Estado del Proceso</strong></td>
            <td class="auto-style17"></td>
        </tr>
        <tr>
            <td class="auto-style14" colspan="3">
                <asp:TextBox ID="txtMensaje" runat="server" ReadOnly="True" Width="100%" Font-Bold="True" ForeColor="#FF3300" style="text-align: center" CssClass="alineacionCentral"></asp:TextBox>
            </td>
            <td class="auto-style15"></td>
            <td class="auto-style15"></td>
            <td class="auto-style15"></td>
            <td class="auto-style15"></td>
        </tr>
        <tr>
            <td class="auto-style13">
                <asp:Button ID="btnGenerarReporte" runat="server" OnClick="btnGenerarReporte_Click" Text="Generar" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnGenerarReporte_ConfirmButtonExtender" runat="server" BehaviorID="btnDesagregadoMensualDetalles_ConfirmButtonExtender" ConfirmText="Usted Está Seguro?" TargetControlID="btnGenerarReporte" />
            </td>
            <td class="auto-style18">
                <asp:Button ID="btnRefrescar" runat="server" Text="Refrescar" Width="170px" OnClick="btnRefrescar_Click" />
            </td>
            <td class="auto-style22">
                <asp:Button ID="btnDetalles" runat="server" Text="Imprimir" Width="170px" OnClick="btnDetalles_Click" />
                <Ajax:ConfirmButtonExtender ID="btnDetalles_ConfirmButtonExtender" runat="server" BehaviorID="btnDetalles_ConfirmButtonExtender" ConfirmText="Usted Está Seguro?" TargetControlID="btnDetalles" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnFichaControl" runat="server" OnClick="btnFichaControl_Click" Text="Ficha de Control" ValidationGroup="btnConsolidadoMensual" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnFichaControl_ConfirmButtonExtender" runat="server" BehaviorID="btnFichaControl_ConfirmButtonExtender" ConfirmText="Usted Está Seguro?" TargetControlID="btnFichaControl" />
            </td>
            <td class="auto-style9"></td>
            <td class="auto-style9"></td>
            <td class="auto-style9"></td>
        </tr>
        <tr>
            <td class="auto-style11" colspan="3">Debe enviarse el último día hábil del mes de noviembre de cada año</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style10">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td class="auto-style8">
                <asp:HiddenField ID="hdfEstadoVigenciaAportanteDatosBasicos" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
