<%@ Page Title="Cupónes de Pago Recibidos Hoy - En Línea" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="PagosHoySirec.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Sirec.PagosHoySirec" %>
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
            <td><h2>Cupónes de Pago Recibidos Hoy - En Línea: 
                <asp:Label ID="LblHoy" runat="server" Font-Bold="True" ForeColor="Maroon"></asp:Label>
                &nbsp;</h2></td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grvPagosRecibidosHoy" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsPagosHoy" AllowPaging="True" AutoGenerateColumns="False" AllowSorting="True" PageSize="20" OnDataBound="grvPagosRecibidosHoy_DataBound">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="Item" HeaderText="Item" SortExpression="Item" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
<%--                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />--%>
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificación" SortExpression="Identificacion" />
                        <asp:BoundField DataField="PrimerNombre" HeaderText="PrimerNombre" SortExpression="PrimerNombre" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Prefactura" SortExpression="NumeroFactura" >
                        <ItemStyle HorizontalAlign="Right" Font-Bold="True" ForeColor="Maroon" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorTotaldelPago" DataFormatString="{0:N0}" HeaderText="ValorPago" SortExpression="ValorTotaldelPago">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="CupónPago" SortExpression="NroInternodeTransaccion" >
                        <ItemStyle HorizontalAlign="Right" Font-Bold="True" ForeColor="Maroon" />
                        </asp:BoundField>
<%--                        <asp:BoundField DataField="EntidadFinancieraAutorizadora" HeaderText="EntidadFinanciera" SortExpression="EntidadFinancieraAutorizadora" />--%>
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
                <asp:SqlDataSource ID="SdsPagosHoy" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_BuscarPagosCentrosHoy]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        </table>
</asp:Content>
