<%@ Page Title="Monitoreo Usuario" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="UsuarioMonitoreo.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Usuario.UsuarioMonitoreo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style10 {
            width: 170px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td>
                <h2>Monitoreo Usuario</h2>
            </td>
        </tr>
    </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style10">
                <br />
                <asp:Button ID="btnExportar" runat="server" Text="Exportar" Width="170px" OnClick="btnExportar_Click" />
            </td>
            <td class="auto-style10">
                Regional<asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="ddlRegional" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
                <br />
                <asp:DropDownList ID="ddlRegional" runat="server" Width="170px" ToolTip="Regional del Usuario" DataSourceID="SdsRegional" DataTextField="NombreRegional" DataValueField="IdRegional" OnDataBound="ddlRegional_DataBound" AutoPostBack="True">
                </asp:DropDownList>
            </td>
            <td class="auto-style11">
                Centro<asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Maroon" Text=": Requerido" Visible="False"></asp:Label>
                <br />
                <asp:DropDownList ID="ddlCentroFormacion" runat="server" Width="170px" DataSourceID="SdsCentro" DataTextField="NombreCentroFormacion" DataValueField="IdCentroFormacion" OnDataBound="ddlCentroFormacion_DataBound" AutoPostBack="True" OnSelectedIndexChanged="ddlCentroFormacion_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="auto-style11">
                <br />
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
    </table>
    <asp:GridView ID="grvMonitoreoUsuario" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsMonitoreoUsuario" OnRowDataBound="grvMonitoreoUsuario_RowDataBound" PageSize="15" style="margin-left: 13px" Width="1234px">
        <AlternatingRowStyle BackColor="#DCDCDC" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="Codigo" DataNavigateUrlFormatString="~/Paginas/ProduccionCentros/Usuario/UsuariosReeviarClave.aspx?id={0}" DataTextField="Codigo" HeaderText="Codigo" NavigateUrl="~/Paginas/ProduccionCentros/Usuario/UsuariosReeviarClave.aspx" Text="Codigo" />
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
            <asp:BoundField DataField="NombreCargo" HeaderText="Cargo" SortExpression="NombreCargo" />
            <asp:BoundField DataField="FechaModifica" HeaderText="FechaModifica" SortExpression="FechaModifica" />
            <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
            <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Centro Formacion" SortExpression="NombreCentroFormacion" />
            <asp:BoundField DataField="IpTelefono" HeaderText="Ip" SortExpression="IpTelefono" />
            <asp:BoundField DataField="EsActivo" HeaderText="Activo" SortExpression="EsActivo">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
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
    <table class="auto-style6">
        <tr>
            <td>
            <asp:GridView ID="grvMonitoreoUsuario0" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsMonitoreoUsuario0" PageSize="15" Style="margin-left: 13px" Width="1234px">
                <AlternatingRowStyle BackColor="#DCDCDC" />
                <Columns>
                    <asp:BoundField DataField="Codigo" HeaderText="Codigo" SortExpression="Codigo" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                    <asp:BoundField DataField="NombreCargo" HeaderText="NombreCargo" SortExpression="NombreCargo" />
                    <asp:BoundField DataField="FechaModifica" HeaderText="FechaModifica" SortExpression="FechaModifica" />
                    <asp:BoundField DataField="NombreRegional" HeaderText="NombreRegional" SortExpression="NombreRegional" />
                    <asp:BoundField DataField="NombreCentroFormacion" HeaderText="NombreCentroFormacion" SortExpression="NombreCentroFormacion" />
                    <asp:BoundField DataField="EsActivo" HeaderText="EsActivo" ReadOnly="True" SortExpression="EsActivo" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="IpTelefono" HeaderText="IpTelefono" SortExpression="IpTelefono" />
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
                <asp:GridView ID="grvMonitoreo" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsMonitoreoUsuario" Visible="False" AutoGenerateColumns="False">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" SortExpression="Codigo" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="NombreCargo" HeaderText="NombreCargo" SortExpression="NombreCargo" />
                        <asp:BoundField DataField="FechaModifica" HeaderText="FechaModifica" SortExpression="FechaModifica" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="NombreRegional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="NombreCentroFormacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="EsActivo" HeaderText="EsActivo" ReadOnly="True" SortExpression="EsActivo" />
                        <asp:BoundField DataField="IpTelefono" HeaderText="IpTelefono" SortExpression="IpTelefono" />
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
                <asp:SqlDataSource ID="SdsMonitoreoUsuario" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarUsuariosMonitoreoXProduccionCentros" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td class="auto-style10">
                <asp:SqlDataSource ID="SdsRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarRegional" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td class="auto-style10">
                <asp:SqlDataSource ID="SdsCentro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarCentroFormacionXRegional" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlRegional" Name="IdRegional" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsMonitoreoUsuario0" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarUsuarioXRegionalXCentro]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlRegional" Name="IdRegional" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlCentroFormacion" Name="IdCentroFormacion" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="auto-style9">&nbsp;</td>
        </tr>
    </table>
</asp:Content>
