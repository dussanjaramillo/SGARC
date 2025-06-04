<%@ Page Title="Ugpp - Desagregado Eliminar" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DesagregadoEliminar.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.DesagregadoEliminar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="2"><h2>Desagregado Mensual - Eliminar - Aviso de Incumplimiento</h2></td>
        </tr>
        <tr>
            <td rowspan="5" class="auto-style9">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Image ID="Image1" runat="server" Height="94px" ImageUrl="~/Imagenes/Logo_Ugpp.png" />
            </td>
            <td class="auto-style8">Fecha Proceso<br />
                <asp:TextBox ID="txtVigenciaMes" runat="server" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtVigenciaMes_TextBoxWatermarkExtender" runat="server" BehaviorID="txtVigenciaMes_TextBoxWatermarkExtender" TargetControlID="txtVigenciaMes" WatermarkText="AAAA-MM" />
                <Ajax:CalendarExtender ID="txtVigenciaMes_CalendarExtender" runat="server" BehaviorID="txtFechaCalculo_CalendarExtender" Format="yyyy-MM" TargetControlID="txtVigenciaMes" />
            </td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtVigenciaMes" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnDesagregadoEliminar"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #E48F43">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:Button ID="btnDesagregadoEliminar" runat="server" OnClick="btnDesagregadoEliminar_Click" Text="Eliminar" Width="170px" ValidationGroup="btnDesagregadoEliminar" />
                <Ajax:ConfirmButtonExtender ID="btnDesagregadoEliminar_ConfirmButtonExtender" runat="server" BehaviorID="btnDesagregadoMensualDetalles_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnDesagregadoEliminar" />
            </td>
        </tr>
        <tr>
            <td class="auto-style8">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style8">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style8">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style9">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td class="auto-style8">&nbsp;</td>
        </tr>
    </table>
</asp:Content>
