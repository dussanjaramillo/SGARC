<%@ Page Title="Cargar Pagos" Language="C#" MasterPageFile="~/SiteCpp.Master" AutoEventWireup="true" CodeBehind="CargarArchivo.aspx.cs" Inherits="WebLiquidador.Paginas.CostasProcesales.Pagos.CargarArchivo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td><h2>Cargar Pagos Costas Procesales</h2></td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style8" style="background-color: #9db796"><span class="auto-style10"><strong>Seleccione el Archivo de los Pagos</strong></span><br />
                <asp:FileUpload ID="FuCargarArchivo" runat="server" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" Width="481px"  />
            </td>
            <td style="background-color: #9db796">
                <br />
                </td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #9db796" colspan="2">
                <asp:Button ID="BtnCargarArchivo" runat="server" OnClick="BtnCargarArchivo_Click" Text="Cargar Archivo" Width="652px" ValidationGroup="BtnCargarArchivo" />
                <Ajax:ConfirmButtonExtender ID="btnCargarArchivo_ConfirmButtonExtender" runat="server" BehaviorID="btnCargarArchivo_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnCargarArchivo" />
            </td>
        </tr>
        <tr>
            <td class="auto-style11" style="background-color: #9db796" colspan="2">Archivo: <asp:Label ID="lblNombreArchivo" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style12" style="background-color: #9db796" colspan="2">Registros: <asp:Label ID="lblRegistros" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style13" style="background-color: #9db796" colspan="2">ValorTotal: <asp:Label ID="lblValorTotaldelPago" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style14" style="background-color: #9db796" colspan="2">Fecha Minima: <asp:Label ID="lblFechaMinima" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style15" style="background-color: #9db796" colspan="2">Fecha Máxima: <asp:Label ID="lblFechaMaxima" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #9db796">
                <asp:Button ID="BtnEsCorrecto" runat="server" Font-Bold="True" OnClick="BtnEsCorrecto_Click" Text="Es Correcto?" Visible="False" Width="482px" />
                <Ajax:ConfirmButtonExtender ID="btnEsCorrecto_ConfirmButtonExtender" runat="server" BehaviorID="btnEsCorrecto_ConfirmButtonExtender" ConfirmText="Procesar el Archivo?" TargetControlID="btnEsCorrecto" />
            </td>
            <td class="auto-style8">
                <asp:Button ID="BtnLimpiar" runat="server" OnClick="BtnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td>&nbsp;</td>
            <td class="auto-style7">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td class="auto-style8">
                &nbsp;</td>
            <td>
                <asp:HiddenField ID="hdfNumeroRegistros" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfEstado" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
