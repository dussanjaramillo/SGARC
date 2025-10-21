<%@ Page Title="Rol" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Rol.aspx.cs" Inherits="WebLiquidador.Paginas.AtencionCiudadano.Usuario.Rol" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style6 {
            width: 34%;
        }
    .auto-style7 {
            width: 359px;
        }
    .auto-style8 {
    }
    .auto-style9 {
        width: 168px;
    }
    .auto-style10 {
        width: 160px;
    }
    .auto-style11 {
        }
        .auto-style12 {
            width: 165px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="3"><h2>Rol</h2></td>
        </tr>
        <tr>
            <td class="auto-style12">Codigo Rol</td>
            <td class="auto-style9">Nombre Rol</td>
            <td class="auto-style10">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style12">
                <asp:TextBox ID="txtCodigoRol" runat="server" MaxLength="2" Width="170px"></asp:TextBox>
                <br />
                            </td>
            <td class="auto-style9">
                <asp:TextBox ID="txtNombreRol" runat="server" Height="16px" MaxLength="25" Width="170px"></asp:TextBox>
                <br />
                            </td>
            <td class="auto-style10">
                            <asp:CheckBox ID="chbEsActivo" runat="server" Font-Bold="True" ForeColor="Maroon" Text="Activo" Checked="True" ToolTip="Es Activo?" TextAlign="Left" />
                        </td>
        </tr>
        <tr>
            <td class="auto-style12">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtCodigoRol" ErrorMessage="Requerido" ForeColor="Maroon" Font-Bold="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="txtCodigoRol" ErrorMessage="Requerido" ForeColor="Maroon" Font-Bold="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
                            </td>
            <td class="auto-style9">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtNombreRol" ErrorMessage="Requerido" ForeColor="Maroon" Font-Bold="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
                            </td>
            <td class="auto-style10">
                            &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" colspan="3" style="background-color: #E48F43">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style12">
                            <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
                        </td>
            <td class="auto-style9">
                            <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" />
                        </td>
            <td class="auto-style10">
                            <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
                        </td>
        </tr>
        <tr>
            <td class="auto-style11" colspan="3">
                <asp:GridView ID="grvRol" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" DataKeyNames="IdRol" DataSourceID="SdsRol" OnSelectedIndexChanged="grvRol_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="Gainsboro" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdRol" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdRol" />
                        <asp:BoundField DataField="CodigoRol" HeaderText="Codigo Rol" SortExpression="CodigoRol" />
                        <asp:BoundField DataField="NombreRol" HeaderText="Nombre Rol" SortExpression="NombreRol" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
                    </Columns>
                    <HeaderStyle BackColor="#465767" ForeColor="White" />
                </asp:GridView>
            </td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style7">&nbsp;</td>
            <td class="auto-style12">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style10">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style7">
                <asp:SqlDataSource ID="SdsRol" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_RolBuscar" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td class="auto-style12">
                            <asp:HiddenField ID="HfTransaccion" runat="server" Visible="False" />
                            </td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style10">&nbsp;</td>
            <td>
                            <asp:HiddenField ID="hfIdRol" runat="server" Visible="False" />
                            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
