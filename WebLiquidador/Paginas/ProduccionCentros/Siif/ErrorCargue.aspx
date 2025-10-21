<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ErrorCargue.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Siif.ErrorCargue" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
    <tr>
        <td><h2>Registros con Error - Siif Nación</h2></td>
    </tr>
    <tr>
        <td>
            <asp:GridView ID="grvRegistrosErrados" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsErrorCargue" GridLines="Vertical" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IdCarguePagosFacturaSiif">
                <AlternatingRowStyle BackColor="#DCDCDC" />
                <Columns>
                    <asp:BoundField DataField="IdCarguePagosFacturaSiif" HeaderText="IdError" InsertVisible="False" ReadOnly="True" SortExpression="IdCarguePagosFacturaSiif" />
                    <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                    <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                    <asp:BoundField DataField="NumeroFactura" HeaderText="Factura" SortExpression="NumeroFactura" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="FechaRegistro" HeaderText="FechaRegistro" SortExpression="FechaRegistro" />
                    <asp:BoundField DataField="CentroPci" HeaderText="CentroPci" SortExpression="CentroPci" />
                    <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                    <asp:BoundField DataField="ValorPago" HeaderText="ValorPago" SortExpression="ValorPago" DataFormatString="{0:N0}" >
                    <HeaderStyle HorizontalAlign="Right" />
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="NumeroCuponPago" HeaderText="CuponPago" SortExpression="NumeroCuponPago" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Duplicado" HeaderText="Duplicado" SortExpression="Duplicado" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
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
            <asp:GridView ID="grvRegistrosErrados0" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsErrorCargue" GridLines="Vertical" AutoGenerateColumns="False" DataKeyNames="IdCarguePagosFacturaSiif" Visible="False">
                <AlternatingRowStyle BackColor="#DCDCDC" />
                <Columns>
                    <asp:BoundField DataField="IdCarguePagosFacturaSiif" HeaderText="IdError" InsertVisible="False" ReadOnly="True" SortExpression="IdCarguePagosFacturaSiif" />
                    <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                    <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                    <asp:BoundField DataField="NumeroFactura" HeaderText="NumeroFactura" SortExpression="NumeroFactura" />
                    <asp:BoundField DataField="FechaRegistro" HeaderText="FechaRegistro" SortExpression="FechaRegistro" />
                    <asp:BoundField DataField="CentroPci" HeaderText="CentroPci" SortExpression="CentroPci" />
                    <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                    <asp:BoundField DataField="ValorPago" HeaderText="ValorPago" SortExpression="ValorPago" />
                    <asp:BoundField DataField="NumeroCuponPago" HeaderText="NumeroCuponPago" SortExpression="NumeroCuponPago" />
                    <asp:BoundField DataField="Duplicado" HeaderText="Duplicado" SortExpression="Duplicado" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
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
        </td>
    </tr>
    </table>
    <table class="auto-style9">
    <tr>
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
    </table>
    <table class="auto-style8">
    <tr>
        <td>
            <asp:SqlDataSource ID="SdsErrorCargue" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_ProcesarCuponPagoSiif_Error]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </td>
        <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
    </tr>
</table>
</asp:Content>
