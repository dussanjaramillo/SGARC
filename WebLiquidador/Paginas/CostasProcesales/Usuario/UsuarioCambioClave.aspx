<%@ Page Title="Cambio Clave" Language="C#" MasterPageFile="~/SiteCpp.Master" AutoEventWireup="true" CodeBehind="UsuarioCambioClave.aspx.cs" Inherits="WebLiquidador.Paginas.CostasProcesales.Usuario.UsuarioCambioClave" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style2 {
        }
        .auto-style3 {
            width: 121px;
            color: #000000;
        }
        .auto-style4 {
            height: 26px;
        }
        .auto-style5 {
            width: 499px;
            height: 26px;
        }
        .auto-style7 {
            width: 181px;
        }
        .auto-style8 {
            width: 181px;
            height: 26px;
        }
        .auto-style9 {
        }
        .auto-style10 {
            height: 30px;
        }
        .auto-style11 {
            width: 817px;
            height: 30px;
        }
        .auto-style12 {
            width: 121px;
            height: 30px;
        }
        .auto-style13 {
            width: 181px;
            height: 30px;
        }
        .auto-style14 {
            width: 817px;
        }
        .auto-style15 {
            width: 817px;
            height: 26px;
        }
        .auto-style16 {
            width: 158px;
        }
        .auto-style17 {
            height: 26px;
            width: 158px;
        }
        .auto-style18 {
            width: 158px;
            height: 30px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Cambio Clave</h2>
    <table align="center" class="auto-style1">
        <tr>
            <td>&nbsp;</td>
            <td class="auto-style2" colspan="5" style="background-color: #465767">&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="auto-style14">
        <asp:Label ID="LblNombreUsuario" runat="server" Font-Bold="True" ForeColor="Black"></asp:Label>
                </td>
            <td class="auto-style3" ><strong>Codigo Usuario:</strong></td>
            <td class="auto-style7">
                <asp:TextBox ID="txtCodigoUsuario" runat="server" Font-Bold="True" ReadOnly="True" style="text-align: center" ToolTip="Codigo Usuario" Width="170px" MaxLength="20"></asp:TextBox>
            </td>
            <td colspan="2">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagenes/SenaMasTrabajo.jpg" Height="43px" Width="64px" />
                <asp:Image ID="Image2" runat="server" ImageUrl="~/Imagenes/logo-minTrabajo.png" Height="35px" Width="165px" />
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="auto-style14">
        <asp:Label ID="LblNombreEntidad" runat="server"  ForeColor="Black"></asp:Label>
                </td>
            <td class="auto-style3"><strong>Clave Anterior:</strong></td>
            <td class="auto-style7">
                <asp:TextBox ID="txtClaveAnterior" runat="server" MaxLength="20" TextMode="Password" ToolTip="Clave Anterior" Width="170px">Clave Anterior</asp:TextBox>
            </td>
            <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtClaveAnterior" ValidationExpression="[a-zA-Z0-9]{7}" ErrorMessage="Requerido" ForeColor="Maroon" Font-Bold="True" ValidationGroup="btnCambiarClave"></asp:RequiredFieldValidator>
                        </td>
            <td class="auto-style16">
                            <asp:HiddenField ID="HfTransaccion" runat="server" Visible="False" />
                        </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="auto-style14">&nbsp;</td>
            <td class="auto-style3"><strong>Nueva Clave:</strong></td>
            <td class="auto-style7">
                <asp:TextBox ID="txtNuevaClave" runat="server" MaxLength="20" TextMode="Password" ToolTip="Nueva Clave 7 Caracteres Mínimo" Width="170px">Nueva Clave</asp:TextBox>
            </td>
            <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtNuevaClave" ValidationExpression="[a-zA-Z0-9]{7}" ErrorMessage="Requerido" ForeColor="Maroon" Font-Bold="True" ValidationGroup="btnCambiarClave"></asp:RequiredFieldValidator>
                        </td>
            <td class="auto-style16">
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 		
		ControlToValidate="txtNuevaClave"
    ErrorMessage="7 caracteres Mínimo" 
		ValidationExpression=".{7}.*" Font-Bold="True" ForeColor="Maroon" style="font-weight: 400"></asp:RegularExpressionValidator>


                </td>
        </tr>
        <tr>
            <td class="auto-style4"></td>
            <td class="auto-style15"></td>
            <td class="auto-style3"><strong>Confirme la Clave:</strong></td>
            <td class="auto-style8">
                <asp:TextBox ID="txtConfirmaClave" runat="server" MaxLength="20" style="margin-bottom: 0px" TextMode="Password" ToolTip="Confirma Clave" Width="170px">Confirma Clave</asp:TextBox>
            </td>
            <td class="auto-style4">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtConfirmaClave" ValidationExpression="[a-zA-Z0-9]{7}" ErrorMessage="Requerido" ForeColor="Maroon" Font-Bold="True" ValidationGroup="btnCambiarClave"></asp:RequiredFieldValidator>
                        </td>
            <td class="auto-style17">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10"></td>
            <td class="auto-style11"></td>
            <td class="auto-style12"></td>
            <td class="auto-style13">
                <asp:Button ID="btnCambiarClave" runat="server" OnClick="btnCambiarClave_Click" Text="Cambiar" ValidationGroup="btnCambiarClave" Width="175px" />
                <asp:Button ID="btnReiniciar" runat="server" OnClick="btnReiniciar_Click" Text="Iniciar Sesión" Width="175px" Visible="False" />
            </td>
            <td class="auto-style10"></td>
            <td class="auto-style18"></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="auto-style9" colspan="5" style="background-color: #465767">&nbsp;</td>
        </tr>
        </table>
    </asp:Content>
