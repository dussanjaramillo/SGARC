<%@ Page Title="Tasa de Interes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TasaMultasMinisterio.aspx.cs" Inherits="WebLiquidador.Paginas.Parametro.TasaMultasMinisterio" %>
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


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td class="auto-style13" colspan="2"><h2>Tasa de Interes de Mora Y Numero de Días Adicionales</h2></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15" style="background-color: #FF9900">&nbsp;</td>
            <td class="auto-style8" style="background-color: #FF9900">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style18">Tasa de Interes de Mora<br />
                <asp:TextBox ID="txtTasaMultasMinisterio" runat="server" Width="140px"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTasaMultasMinisterio" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style19">Número Días Adicionales<br />
                <asp:TextBox ID="txtNumeroDiasAdicionales" runat="server" Width="140px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtNumeroDiasAdicionales_FilteredTextBoxExtender" runat="server" BehaviorID="txtNumeroDiasAdicionales_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtNumeroDiasAdicionales" />
                <br />
                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtNumeroDiasAdicionales" ErrorMessage="El Valor debe ser entre 1 y 10 días" Font-Bold="True" ForeColor="Maroon" MaximumValue="10" MinimumValue="1" Type="Integer" ValidationGroup="btnGuardar">Debe ser entre 1 y 10 días</asp:RangeValidator>
            </td>
            <td class="auto-style20"></td>
        </tr>
        <tr>
            <td class="auto-style10" style="background-color: #FF9900" colspan="2">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style11" colspan="2">
                            <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" />
                        </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style11" colspan="2">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
