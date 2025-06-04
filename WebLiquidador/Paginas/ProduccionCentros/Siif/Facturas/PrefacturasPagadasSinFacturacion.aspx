<%@ Page Title="Prefacturas Pagadas Sin Facturacion" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="PrefacturasPagadasSinFacturacion.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Siif.Facturas.PrefacturasPagadasSinFacturacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style12">
        <tr>
            <td><h2>Prefacturas Pagadas Sin Facturacion:&nbsp;
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2></td>
        </tr>
        </table>
    <table class="auto-style12">
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SdsFacturaElectronicas" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderWidth="1px" CellPadding="3" Width="910px" BorderStyle="None" PageSize="15">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="PreFactura" HeaderText="PreFactura" SortExpression="PreFactura" />
                        <asp:BoundField DataField="Pagada" HeaderText="Pagada" SortExpression="Pagada" />
                        <asp:BoundField DataField="CuponPago" HeaderText="CuponPago" SortExpression="CuponPago" />
                        <asp:BoundField DataField="FechaCupon" DataFormatString="{0:d}" HeaderText="FechaCupon" SortExpression="FechaCupon" />
                        <asp:BoundField DataField="ValorPago" HeaderText="ValorPago" SortExpression="ValorPago" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Centro" HeaderText="Centro" SortExpression="Centro" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" ForeColor="White" Font-Bold="True" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
            </td>
        </tr>
        </table>
<table class="auto-style11">
        <tr>
            <td class="auto-style10">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>
                <asp:DropDownList ID="ddlTipoArchivo" runat="server" Width="170px">
                    <asp:ListItem Value="2" Selected="True">Excel</asp:ListItem>
                    <asp:ListItem Value="1">Txt</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style10" colspan="3">
                <asp:GridView ID="GridView2" runat="server" DataSourceID="SdsFacturaElectronicas" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderWidth="1px" CellPadding="3" Width="248px" BorderStyle="None" PageSize="15" Visible="False">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="PreFactura" HeaderText="PreFactura" SortExpression="PreFactura" />
                        <asp:BoundField DataField="Pagada" HeaderText="Pagada" SortExpression="Pagada" />
                        <asp:BoundField DataField="CuponPago" HeaderText="CuponPago" SortExpression="CuponPago" />
                        <asp:BoundField DataField="FechaCupon" DataFormatString="{0:d}" HeaderText="FechaCupon" SortExpression="FechaCupon" />
                        <asp:BoundField DataField="ValorPago" HeaderText="ValorPago" SortExpression="ValorPago" />
                        <asp:BoundField DataField="Centro" HeaderText="Centro" SortExpression="Centro" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" ForeColor="White" Font-Bold="True" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
            </td>
        </tr>
        </table>
<table class="auto-style8">
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsFacturaElectronicas" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_BuscarPreFacturaPagadaSinFacturaElectronica]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="CodigoCentroFormacion" SessionField="_CodigoCentroFormacion" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfId" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
