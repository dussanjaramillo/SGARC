<%@ Page Title="Ugpp - Consolidado Mensual" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConsolidadoMensual.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.ConsolidadoMensual" %>

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
        .auto-style6 {
            width: 703px;
        }

        .auto-style7 {
            width: 10px;
        }

        .auto-style9 {
            width: 228px;
        }
        .auto-style10 {
            width: 163px;
        }
        .auto-style11 {
            margin-bottom: 0px;
        }
        .auto-style12 {
            width: 496px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td>
                <h2 class="auto-style11">Consolidado Mensual - Aviso de Incumplimiento y Cartera Real</h2>
            </td>
        </tr>
        </table>
    <table class="auto-style12">
        <tr>
            <td rowspan="5" class="auto-style10">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Image ID="Image1" runat="server" Height="94px" ImageUrl="~/Imagenes/Logo_Ugpp.png" />
            </td>
            <td>Periodo<br />
            </td>
            <td class="auto-style9">Mes de Entrega</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtPeriodo" runat="server" BackColor="#FFFF99" Enabled="False" Font-Bold="True" Width="170px"></asp:TextBox>
            </td>
            <td class="auto-style9">
                <asp:DropDownList ID="ddlMesEntrega" runat="server" Width="170px" OnDataBound="ddlMesEntrega_DataBound">
                    <asp:ListItem>01 - Enero</asp:ListItem>
                    <asp:ListItem>02 - Febrero</asp:ListItem>
                    <asp:ListItem>03 - Marzo</asp:ListItem>
                    <asp:ListItem>04 - Abril</asp:ListItem>
                    <asp:ListItem>05 - Mayo</asp:ListItem>
                    <asp:ListItem>06 - Junio</asp:ListItem>
                    <asp:ListItem>07 - Julio</asp:ListItem>
                    <asp:ListItem>08 - Agosto</asp:ListItem>
                    <asp:ListItem>09 - Septiembre</asp:ListItem>
                    <asp:ListItem>10 - Octubre</asp:ListItem>
                    <asp:ListItem>11 - Noviembre</asp:ListItem>
                    <asp:ListItem>12 - Diciembre</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="auto-style9">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlMesEntrega" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" SetFocusOnError="True" ValidationGroup="btnConsolidadoMensual"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style7" colspan="2" style="background-color: #E48F43">&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnConsolidadoMensual" runat="server" OnClick="btnConsolidadoMensual_Click" Text="Consolidado" Width="170px" Style="height: 26px" ValidationGroup="btnConsolidadoMensual" />
                <Ajax:ConfirmButtonExtender ID="btnConsolidadoMensual_ConfirmButtonExtender" runat="server" BehaviorID="btnDesagregadoMensualDetalles_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnConsolidadoMensual" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnFichaControl" runat="server" OnClick="btnFichaControl_Click" Text="Ficha de Control" ValidationGroup="btnConsolidadoMensual" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnFichaControl_ConfirmButtonExtender" runat="server" BehaviorID="btnFichaControl_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnFichaControl" />
            </td>
        </tr>
        <tr>
            <td class="auto-style10">&nbsp;</td>
            <td colspan="2">
                Debe entregarse a mas tardar el ultimo día hábil de cada mes del año (12 reportes), asignando en la estructura del nombre del archivo el mes de entrega.</td>
        </tr>
        <tr>
            <td class="auto-style10">&nbsp;</td>
            <td colspan="2">
                <h3>
                    <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" NavigateUrl="~/Paginas/Normas/Presentacion Resolucion 2082_16_Estandares I_II_III_IV_marzo_2017.pdf">Presentacion Resolucion 2082</asp:HyperLink>
                </h3>
            </td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style10">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
        </tr>
    </table>
</asp:Content>
