<%@ Page Title="Imprimir Devolución Cupón de Pago" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ImprimirDevolucionCuponPago.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.ImprimirDevolucionCuponPago" %>

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
            <td colspan="8"><h2>Imprimir Devolución Cupón de Pago:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2></td>
        </tr>
        <tr>
            <td colspan="8">
                <asp:GridView ID="grvDevolucionCuponPago" runat="server" DataSourceID="SdsDevolucionCuponPago" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnSelectedIndexChanged="grvDevolucionCuponPago_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Centro Formacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="PrimerNombre" HeaderText="PrimerNombre" SortExpression="PrimerNombre" />
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="NroInterno" SortExpression="NroInternodeTransaccion" />
                        <asp:BoundField DataField="ValorDevolucion" HeaderText="Valor Devolucion" SortExpression="ValorDevolucion"  DataFormatString="{0:c0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NombreMotivoDevolucion" HeaderText="Motivo Devolucion" SortExpression="NombreMotivoDevolucion" />
                        <asp:BoundField DataField="Saldo" HeaderText="Saldo" SortExpression="Saldo" DataFormatString="{0:c0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Pagado" HeaderText="Pagado" SortExpression="Pagado" ReadOnly="True" >
                            <ItemStyle HorizontalAlign="Center" Font-Bold="True" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaPago" HeaderText="FechaPago" SortExpression="FechaPago" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Autorizó" HeaderText="Autorizó" SortExpression="Autorizó" />
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
                <asp:SqlDataSource ID="SdsDevolucionCuponPago" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarDevolucionCuponPago]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:Panel ID="Panel1" runat="server" Font-Bold="True">
                    Seleccione la Devolución del Cupón a Imprimir
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
