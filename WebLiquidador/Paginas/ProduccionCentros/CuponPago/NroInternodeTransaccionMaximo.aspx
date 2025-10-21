<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="NroInternodeTransaccionMaximo.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.NroInternodeTransaccionMaximo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            width: 100%;
        }
        .auto-style9 {
            font-size: xx-large;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="2"><h2>Número Interno de Transacción (Máximo):<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="auto-style9" DataSourceID="SdsNroInternodeTransaccion" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#DCDCDC" />
                <Columns>
                    <asp:BoundField DataField="NroInternodeTransaccion" ReadOnly="True" SortExpression="NroInternodeTransaccion">
                    <ItemStyle ForeColor="Maroon" />
                    </asp:BoundField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle Font-Bold="True" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
                </h2></td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsNroInternodeTransaccion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarNroInternodeTransaccionMax]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
        </tr>
        </table>
</asp:Content>
