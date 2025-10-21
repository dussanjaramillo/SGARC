<%@ Page Title="Eliminar de Cupón de Pago" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="EliminarCuponPago.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.EliminarCuponPago" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">
        .auto-style8 {
            height: 21px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="3">
                <h2>Eliminar de Cupón de Pago</h2>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #FFCCCC">
                <h1>Origen</h1>
            </td>
        </tr>
        <tr>
            <td>Cupón de Pago</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtCuponPago" runat="server" MaxLength="8" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtCuponPago_FilteredTextBoxExtender" runat="server" BehaviorID="txtCuponPago_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtCuponPago" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCuponPago" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnBuscar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style8"></td>
            <td class="auto-style8"></td>
        </tr>
        <tr>
            <td>Regional</td>
            <td class="auto-style9">Código Centro</td>
            <td class="auto-style9">&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtRegional" runat="server" BackColor="#FFCCCC" ReadOnly="True" Width="170px" Enabled="False" Font-Bold="True" ForeColor="Black"></asp:TextBox>
            </td>
            <td class="auto-style9">
                <asp:TextBox ID="txtCodigoCentroFormacion" runat="server" BackColor="#FFCCCC" ReadOnly="True" Width="170px" Enabled="False" Font-Bold="True" ForeColor="Black"></asp:TextBox>
            </td>
            <td class="auto-style9">
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="3">
                Nombre Centro de Formación</td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:TextBox ID="txtNombreCentroFormacion" runat="server" BackColor="#FFCCCC" Enabled="False" Width="540px" Font-Bold="True" ForeColor="Black"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Numero Cupón Pago</td>
            <td class="auto-style9">
                Valor Cupón</td>
            <td class="auto-style9">
                Fecha Pago</td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:TextBox ID="txtNroInternodeTransaccion" runat="server" BackColor="#FFCCCC" Enabled="False" Width="170px" Font-Bold="True" ForeColor="Black"></asp:TextBox>
                </td>
            <td class="auto-style8">
                <asp:TextBox ID="txtValorPago" runat="server" BackColor="#FFCCCC" Enabled="False" Width="170px" Font-Bold="True" ForeColor="Black"></asp:TextBox>
                </td>
            <td class="auto-style8">
                <asp:TextBox ID="txtFechaPago" runat="server" BackColor="#FFCCCC" Enabled="False" Width="170px" Font-Bold="True" ForeColor="Black"></asp:TextBox>
                </td>
        </tr>
        <tr>
            <td class="auto-style8">
                </td>
            <td class="auto-style8">
                <asp:Button ID="btnEliminarCuponPago" runat="server" OnClick="btnEliminarCuponPago_Click" Text="Eliminar Cupón Pago" Visible="False" ValidationGroup="btnEliminarCuponPago" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnEliminarCuponPago_ConfirmButtonExtender" runat="server" BehaviorID="btnTrasladoCuponPago_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnEliminarCuponPago" />
                </td>
            <td class="auto-style8">
                </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:HiddenField ID="hfIdCuponPago" runat="server" />
            </td>
            <td>
                &nbsp;</td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
