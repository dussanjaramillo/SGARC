<%@ Page Title="Reenvío de Clave" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="UsuariosReeviarClave.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Usuario.UsuariosReeviarClave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">
        .auto-style8 {
            width: 76%;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Reenvío de Clave</h2>
    <table class="auto-style8">
        <tr>
            <td colspan="6" style="background-color: #546E96">
                <asp:Label ID="LblError" runat="server" ForeColor="White" Font-Bold="False"></asp:Label>
                <br />
            </td>
        </tr>
        <tr>
            <td class="auto-style3">Codigo</td>
            <td class="auto-style3">Nombre</td>
            <td class="auto-style3">Regional</td>
            <td class="auto-style3">Centro</td>
            <td class="auto-style3">Rol</td>
            <td class="auto-style3">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style3">
                <asp:TextBox ID="txtCodigoUsuario" runat="server" Width="170px" ToolTip="Codigo del Usuario" MaxLength="20"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtCodigoUsuario_FilteredTextBoxExtender" runat="server" BehaviorID="txtCodigoUsuario_FilteredTextBoxExtender" FilterType="Custom, Numbers, UppercaseLetters, LowercaseLetters" TargetControlID="txtCodigoUsuario" ValidChars="áéíóúÁÉÍÓÚñÑ." />
                <br />
            </td>
            <td class="auto-style3">
                <asp:TextBox ID="txtNombreUsuario" runat="server" MaxLength="60" Width="170px" ToolTip="Nombre del Usuario" Enabled="False"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtNombreUsuario_FilteredTextBoxExtender" runat="server" BehaviorID="txtNombreUsuario_FilteredTextBoxExtender" FilterType="Custom, Numbers, UppercaseLetters, LowercaseLetters" TargetControlID="txtNombreUsuario" ValidChars="áéíóúÁÉÍÓÚñÑ @_():" />
                <br />
            </td>
            <td class="auto-style3">
                <asp:DropDownList ID="ddlRegional" runat="server" Width="170px" ToolTip="Regional del Usuario" DataSourceID="SdsRegional" DataTextField="NombreRegional" DataValueField="IdRegional" OnDataBound="ddlRegional_DataBound" Enabled="False">
                </asp:DropDownList>
            </td>
            <td class="auto-style3">
                            <asp:DropDownList ID="ddlCentroFormacion" runat="server" Width="170px" DataSourceID="SdsCentroFormacion" DataTextField="NombreCentroFormacion" DataValueField="IdCentroFormacion" Enabled="False" OnDataBound="ddlCentroFormacion_DataBound">
                            </asp:DropDownList>
            </td>
            <td class="auto-style3">
                <asp:DropDownList ID="ddlRolUsuario" runat="server" DataSourceID="SdsRolUsuario" DataTextField="NombreRol" DataValueField="IdRol" Width="170px" OnDataBound="ddlRolUsuario_DataBound" ToolTip="Rol del Usuario" Enabled="False">
                </asp:DropDownList>
            </td>
            <td class="auto-style3">
                <asp:CheckBox ID="chbEsActivo" runat="server" Font-Bold="True" ForeColor="Maroon" Text="Activo" Checked="True" ToolTip="Es Activo?" TextAlign="Left" Enabled="False" />
            </td>
        </tr>
        <tr>
            <td class="auto-style3">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCodigoUsuario" ErrorMessage="Requerido" ForeColor="Maroon" Font-Bold="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCodigoUsuario" ErrorMessage="Requerido" ForeColor="Maroon" Font-Bold="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style3">&nbsp;</td>
            <td class="auto-style3">&nbsp;</td>
            <td class="auto-style3">&nbsp;</td>
            <td class="auto-style3">&nbsp;</td>
            <td class="auto-style3">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="6" style="background-color: #546E96">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style9">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" Enabled="False" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style10"></td>
        </tr>
    </table>
    <table class="auto-style1" style="width: 75%">
        <tr>
            <td class="auto-style9">
                <asp:GridView ID="grvUsuarios" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdUsuario" DataSourceID="SdsUsuariosTodos" GridLines="Vertical" OnSelectedIndexChanged="grvUsuarios_SelectedIndexChanged" Width="927px" AllowPaging="True" AllowSorting="True">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdUsuario" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdUsuario" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" SortExpression="Codigo" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="FechaCrea" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Crea" SortExpression="FechaCrea" />
                        <asp:BoundField DataField="FechaModifica" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Modifica" SortExpression="FechaModifica" />
                        <asp:BoundField DataField="NombreCargo" HeaderText="NombreCargo" SortExpression="NombreCargo" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:CheckBoxField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#465767" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
            </td>
        </tr>
    </table>
    <table align="center" class="auto-style1" style="width: 97%">
        <tr>
            <td class="auto-style12">
                <asp:SqlDataSource ID="SdsUsuariosTodos" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_UsuarioBuscarProduccionCentros" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td class="auto-style13">
                <asp:SqlDataSource ID="SdsRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarRegional" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td class="auto-style13">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td class="auto-style13">
                <asp:SqlDataSource ID="SdsRolUsuario" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_RolConsultarTodos" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td class="auto-style13">
                <asp:HiddenField ID="HfTransaccion" runat="server" Visible="False" />
            </td>
            <td class="auto-style13">
                <asp:HiddenField ID="HfIdUsuario" runat="server" Visible="False" />
            </td>
        </tr>
        <tr>
            <td class="auto-style12">
                <asp:HiddenField ID="hdfUsuarioEncontrado" runat="server" />
            </td>
            <td class="auto-style13">
                <asp:SqlDataSource ID="SdsCentroFormacion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCentroXIdCentroFormacion]" SelectCommandType="StoredProcedure">
                </asp:SqlDataSource>
            </td>
            <td class="auto-style13">&nbsp;</td>
            <td class="auto-style13">&nbsp;</td>
            <td class="auto-style13">&nbsp;</td>
            <td class="auto-style13">
                <asp:HiddenField ID="hfClaveUSR" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
