<%@ Page Title="Ugpp - Desagregado Mensual" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DesagregadoMensual.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.DesagregadoMensual" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="2"><h2>Desagregado Mensual - Aviso de Incumplimiento</h2></td>
        </tr>
        <tr>
            <td rowspan="5" class="auto-style16">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Image ID="Image1" runat="server" Height="94px" ImageUrl="~/Imagenes/Logo_Ugpp.png" />
            </td>
            <td class="auto-style8">Periodo<br />
            </td>
        </tr>
        <tr>
            <td class="auto-style17">
                <asp:TextBox ID="txtPeriodo" runat="server" BackColor="#FFFF99" Enabled="False" Font-Bold="True" Width="170px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style7" style="background-color: #E48F43">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style7">
                <asp:Button ID="btnDesagregadoMensualDetalles" runat="server" OnClick="btnDesagregadoMensualDetalles_Click" Text="Detalles" Width="170px" ValidationGroup="btnDesagregadoMensualDetalles" />
                <Ajax:ConfirmButtonExtender ID="btnDesagregadoMensualDetalles_ConfirmButtonExtender" runat="server" BehaviorID="btnDesagregadoMensualDetalles_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnDesagregadoMensualDetalles" />
            </td>
        </tr>
        <tr>
            <td class="auto-style7">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style16">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td class="auto-style7">&nbsp;</td>
        </tr>
    </table>
</asp:Content>
