<%@ Page Title="Cargar Archivo - Pse Vs Cartera Regional" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="CargarArchivoMovimientos.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Presupuesto.CargarArchivo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="3"><h2>Cargar Archivo de Movimientos de Presupuesto</h2></td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99FF99">Seleccione el Archivo de Presupuesto Movimiento<br />
                <asp:FileUpload ID="FuCargarArchivo" runat="server" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" Width="481px"  />
            </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99FF99">
                <asp:Button ID="btnCargarArchivo" runat="server" OnClick="btnCargarArchivo_Click" Text="Cargar Archivo" Width="482px" />
                <Ajax:ConfirmButtonExtender ID="btnCargarArchivo_ConfirmButtonExtender" runat="server" BehaviorID="btnCargarArchivo_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnCargarArchivo" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99FF99">Archivo: <asp:Label ID="lblNombreArchivo" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99FF99">Registros:
                <asp:Label ID="lblNumeroRegistros" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
            <td class="auto-style8"></td>
            <td class="auto-style8"></td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99FF99">Fecha:<asp:Label ID="lblFechaPresupuesto" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99FF99">Meta:<asp:Label ID="lblMeta" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99FF99">
                <asp:Button ID="btnEsCorrecto" runat="server" Font-Bold="True" OnClick="btnEsCorrecto_Click" Text="Es Correcto?" Visible="False" Width="482px" />
                <Ajax:ConfirmButtonExtender ID="btnEsCorrecto_ConfirmButtonExtender" runat="server" BehaviorID="btnEsCorrecto_ConfirmButtonExtender" ConfirmText="Procesar el Archivo?" TargetControlID="btnEsCorrecto" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>&nbsp;</td>
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
                <asp:HiddenField ID="hdfNumeroRegistros" runat="server" />
            </td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
