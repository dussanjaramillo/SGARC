<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="PagosDuplicados.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Siif.PagosDuplicados" %>
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
            <td><h2>Pagos Duplicados Siif - Nación: <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2></td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grvPagosDuplicados" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsPagosDuplicados" GridLines="Vertical" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IdPagosFacturaDuplicadoSiif" OnDataBound="grvPagosDuplicados_DataBound">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="IdPagosFacturaDuplicadoSiif" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdPagosFacturaDuplicadoSiif" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="NumeroFactura" SortExpression="NumeroFactura" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaRegistro" HeaderText="FechaRegistro" SortExpression="FechaRegistro" />
                        <asp:BoundField DataField="CentroPci" HeaderText="CentroPci" SortExpression="CentroPci" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="ValorPago" HeaderText="ValorPago" SortExpression="ValorPago" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NumeroCuponPago" HeaderText="Cupon Pago" SortExpression="NumeroCuponPago" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NumeroCuponPagoNew" HeaderText="Nuevo Cupon Pago" SortExpression="NumeroCuponPagoNew" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" >
                        </asp:CheckBoxField>
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
                <asp:SqlDataSource ID="SdsPagosDuplicados" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="CentroFormacion.Usp_BuscarPagosFacturaDuplicadoSiif" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        </table>
</asp:Content>
