<%@ Page Title="Pagos Por Fuera de Pila" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PagosPorFueraPila.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.PagosPorFueraPila" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            width: 100%;
        }
        .auto-style9 {
            width: 60%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td><h2>Pagos Por Fuera de Pila</h2></td>
        </tr>
        </table>
    <table class="auto-style9">
        <tr>
            <td>
                Fecha Inicial<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFechaInicial" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
            </td>
            <td>Fecha Final<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFechaFinal" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
            </td>
            <td>Encabezado?
                <asp:DropDownList ID="ddlEncabezado" runat="server">
                    <asp:ListItem Selected="True">No</asp:ListItem>
                    <asp:ListItem>Si</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtFechaInicial" runat="server" MaxLength="10" Width="170px" ValidationGroup="btnBuscar"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtFechaInicial_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaInicial_TextBoxWatermarkExtender" TargetControlID="txtFechaInicial" WatermarkText="aaaa-mm-dd" />
                <Ajax:CalendarExtender ID="txtFechaInicial_CalendarExtender" runat="server" BehaviorID="txtFechaInicial_CalendarExtender" Format="yyyy-MM-dd" TargetControlID="txtFechaInicial" />
            </td>
            <td>
                <asp:TextBox ID="txtFechaFinal" runat="server" MaxLength="10" Width="170px" ValidationGroup="btnBuscar"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtFechaFinal_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaFinal_TextBoxWatermarkExtender" TargetControlID="txtFechaFinal" WatermarkText="aaaa-mm-dd" />
                <Ajax:CalendarExtender ID="txtFechaFinal_CalendarExtender" runat="server" BehaviorID="txtFechaFinal_CalendarExtender" Format="yyyy-MM-dd" TargetControlID="txtFechaFinal" />
            </td>
            <td>
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" Width="170px" ValidationGroup="btnBuscar" />
            </td>
            <td>
            <asp:Button ID="btn_Limpiar" runat="server" Text="Limpiar" Width="170px" OnClick="btn_Limpiar_Click" ToolTip="Limpia el Formulario" />
            </td>
            <td>
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnExportar_ConfirmButtonExtender" runat="server" ConfirmText="Está Seguro?" TargetControlID="btnExportar" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
