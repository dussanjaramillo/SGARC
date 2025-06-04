<%@ Page Title="Mensaje Usuarios" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="MantenimientoMensajesUsuarios.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.MantenimientoMensajesUsuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">
        .auto-style10 {
            height: 3px;
        }
        .auto-style12 {
            height: 14px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="2">
                <h2>Mensaje Usuarios -&nbsp; 
                <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                    &nbsp;</h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style10">Mensaje<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMensajeUsuario" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style10">
                <asp:CheckBox ID="chbEsActivo" runat="server" Font-Bold="True" ForeColor="Maroon" Text="Activo" TextAlign="Left" ToolTip="Es Activo?" />
            </td>
        </tr>
        <tr>
            <td class="auto-style8" colspan="2">
                <asp:TextBox ID="txtMensajeUsuario" runat="server" MaxLength="500" TextMode="MultiLine" Width="1102px" Height="104px" AutoPostBack="True" ValidationGroup="btnGuardar"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style12" colspan="2" style="background-color: #465767"></td>
        </tr>
        <tr>
            <td class="auto-style12" colspan="2">
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" />
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style8">
                <asp:GridView ID="grvMensajeUsuarios" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" OnSelectedIndexChanged="grvMensajeUsuarios_SelectedIndexChanged" DataSourceID="SdsTodosMensajeUsuarios" PageSize="5">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                        <asp:BoundField DataField="MensajeUsuarios" HeaderText="MensajeUsuarios" SortExpression="MensajeUsuarios" />
                        <asp:BoundField DataField="EsActivo" HeaderText="EsActivo" ReadOnly="True" SortExpression="EsActivo" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#CCCCCC" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#465767" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </td>
        </tr>
    </table>
    <table class="auto-style6">
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsTodosMensajeUsuarios" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarTodosMensajeUsuarios]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
            </td>
            <td>
                <asp:HiddenField ID="hfMensajeUsuarios" runat="server" Visible="False" />
            </td>
        </tr>
        </table>
</asp:Content>
