<%@ Page Title="Control Cargue de Pagos Ecollect" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ControlCarguePagos.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.ControlCarguePagos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            width: 100%;
        }

        .auto-style9 {
            height: 8px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td><h2>Control Cargue de Pagos Ecollect</h2></td>
        </tr>
        <tr>
            <td class="auto-style9">
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SdsControlCarguePagos" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" PageSize="20">
                    <Columns>
                        <asp:BoundField DataField="NombreArchivo" HeaderText="Nombre Archivo" SortExpression="NombreArchivo" />
                        <asp:BoundField DataField="NumeroRegistros" HeaderText="Numero Registros" SortExpression="NumeroRegistros" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorTotaldelPago" HeaderText="Valor Total" SortExpression="ValorTotaldelPago" DataFormatString="{0:c0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaMinima" HeaderText="Fecha Minima" SortExpression="FechaMinima" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="FechaMaxima" HeaderText="Fecha Maxima" SortExpression="FechaMaxima" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="FechaUsuarioCrea" HeaderText="Fecha Creado" SortExpression="FechaUsuarioCrea" />
                        <asp:BoundField DataField="Nombre" HeaderText="Usuario" SortExpression="Nombre" />
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
                <asp:SqlDataSource ID="SdsControlCarguePagos" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarControlCarguePagos_1]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
