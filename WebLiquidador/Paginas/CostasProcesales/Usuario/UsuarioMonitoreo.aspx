<%@ Page Title="Monitoreo Usuario" Language="C#" MasterPageFile="~/SiteCpp.Master" AutoEventWireup="true" CodeBehind="UsuarioMonitoreo.aspx.cs" Inherits="WebLiquidador.Paginas.CostasProcesales.Usuario.UsuarioMonitoreo" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td>
                <h2>Monitoreo Usuario</h2>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td class="auto-style10">&nbsp;</td>
            <td class="auto-style11">Regional<asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="ddlRegional" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style11">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:Button ID="btnExportar" runat="server" Text="Exportar" Width="170px" OnClick="btnExportar_Click" />
            </td>
            <td class="auto-style11">
                <asp:DropDownList ID="ddlRegional" runat="server" Width="170px" ToolTip="Regional del Usuario" DataSourceID="SdsRegional" DataTextField="NombreRegional" DataValueField="IdRegional" OnDataBound="ddlRegional_DataBound" AutoPostBack="True" OnSelectedIndexChanged="ddlRegional_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="auto-style11">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
    </table>
    <asp:GridView ID="grvMonitoreoUsuario" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" DataSourceID="SdsMonitoreoUsuario" OnRowDataBound="grvMonitoreoUsuario_RowDataBound" PageSize="15" style="margin-left: 13px" Width="1234px" DataKeyNames="IdUsuario">
        <AlternatingRowStyle BackColor="#999966" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="Codigo" DataNavigateUrlFormatString="~/Paginas/CostasProcesales/Usuario/UsuariosReeviarClave.aspx?id={0}" DataTextField="Codigo" HeaderText="Codigo" NavigateUrl="~/Paginas/CostasProcesales/Usuario/UsuariosReeviarClave.aspx" Text="Codigo" />
            <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
            <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" SortExpression="FechaCrea" />
            <asp:BoundField DataField="FechaModifica" HeaderText="FechaModifica" SortExpression="FechaModifica" />
            <asp:BoundField DataField="NombreRol" HeaderText="Rol" SortExpression="NombreRol" />
            <asp:BoundField DataField="NombreCargo" HeaderText="Cargo" SortExpression="NombreCargo" />
            <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
        </Columns>
        <FooterStyle BackColor="White" ForeColor="#333333" />
        <HeaderStyle BackColor="DarkOliveGreen" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="DarkOliveGreen" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="White" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="#487575" />
        <SortedDescendingCellStyle BackColor="#E5E5E5" />
        <SortedDescendingHeaderStyle BackColor="#275353" />
    </asp:GridView>
    <table class="auto-style6">
        <tr>
            <td>
            <asp:GridView ID="grvMonitoreoUsuario0" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsMonitoreoUsuario0" PageSize="15" Style="margin-left: 13px" Width="1234px">
                <AlternatingRowStyle BackColor="#DCDCDC" />
                <Columns>
                    <asp:BoundField DataField="Codigo" HeaderText="Codigo" SortExpression="Codigo" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                    <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" SortExpression="FechaCrea" />
                    <asp:BoundField DataField="FechaModifica" HeaderText="FechaModifica" SortExpression="FechaModifica" />
                    <asp:BoundField DataField="NombreRol" HeaderText="NombreRol" SortExpression="NombreRol" />
                    <asp:BoundField DataField="NombreRegional" HeaderText="NombreRegional" SortExpression="NombreRegional" />
                    <asp:BoundField DataField="IpTelefono" HeaderText="IpTelefono" SortExpression="IpTelefono" >
                    </asp:BoundField>
                    <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
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
                <asp:GridView ID="grvMonitoreo" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsMonitoreoUsuario" Visible="False" AutoGenerateColumns="False" DataKeyNames="IdUsuario">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="IdUsuario" HeaderText="IdUsuario" SortExpression="IdUsuario" InsertVisible="False" ReadOnly="True" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="NombreRegional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" SortExpression="Codigo" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
                        <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" SortExpression="FechaCrea" />
                        <asp:BoundField DataField="FechaModifica" HeaderText="FechaModifica" SortExpression="FechaModifica" />
                        <asp:BoundField DataField="NombreRol" HeaderText="NombreRol" SortExpression="NombreRol" />
                        <asp:BoundField DataField="NombreCargo" HeaderText="NombreCargo" SortExpression="NombreCargo" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
                <br />
            </td>
        </tr>
    </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style10">
                <asp:SqlDataSource ID="SdsMonitoreoUsuario" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[dbo].[Usp_UsuarioBuscarXIdRol]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdRol" SessionField="_IdRol" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="auto-style10">
                <asp:SqlDataSource ID="SdsRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarRegional" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td class="auto-style10">
                <asp:SqlDataSource ID="SdsCentro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CostasProcesales].[Usp_BuscarUsuariosMonitoreoXRegional]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlRegional" Name="IdRegional" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsMonitoreoUsuario0" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CostasProcesales].[Usp_BuscarUsuariosMonitoreoXRegional]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlRegional" Name="IdRegional" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="auto-style9">&nbsp;</td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" runat="server" contentplaceholderid="HeadContent">
    <style type="text/css">
        .auto-style10 {
            width: 4px;
        }
    </style>
</asp:Content>

