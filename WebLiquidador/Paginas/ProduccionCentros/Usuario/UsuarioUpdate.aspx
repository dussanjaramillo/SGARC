<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="UsuarioUpdate.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Usuario.UsuarioUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            width: 70%;
        }

        .auto-style9 {
            height: 21px;
        }

        .auto-style10 {
            width: 24%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td>
                <h2>Actualizar Datos del Usuario:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label></h2>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>Ip del Teléfono</td>
        </tr>
        <tr>
            <td>

                <asp:TextBox ID="txtIpTelefono" runat="server" AutoPostBack="True" Font-Bold="False" MaxLength="5" OnTextChanged="txtIpTelefono_TextChanged" Width="170px"></asp:TextBox>
                
                    <Ajax:FilteredTextBoxExtender ID="txtIpTelefono_FilteredTextBoxExtender" runat="server" BehaviorID="txtIpTelefono_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtIpTelefono" />
                    <Ajax:BalloonPopupExtender ID="txtIpTelefono_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel1" BalloonSize="Medium" BehaviorID="txtIpTelefono_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtIpTelefono">
                    </Ajax:BalloonPopupExtender>

            </td>
        </tr>
        <tr>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtIpTelefono" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" Font-Size="Larger"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
    <table class="auto-style10">
        <tr>
            <td>
                <asp:Button ID="btnGuardar" runat="server" Enabled="False" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnGuardar_ConfirmButtonExtender" runat="server" BehaviorID="btnGuardar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnGuardar" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>
                <asp:Button ID="btnContinuar" runat="server" BackColor="#FFFF99" Enabled="False" Font-Bold="True" OnClick="btnContinuar_Click1" Text="Continuar" Width="170px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style9" colspan="3">
                <asp:Panel ID="Panel1" runat="server" Font-Bold="True" ForeColor="Maroon" Font-Size="Large">
                    Por favor: Escriba el Número IP de su Extensión Telefónica o el de la Persona más cercana para comunicarnos. Gracias.
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
