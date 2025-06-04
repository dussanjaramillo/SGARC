<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="CargarCompromiso.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Presupuesto.CargarCompromiso" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="2"><h2>Cargar Compromiso</h2></td>
        </tr>
        <tr>
            <td style="background-color: #99CCFF">Seleccione el Archivo de Compromiso</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="background-color: #99CCFF">
                <asp:FileUpload ID="FuCargarArchivo" runat="server" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" Width="481px"  />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="background-color: #99CCFF">
                <asp:Button ID="btnCargarArchivo" runat="server" OnClick="btnCargarArchivo_Click" Text="Cargar Archivo" Width="482px" />
                <Ajax:ConfirmButtonExtender ID="btnCargarArchivo_ConfirmButtonExtender" runat="server" BehaviorID="btnCargarArchivo_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnCargarArchivo" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="background-color: #99CCFF">Archivo: <asp:Label ID="lblNombreArchivo" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="background-color: #99CCFF">Registros:
                <asp:Label ID="lblRegistros" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="background-color: #99CCFF">Fecha Minima: <asp:Label ID="lblFechaMinima" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="background-color: #99CCFF">Fecha Máxima: <asp:Label ID="lblFechaMaxima" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="background-color: #99CCFF">
                <asp:Button ID="btnEsCorrecto" runat="server" Font-Bold="True" OnClick="btnEsCorrecto_Click" Text="Es Correcto?" Visible="False" Width="482px" />
                <Ajax:ConfirmButtonExtender ID="btnEsCorrecto_ConfirmButtonExtender" runat="server" BehaviorID="btnEsCorrecto_ConfirmButtonExtender" ConfirmText="Procesar el Archivo?" TargetControlID="btnEsCorrecto" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="background-color: #99CCFF">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="482px" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hdfNumeroRegistros" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
