<%@ Page Title="Detalles Soi" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DetallesSoi.aspx.cs" Inherits="WebLiquidador.Paginas.DireccionGeneral.DetallesSoi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style6 {
            width: 259px;
        }
        .auto-style7 {
            width: 258px;
        }
        .auto-style8 {
        }
        .auto-style10 {
            width: 105px;
        }
        .auto-style12 {
            width: 119px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="4"><h2>Detalles Soi</h2></td>
        </tr>
        <tr>
            <td class="auto-style10">Fecha Inicial</td>
            <td class="auto-style12">Fecha Final</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:TextBox ID="txtFechaInicial" runat="server" MaxLength="8" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtFechaInicial_FilteredTextBoxExtender" runat="server" BehaviorID="txtFechaInicial_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtFechaInicial" />
                <Ajax:TextBoxWatermarkExtender ID="txtFechaInicial_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaInicial_TextBoxWatermarkExtender" TargetControlID="txtFechaInicial" WatermarkText="AAAAMMDD" />
                <Ajax:CalendarExtender ID="txtFechaInicial_CalendarExtender" runat="server" BehaviorID="txtFechaInicial_CalendarExtender" Format="yyyyMMdd" TargetControlID="txtFechaInicial" />
                </td>
            <td class="auto-style12">
                <asp:TextBox ID="txtFechaFinal" runat="server" MaxLength="8" Width="170px" AutoPostBack="True" OnTextChanged="txtFechaFinal_TextChanged"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtFechaFinal_FilteredTextBoxExtender" runat="server" BehaviorID="txtFechaFinal_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtFechaFinal" />
                <Ajax:TextBoxWatermarkExtender ID="txtFechaFinal_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaFinal_TextBoxWatermarkExtender" TargetControlID="txtFechaFinal" WatermarkText="AAAAMMDD" />
                <Ajax:CalendarExtender ID="txtFechaFinal_CalendarExtender" runat="server" BehaviorID="txtFechaFinal_CalendarExtender" Format="yyyyMMdd" TargetControlID="txtFechaFinal" />
                </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Red" SetFocusOnError="True" ValidationGroup="btnCalcular" ControlToValidate="txtFechaInicial"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style12">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Red" SetFocusOnError="True" ValidationGroup="btnCalcular" ControlToValidate="txtFechaFinal"></asp:RequiredFieldValidator>
            </td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:Button ID="btnCalcular" runat="server" Enabled="False" OnClick="btnCalcular_Click" Text="Calcular" Width="170px" ValidationGroup="btnCalcular" />
            </td>
            <td class="auto-style12">
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" Enabled="False" />
            </td>
            <td>
                <asp:Button ID="btnExportarError" runat="server" OnClick="btnExportarError_Click" Text="Error" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnExportarError_ConfirmButtonExtender" runat="server" BehaviorID="btnExportar_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnExportarError" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style8" colspan="2"><h2>Estado del Proceso</h2></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" colspan="4">
                <asp:TextBox ID="txtMensaje" runat="server" ReadOnly="True" Width="703px" Font-Bold="True" ForeColor="#FF3300" style="text-align: center" CssClass="alineacionCentral"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:HiddenField ID="hdfEstado" runat="server" />
            </td>
            <td class="auto-style12">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
