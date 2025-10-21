<%@ Page Title="Reciproco" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reciprocos.aspx.cs" Inherits="WebLiquidador.Paginas.DireccionGeneral.Reciprocos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="4"><h2>Reciproco</h2></td>
        </tr>
        <tr>
            <td class="auto-style8">Fecha Inicial</td>
            <td class="auto-style8">Fecha Final</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style10">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:TextBox ID="txtFechaInicial" runat="server" MaxLength="10" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtFechaInicial_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaInicial_TextBoxWatermarkExtender" TargetControlID="txtFechaInicial" WatermarkText="AAAA-MM-DD" />
                <Ajax:CalendarExtender ID="txtFechaInicial_CalendarExtender" runat="server" BehaviorID="txtFechaInicial_CalendarExtender" Format="yyyy-MM-dd" TargetControlID="txtFechaInicial" />
            </td>
            <td class="auto-style8">
                <asp:TextBox ID="txtFechaFinal" runat="server" MaxLength="10" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtFechaFinal_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaFinal_TextBoxWatermarkExtender" TargetControlID="txtFechaFinal" WatermarkText="AAAA-MM-DD" />
                <Ajax:CalendarExtender ID="txtFechaFinal_CalendarExtender" runat="server" BehaviorID="txtFechaFinal_CalendarExtender" Format="yyyy-MM-dd" TargetControlID="txtFechaFinal" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Programar" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnBuscar_ConfirmButtonExtender" runat="server" BehaviorID="btnBuscarPila_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnBuscar" />
            </td>
            <td class="auto-style10">
            <asp:Button ID="btn_Limpiar" runat="server" Text="Limpiar" Width="170px" OnClick="btn_Limpiar_Click" ToolTip="Limpia el Formulario" />
            </td>
        </tr>
        <tr>
            <td class="auto-style17" colspan="3">
                <asp:TextBox ID="txtMensaje" runat="server" BackColor="#FFFF99" CssClass="alineacionCentral" Width="519px"></asp:TextBox>
            </td>
            <td class="auto-style19">
            <asp:Button ID="btnExportar" runat="server" Text="Exportar" Width="170px" OnClick="btnExportar_Click" ToolTip="Exporta la Información " Visible="False" />
            </td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style7">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td class="auto-style8">
                <asp:HiddenField ID="hdfErrorBD" runat="server" />
            </td>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style9">
                <asp:HiddenField ID="hdfEstadoProceso" runat="server" />
            </td>
            <td class="auto-style10">
                <asp:HiddenField ID="hdFechaInicial" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hdFechaFinal" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
