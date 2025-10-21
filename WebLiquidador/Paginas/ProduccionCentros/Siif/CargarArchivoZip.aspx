<%@ Page Title="Cargar Archivo Zip" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="CargarArchivoZip.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Siif.CargarArchivoZip" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="2"><h2>Cargar Archivo Zip - Siif Nación</h2></td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF">Seleccione el Archivo Zip<br />
                <asp:FileUpload ID="FuCargarArchivo" runat="server" accept="application/zip" Width="481px"  />
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
            <td class="auto-style8" style="background-color: #99CCFF" colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF" colspan="2">
                <asp:GridView ID="grvFacturasSiif" runat="server">
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF" colspan="2">&nbsp;</td>
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
