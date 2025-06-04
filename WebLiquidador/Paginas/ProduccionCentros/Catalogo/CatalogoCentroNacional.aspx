<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="CatalogoCentroNacional.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Catalogo.CatalogoCentroNacional" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td><h2>Catálogo de Productos Nacional</h2></td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar Catálogo" Width="250px" />
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td colspan="8">
                <asp:GridView ID="grvCatalogoNacional" runat="server" DataSourceID="SdsBuscarCatalogoCentroNacional" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Nombre Centro" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="NombreProducto" HeaderText="NombreProducto" SortExpression="NombreProducto" />
                        <asp:BoundField DataField="PrecioMinimo" HeaderText="Minimo" SortExpression="PrecioMinimo" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PrecioMaximo" HeaderText="Maximo" SortExpression="PrecioMaximo" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NombreUnidadMedida" HeaderText="Unidad" SortExpression="NombreUnidadMedida" />
                        <asp:BoundField DataField="NombreClase" HeaderText="Clase" SortExpression="NombreClase" />
                    </Columns>
                                        <AlternatingRowStyle BackColor="#DCDCDC" />
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
        <tr>
            <td colspan="8">
                <asp:GridView ID="grvCatalogoNacional1" runat="server" DataSourceID="SdsBuscarCatalogoCentroNacional" AutoGenerateColumns="False" Visible="False">
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Nombre Centro" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="CodigoProducto" HeaderText="CodigoProducto" SortExpression="CodigoProducto" />
                        <asp:BoundField DataField="NombreProducto" HeaderText="NombreProducto" SortExpression="NombreProducto" />
                        <asp:BoundField DataField="PrecioMinimo" HeaderText="Minimo" SortExpression="PrecioMinimo" />
                        <asp:BoundField DataField="PrecioMaximo" HeaderText="Maximo" SortExpression="PrecioMaximo" />
                        <asp:BoundField DataField="NombreUnidadMedida" HeaderText="Unidad" SortExpression="NombreUnidadMedida" />
                        <asp:BoundField DataField="NombreClase" HeaderText="Clase" SortExpression="NombreClase" />
                        <asp:BoundField DataField="NombreFamilia" HeaderText="Familia" SortExpression="NombreFamilia" />
                        <asp:BoundField DataField="NombreSegmento" HeaderText="Segmento" SortExpression="NombreSegmento" />
                        <asp:BoundField DataField="NombreGrupo" HeaderText="Grupo" SortExpression="NombreGrupo" />
                    </Columns>
                                        <AlternatingRowStyle BackColor="#DCDCDC" />
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
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsBuscarCatalogoCentroNacional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCatalogoCentroNacional]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
