<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="PagosRapidosSinPreFactura.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.PagosRapidosSinPreFactura" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style1">
        <tr>
            <td><h2>Pagos Rápidos Sin Prefactura:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2></td>
        </tr>
        <tr>
            <td>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataSourceID="SdsPagosRapidosSinPreFactura" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False">
        <AlternatingRowStyle BackColor="#CCCCCC" />
        <Columns>
            <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
            <asp:BoundField DataField="PrimerNombre" HeaderText="PrimerNombre" SortExpression="PrimerNombre" />
            <asp:BoundField DataField="CorreoElectronico" HeaderText="CorreoElectronico" SortExpression="CorreoElectronico" />
            <asp:BoundField DataField="ValorTotaldelPago" HeaderText="ValorTotaldelPago" SortExpression="ValorTotaldelPago" DataFormatString="{0:N0}" >
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="Cupón" SortExpression="NroInternodeTransaccion" />
            <asp:BoundField DataField="FechaEntidadFinanciera" HeaderText="Fecha" SortExpression="FechaEntidadFinanciera" />
            <asp:BoundField DataField="Centro" HeaderText="Centro" SortExpression="Centro" />
            <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Centro Formacion" SortExpression="NombreCentroFormacion" />
        </Columns>
        <FooterStyle BackColor="#CCCCCC" />
        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#808080" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#383838" />
    </asp:GridView>
    <asp:SqlDataSource ID="SdsPagosRapidosSinPreFactura" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_BuscarPagosRapidosSinPreFactura]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
