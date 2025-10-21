<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CarteraRealCalcularMorosos.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.CarteraRealCalcularMorosos" %>

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
                height: 19px;
            }
        </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="3">
                <h2>&nbsp;Calcular Cartera Real Sirec X Periodo</h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style7" rowspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Image ID="Image1" runat="server" Height="96px" ImageUrl="~/Imagenes/Logo_Ugpp.png" Style="text-align: center" />
            </td>
            <td class="auto-style11" colspan="2">Periodo a Cálcular</td>
        </tr>
        <tr>
            <td class="auto-style12">
                <asp:DropDownList ID="ddlPeriodo_CarteraRealUgpp" runat="server" DataSourceID="SdsPeriodo_CarteraRealUgpp" DataTextField="Periodo" DataValueField="Periodo" OnDataBound="ddlFechaCalculo_DataBound" Width="170px" OnSelectedIndexChanged="ddlFechaCalculo_SelectedIndexChanged" AutoPostBack="True">
                </asp:DropDownList>
            </td>
            <td class="auto-style14">
                <asp:Button ID="btnCalcular" runat="server" Enabled="False" OnClick="btnCalcular_Click" Text="Calcular" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnCalcular_ConfirmButtonExtender" runat="server" BehaviorID="btnCalcular_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnCalcular" />
            </td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #E48F43"></td>
            <td class="auto-style8" style="background-color: #E48F43"></td>
        </tr>
        <tr>
            <td class="auto-style11" colspan="2">
                <h3>
                    <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" NavigateUrl="~/Paginas/Normas/Presentacion Resolucion 2082_16_Estandares I_II_III_IV_marzo_2017.pdf">Presentacion Resolucion 2082</asp:HyperLink>
                </h3>
            </td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style9">
                <asp:SqlDataSource ID="SdsPeriodo_CarteraRealUgpp" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[Ugpp].[Usp_Buscar_Periodo_CarteraRealUgpp]" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:LiquidadorConnectionString.ProviderName %>"></asp:SqlDataSource>
            </td>
            <td class="auto-style13"></td>
        </tr>
        <tr>
            <td class="auto-style7">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td class="auto-style11">
                <asp:HiddenField ID="hfValidacionFecha" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
