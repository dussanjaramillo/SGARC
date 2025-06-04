<%@ Page Title="Cambio Clave" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="UsuarioCambioClave.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Usuario.UsuarioCambioClave" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">
        .auto-style6 {
            width: 229px;
        }
        .auto-style9 {
        }
        .auto-style10 {
            width: 476px;
        }
        .auto-style12 {
            width: 192px;
        }
        .auto-style16 {
            width: 286px;
        }
        .auto-style17 {
            width: 721px;
        }
        .auto-style19 {
            width: 229px;
            height: 24px;
        }
        .auto-style20 {
            width: 721px;
            height: 24px;
        }
        .auto-style22 {
            width: 192px;
            height: 24px;
        }
        .auto-style24 {
            width: 286px;
            height: 24px;
        }
        .auto-style25 {
            height: 24px;
        }
        .auto-style28 {
            width: 447px;
        }
        .auto-style29 {
            width: 447px;
            height: 24px;
        }
        .auto-style30 {
            width: 278px;
        }
        .auto-style31 {
            width: 278px;
            height: 24px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Cambio Clave</h2>
    <table align="center" class="auto-style1">
        <tr>
            <td class="auto-style6" rowspan="2">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagenes/SenaMasTrabajo.jpg" Height="43px" Width="64px" />
                </td>
            <td class="auto-style2" colspan="6" style="background-color: #465767">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style17">
        <asp:Label ID="LblNombreUsuario" runat="server" Font-Bold="True" ForeColor="Black"></asp:Label>
                </td>
            <td class="auto-style30" ><strong>Codigo Usuario:</strong></td>
            <td class="auto-style12">
                <asp:TextBox ID="txtCodigoUsuario" runat="server" Font-Bold="True" ReadOnly="True" style="text-align: center" ToolTip="Codigo Usuario" Width="170px" MaxLength="20"></asp:TextBox>
            </td>
            <td class="auto-style28">
                &nbsp;</td>
            <td class="auto-style16">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style19">
                <asp:Image ID="Image2" runat="server" ImageUrl="~/Imagenes/logo-minTrabajo.png" Height="35px" Width="165px" />
            </td>
            <td class="auto-style20">
        <asp:Label ID="LblNombreEntidad" runat="server"  ForeColor="Black"></asp:Label>
                </td>
            <td class="auto-style31"><strong>Clave Anterior:</strong></td>
            <td class="auto-style22">
                <asp:TextBox ID="txtClaveAnterior" runat="server" MaxLength="20" TextMode="Password" ToolTip="Clave Anterior" Width="170px">Clave Anterior</asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtClaveAnterior" ValidationExpression="[a-zA-Z0-9]{7}" ErrorMessage="Requerido" ForeColor="Maroon" Font-Bold="True" ValidationGroup="btnCambiarClave"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style29">
                            &nbsp;</td>
            <td class="auto-style24">
                        </td>
            <td class="auto-style25">
                        </td>
        </tr>
        <tr>
            <td class="auto-style6">&nbsp;</td>
            <td class="auto-style17">&nbsp;</td>
            <td class="auto-style30"><strong>Nueva Clave:</strong></td>
            <td class="auto-style12">
                <asp:TextBox ID="txtNuevaClave" runat="server" MaxLength="20" TextMode="Password" ToolTip="Nueva Clave 7 Caracteres Mínimo" Width="170px">Nueva Clave</asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtNuevaClave" ValidationExpression="[a-zA-Z0-9]{7}" ErrorMessage="Requerido" ForeColor="Maroon" Font-Bold="True" ValidationGroup="btnCambiarClave"></asp:RequiredFieldValidator>


            </td>
            <td class="auto-style28">
                            &nbsp;</td>
            <td class="auto-style16">
                    &nbsp;</td>
            <td>
                    &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style6"></td>
            <td class="auto-style17"></td>
            <td class="auto-style30"><strong>Confirme la Clave:</strong></td>
            <td class="auto-style12">
                <asp:TextBox ID="txtConfirmaClave" runat="server" MaxLength="20" style="margin-bottom: 0px" TextMode="Password" ToolTip="Confirme Clave" Width="170px">Confirma Clave</asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtConfirmaClave" ValidationExpression="[a-zA-Z0-9]{7}" ErrorMessage="Requerido" ForeColor="Maroon" Font-Bold="True" ValidationGroup="btnCambiarClave"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style28">
                            &nbsp;</td>
            <td class="auto-style16">&nbsp;</td>
            <td class="auto-style4">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style6">
                            <asp:HiddenField ID="HfTransaccion" runat="server" Visible="False" />
                        </td>
            <td class="auto-style17">&nbsp;</td>
            <td class="auto-style30"></td>
            <td class="auto-style12">
                <asp:Button ID="btnCambiarClave" runat="server" OnClick="btnCambiarClave_Click" Text="Cambiar" ValidationGroup="btnCambiarClave" Width="175px" />
                <asp:Button ID="btnReiniciar" runat="server" OnClick="btnReiniciar_Click" Text="Iniciar Sesión" Width="175px" Visible="False" />
            </td>
            <td class="auto-style28">&nbsp;</td>
            <td class="auto-style16"></td>
            <td class="auto-style10">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style6">&nbsp;</td>
            <td class="auto-style9" colspan="6" style="background-color: #465767">&nbsp;</td>
        </tr>
        </table>
    </asp:Content>
