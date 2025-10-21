<%@ Page Title="Estadísticas de Pagos Sirec - Ecollect" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="EstadisticaPagos.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Sirec.EstadisticaPagos" %>
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
            <td><h2>Estadísticas de Pagos Sirec - Ecollect - En Línea</h2></td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsEstadisticaPagosSirec" GridLines="Vertical" AutoGenerateColumns="False" DataKeyNames="IdEstadisticaPagoCargueSirec">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="IdEstadisticaPagoCargueSirec" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdEstadisticaPagoCargueSirec" />
                        <asp:BoundField DataField="NumeroRegistrosSirec" HeaderText="RegistrosSirec" SortExpression="NumeroRegistrosSirec" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NumeroRegistrosProcesados" HeaderText="RegistrosProcesados" SortExpression="NumeroRegistrosProcesados" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorTotal" HeaderText="ValorTotal" SortExpression="ValorTotal" DataFormatString="{0:N0}" />
                        <asp:BoundField DataField="FechaMinima" DataFormatString="{0:d}" HeaderText="FechaMinima" SortExpression="FechaMinima" />
                        <asp:BoundField DataField="FechaMaxima" DataFormatString="{0:d}" HeaderText="FechaMaxima" SortExpression="FechaMaxima" />
                        <asp:BoundField DataField="FechaProceso" HeaderText="FechaProceso" SortExpression="FechaProceso" />
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
                <asp:SqlDataSource ID="SdsEstadisticaPagosSirec" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_BuscarEstadisticasPagosProduccionCentrosSirec]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
        </tr>
        </table>
</asp:Content>
