<%@ Page Title="Cruce Soi Vs Bancos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CruceSoiVsBancos.aspx.cs" Inherits="WebLiquidador.Paginas.DireccionGeneral.CruceSoiVsBancos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="2"><h2>Cruce Soi Vs Bancos</h2></td>
        </tr>
        <tr>
            <td class="auto-style8">Fecha Inicial</td>
            <td>Fecha Final</td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:TextBox ID="txtFechaInicial" runat="server" MaxLength="8" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtFechaInicial_FilteredTextBoxExtender" runat="server" BehaviorID="txtFechaInicial_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtFechaInicial" />
                <Ajax:TextBoxWatermarkExtender ID="txtFechaInicial_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaInicial_TextBoxWatermarkExtender" TargetControlID="txtFechaInicial" WatermarkText="AAAAMMDD" />
                <Ajax:CalendarExtender ID="txtFechaInicial_CalendarExtender" runat="server" BehaviorID="txtFechaInicial_CalendarExtender" Format="yyyyMMdd" TargetControlID="txtFechaInicial" />
                </td>
            <td>
                <asp:TextBox ID="txtFechaFinal" runat="server" MaxLength="8" Width="170px" AutoPostBack="True" OnTextChanged="txtFechaFinal_TextChanged"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtFechaFinal_FilteredTextBoxExtender" runat="server" BehaviorID="txtFechaFinal_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtFechaFinal" />
                <Ajax:TextBoxWatermarkExtender ID="txtFechaFinal_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaFinal_TextBoxWatermarkExtender" TargetControlID="txtFechaFinal" WatermarkText="AAAAMMDD" />
                <Ajax:CalendarExtender ID="txtFechaFinal_CalendarExtender" runat="server" BehaviorID="txtFechaFinal_CalendarExtender" Format="yyyyMMdd" TargetControlID="txtFechaFinal" />
                </td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnExportar_ConfirmButtonExtender" runat="server" BehaviorID="btnExportar_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnExportar" />
            </td>
            <td class="auto-style11">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
