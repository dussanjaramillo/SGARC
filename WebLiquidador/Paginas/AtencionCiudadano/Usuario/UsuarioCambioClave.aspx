<%@ Page Title="Cambio Clave" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UsuarioCambioClave.aspx.cs" Inherits="WebLiquidador.Paginas.AtencionCiudadano.Usuario.UsuarioCambioClave" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">



    <style type="text/css">
        .auto-style8 {
            width: 140px;
        }
        .auto-style9 {
            width: 126px;
        }
        .auto-style10 {
            width: 127px;
        }
        .auto-style11 {
            width: 236px;
        }
    </style>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Cambio Clave</h2>
    <table class="auto-style14">
        <tr>
            <td class="auto-style2" colspan="5" style="background-color: #465767">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style11">
        <asp:Label ID="LblNombreUsuario" runat="server" Font-Bold="True" ForeColor="Black"></asp:Label>
                </td>
            <td class="auto-style8" ><strong>Codigo Usuario:</strong></td>
            <td class="auto-style13">
                <asp:TextBox ID="txtCodigoUsuario" runat="server" Font-Bold="True" ReadOnly="True" style="text-align: center" ToolTip="Codigo Usuario" Width="170px" MaxLength="20"></asp:TextBox>
            </td>
            <td colspan="2">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagenes/SenaMasTrabajo.jpg" Height="43px" Width="64px" />
                <asp:Image ID="Image2" runat="server" ImageUrl="~/Imagenes/logo-minTrabajo.png" Height="35px" Width="165px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style11">
        <asp:Label ID="LblNombreEntidad" runat="server"  ForeColor="Black"></asp:Label>
                </td>
            <td class="auto-style8"><strong>Clave Anterior:</strong></td>
            <td class="auto-style13">
                <asp:TextBox ID="txtClaveAnterior" runat="server" MaxLength="20" TextMode="Password" ToolTip="Clave Anterior" Width="170px">Clave Anterior</asp:TextBox>
            </td>
            <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtClaveAnterior" ValidationExpression="[a-zA-Z0-9]{7}" ErrorMessage="Requerido" ForeColor="Maroon" Font-Bold="True" ValidationGroup="btnCambiarClave"></asp:RequiredFieldValidator>
                        </td>
            <td>
                            <asp:HiddenField ID="HfTransaccion" runat="server" Visible="False" />
                        </td>
        </tr>
        <tr>
            <td class="auto-style11">&nbsp;</td>
            <td class="auto-style8"><strong>Nueva Clave:</strong></td>
            <td class="auto-style13">
                <asp:TextBox ID="txtNuevaClave" runat="server" MaxLength="20" TextMode="Password" ToolTip="Nueva Clave 7 Caracteres Mínimo" Width="170px">Nueva Clave</asp:TextBox>
            </td>
            <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtNuevaClave" ValidationExpression="[a-zA-Z0-9]{7}" ErrorMessage="Requerido" ForeColor="Maroon" Font-Bold="True" ValidationGroup="btnCambiarClave"></asp:RequiredFieldValidator>
                        </td>
            <td>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 		
		ControlToValidate="txtNuevaClave"
    ErrorMessage="7 caracteres Mínimo" 
		ValidationExpression=".{7}.*" Font-Bold="True" ForeColor="Maroon" style="font-weight: 400"></asp:RegularExpressionValidator>


                </td>
        </tr>
        <tr>
            <td class="auto-style11"></td>
            <td class="auto-style8"><strong>Confirme la Clave:</strong></td>
            <td class="auto-style13">
                <asp:TextBox ID="txtConfirmaClave" runat="server" MaxLength="20" style="margin-bottom: 0px" TextMode="Password" ToolTip="Confirma Clave" Width="170px">Confirma Clave</asp:TextBox>
            </td>
            <td class="auto-style4">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtConfirmaClave" ValidationExpression="[a-zA-Z0-9]{7}" ErrorMessage="Requerido" ForeColor="Maroon" Font-Bold="True" ValidationGroup="btnCambiarClave"></asp:RequiredFieldValidator>
                        </td>
            <td class="auto-style4">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style11"></td>
            <td class="auto-style8"></td>
            <td class="auto-style13">
                <asp:Button ID="btnCambiarClave" runat="server" OnClick="btnCambiarClave_Click" Text="Cambiar" ValidationGroup="btnCambiarClave" Width="175px" />
            </td>
            <td class="auto-style10">
                <asp:Button ID="btnReiniciar" runat="server" OnClick="btnReiniciar_Click" Text="Iniciar Sesión" Width="175px" Visible="False" />
            </td>
            <td class="auto-style10"></td>
        </tr>
        <tr>
            <td class="auto-style9" colspan="5" style="background-color: #465767">&nbsp;</td>
        </tr>
        </table>
    </asp:Content>
