<%@ Page Title="Ugpp - Desagregado Mensual" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Desagregado.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.Desagregado" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

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
            width: 757px;
        }

        .auto-style7 {
            width: 528px;
        }
        .auto-style8 {
            width: 390px;
        }
    .auto-style9 {
        width: 939px;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style9">
        <tr>
            <td>
                <h2>Desagregado Mensual Storm-User - Aviso de Incumplimiento y Cartera Real</h2>
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td rowspan="5" class="auto-style7">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Image ID="Image1" runat="server" Height="94px" ImageUrl="~/Imagenes/Logo_Ugpp.png" />
            </td>
            <td class="auto-style11">Periodo<br />
            </td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:TextBox ID="txtPeriodo" runat="server" BackColor="#FFFF99" Enabled="False" Font-Bold="True" Width="170px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style10">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10" style="background-color: #E48F43">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:Button ID="btnDesagregado" runat="server" OnClick="btnDesagregado_Click" Text="Detalles" Width="170px" ValidationGroup="btnDesagregado" />
                <ajaxToolkit:ConfirmButtonExtender ID="btnDesagregado_ConfirmButtonExtender" runat="server" BehaviorID="btnDesagregado_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnDesagregado" />
            </td>
        </tr>
        <tr>
            <td class="auto-style16">&nbsp;</td>
            <td class="auto-style16">
                Debe entregarse a más tardar el último día hábil de cada mes</td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td class="auto-style16">&nbsp;
            </td>
            <td class="auto-style16">
                <h3>
                    <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" NavigateUrl="~/Paginas/Normas/Resolucion_1702_2021.pdf">Resolución # 1702 de 2021</asp:HyperLink>
                    <asp:HyperLink ID="HyperLink2" runat="server" Target="_blank" NavigateUrl="~/Paginas/Normas/Socialización_Res_1702_2021_VF.pdf">Socialización_Res_1702_2021</asp:HyperLink>
                </h3>
            </td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style7">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
        </tr>
    </table>
</asp:Content>
