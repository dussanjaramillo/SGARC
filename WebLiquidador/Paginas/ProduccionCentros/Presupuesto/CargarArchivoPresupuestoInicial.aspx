<%@ Page Title="Cargar Archivo - Pse Vs Cartera Regional" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="CargarArchivoPresupuestoInicial.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Presupuesto.CargarArchivoPresupuestoInicial" %>
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
            <td colspan="3"><h2>Cargar Archivo de Presupuesto Inicial</h2></td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF">Seleccione el Archivo de Presupuesto Inicial<br />
                <asp:FileUpload ID="FuCargarArchivo" runat="server" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" Width="481px"  />
            </td>
            <td>Vigencia<br />
                <asp:TextBox ID="txtVigencia" runat="server" MaxLength="4" ValidationGroup="btnEsCorrecto"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtVigencia_FilteredTextBoxExtender" runat="server" BehaviorID="txtVigencia_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtVigencia" />
                &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtVigencia" ErrorMessage="La Vigencia es Requerida" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnEsCorrecto"></asp:RequiredFieldValidator>
                &nbsp;&nbsp; &nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF">
                <asp:Button ID="btnCargarArchivo" runat="server" OnClick="btnCargarArchivo_Click" Text="Cargar Archivo" Width="482px" />
                <Ajax:ConfirmButtonExtender ID="btnCargarArchivo_ConfirmButtonExtender" runat="server" BehaviorID="btnCargarArchivo_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnCargarArchivo" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF">Archivo: <asp:Label ID="lblNombreArchivo" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF">Registros:
                <asp:Label ID="lblNumeroRegistros" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
            <td class="auto-style8"></td>
            <td class="auto-style8"></td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF">Fecha:<asp:Label ID="lblFechaPresupuesto" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF">Meta:<asp:Label ID="lblMeta" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #99CCFF">
                <asp:Button ID="btnEsCorrecto" runat="server" Font-Bold="True" OnClick="btnEsCorrecto_Click" Text="Es Correcto?" Visible="False" Width="482px" ValidationGroup="btnEsCorrecto" />
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
            <td class="auto-style7">&nbsp;</td>
            <td class="auto-style8">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hdfNumeroRegistros" runat="server" />
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
