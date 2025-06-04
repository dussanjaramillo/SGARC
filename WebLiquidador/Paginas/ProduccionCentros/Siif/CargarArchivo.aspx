<%@ Page Title="Cargar Archivo de Pagos" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="CargarArchivo.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Siif.CargarArchivo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            height: 21px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="2"><h2>Cargar Factura electrónica - Siif Nación</h2></td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF">Seleccione el Archivo de Pagos<br />
                <asp:FileUpload ID="FuCargarArchivo" runat="server" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" Width="481px"  />
            </td>
            <td style="background-color: #99CCFF">
                <br />
                </td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF" colspan="2">
                <asp:Button ID="btnCargarArchivo" runat="server" OnClick="btnCargarArchivo_Click" Text="Cargar Archivo" Width="652px" ValidationGroup="btnCargarArchivo" />
                <Ajax:ConfirmButtonExtender ID="btnCargarArchivo_ConfirmButtonExtender" runat="server" BehaviorID="btnCargarArchivo_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnCargarArchivo" />
            </td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF" colspan="2">Archivo: <asp:Label ID="lblNombreArchivo" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF" colspan="2">Registros: <asp:Label ID="lblRegistros" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF" colspan="2">ValorTotal: <asp:Label ID="lblValorTotaldelPago" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF" colspan="2">Fecha Minima: <asp:Label ID="lblFechaMinima" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF" colspan="2">Fecha Máxima: <asp:Label ID="lblFechaMaxima" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #FFFFCC">
                <asp:Button ID="btnEsCorrecto" runat="server" Font-Bold="True" OnClick="btnEsCorrecto_Click" Text="Es Correcto?" Visible="False" Width="482px" />
                <Ajax:ConfirmButtonExtender ID="btnEsCorrecto_ConfirmButtonExtender" runat="server" BehaviorID="btnEsCorrecto_ConfirmButtonExtender" ConfirmText="Procesar el Archivo?" TargetControlID="btnEsCorrecto" />
            </td>
            <td class="auto-style8">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
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
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
