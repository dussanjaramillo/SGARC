<%@ Page Title="Cupón de Pago Distribuido" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="CuponPagoDistribuido.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.CuponPagoDistribuido" %>

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
            <td colspan="8">
                <h2>Cupón de Pago Distribuido</h2>
            </td>
        </tr>
        <tr>
            <td colspan="8">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
                <asp:Button ID="btnExportar" runat="server" Text="Exportar" Width="170px" OnClick="btnExportar_Click" />
            </td>
        </tr>
        <tr>
            <td colspan="8">
                <asp:GridView ID="grvCuponPagoDistribuido" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SqlCuponPagoDistribuido" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnPageIndexChanged="grvCuponPagoDistribuido_PageIndexChanged" OnSelectedIndexChanged="grvCuponPagoDistribuido_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="NroInternodeTransaccion" SortExpression="NroInternodeTransaccion" />
                        <asp:BoundField DataField="ValorTotaldelPago" HeaderText="ValorTotaldelPago" ReadOnly="True" SortExpression="ValorTotaldelPago" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#465767" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#00547E" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td colspan="8">
                <asp:GridView ID="grvCuponPagoDistribuidoDetalle" runat="server" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="SdsCuponPagoDistribuidoDetalle" AllowPaging="True" AutoGenerateColumns="False" PageSize="5">
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="ValorTotaldelPago" DataFormatString="{0:N0}" HeaderText="ValorTotaldelPago" SortExpression="ValorTotaldelPago">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaEntidadFinanciera" DataFormatString="{0:d}" HeaderText="FechaEntidad" SortExpression="FechaEntidadFinanciera" />
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#465767" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#EDF6F6" />
                    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                    <SortedDescendingCellStyle BackColor="#D6DFDF" />
                    <SortedDescendingHeaderStyle BackColor="#002876" />
                </asp:GridView>
                <br />
                <%--                <asp:GridView ID="grvCuponPagoDistribuidoDetalleExportar" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsCuponPagoDistribuidoDetalleExportar" AutoGenerateColumns="False" Visible="False">
                    <AlternatingRowStyle BackColor="#DCDCDC" />--%>

                <asp:GridView ID="grvCuponPagoDistribuidoDetalleExportar" runat="server" AutoGenerateColumns="False" DataSourceID="SdsCuponPagoDistribuidoDetalleExportar" class="grvGrilla" Caption="Cupon Pago Distribuido Detalle" PageSize="15" Visible="False">

                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="ValorTotaldelPago" HeaderText="ValorTotaldelPago" SortExpression="ValorTotaldelPago" />
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="NroInternodeTransaccion" SortExpression="NroInternodeTransaccion" />
                        <asp:BoundField DataField="FechaEntidadFinanciera" DataFormatString="{0:d}" HeaderText="FechaEntidad" SortExpression="FechaEntidadFinanciera" />
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
                <asp:SqlDataSource ID="SqlCuponPagoDistribuido" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCuponPagoDistribuido]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsCuponPagoDistribuidoDetalle" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCuponPagoDistribuidoDetalle]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfNumeroInterno" Name="NroInternodeTransaccion" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfNumeroInterno" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsCuponPagoDistribuidoDetalleExportar" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCuponPagoDistribuidoDetalleExportar]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
