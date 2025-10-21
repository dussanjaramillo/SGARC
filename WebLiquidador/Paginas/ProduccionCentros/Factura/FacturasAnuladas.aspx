<%@ Page Title="Documento Equivalente Anulados" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="FacturasAnuladas.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Factura.FacturasAnuladas" %>
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
            <td colspan="2"><h2>Documento Equivalente Anulados:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2></td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView ID="grvFacturaAnulada" runat="server" BackColor="White" class="grvGrilla" BorderColor="#3366CC" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" DataSourceID="SdsFacturaAnulada" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" PageSize="15">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Documento" SortExpression="NumeroFactura" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" SortExpression="FechaCrea" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="FechaModifica" DataFormatString="{0:d}" HeaderText="FechaModifica" SortExpression="FechaModifica" />
                    </Columns>
                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                    <RowStyle BackColor="White" ForeColor="#003399" />
                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <SortedAscendingCellStyle BackColor="#EDF6F6" />
                    <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                    <SortedDescendingCellStyle BackColor="#D6DFDF" />
                    <SortedDescendingHeaderStyle BackColor="#002876" />
                </asp:GridView>
                <br />
                <asp:GridView ID="grvFacturaAnulada0" runat="server" AutoGenerateColumns="False" DataSourceID="SdsFacturaAnulada" class="grvGrilla" Caption="Documento Equivalente Anulados" PageSize="15" Visible="False">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Documento Equivalente" SortExpression="NumeroFactura" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="FechaCrea" DataFormatString="{0:d}" HeaderText="FechaCrea" SortExpression="FechaCrea" />
                        <asp:BoundField DataField="FechaModifica" DataFormatString="{0:d}" HeaderText="FechaModifica" SortExpression="FechaModifica" />
                        <asp:BoundField DataField="Usuario" HeaderText="Usuario" SortExpression="Usuario" />
                        <asp:BoundField DataField="Motivo" HeaderText="Motivo" SortExpression="Motivo" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#4b6c9e" Font-Bold="True" ForeColor="White" />
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
                <asp:SqlDataSource ID="SdsFacturaAnulada" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaAnulada]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
        </tr>
    </table>
</asp:Content>
