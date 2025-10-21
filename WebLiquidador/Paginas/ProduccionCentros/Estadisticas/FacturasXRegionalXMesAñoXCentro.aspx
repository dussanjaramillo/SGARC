<%@ Page Title="Prefacturas X Regional" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="FacturasXRegionalXMesAñoXCentro.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Estadisticas.FacturasXRegionalXMesAñoXCentro" %>
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
            <td colspan="8"><h2>Prefacturas Por Regional Por Mes y Año:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2></td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        </table>
<table class="auto-style8">
        <tr>
            <td>
                <asp:GridView ID="grvFacturasXRegionalXMesAñoXCentro" runat="server" AutoGenerateColumns="False" DataSourceID="SdsFacturasXRegionalXMesAñoXCentro" class="grvGrilla" AllowPaging="True" PageSize="15" AllowSorting="True">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="Mes-Año" HeaderText="Mes-Año" ReadOnly="True" SortExpression="Mes-Año" />
                        <asp:BoundField DataField="NroFacturas" HeaderText="Prefactura" ReadOnly="True" SortExpression="NroFacturas">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Pagada" HeaderText="Pagada" SortExpression="Pagada">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
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
                <asp:GridView ID="grvFacturasXRegionalXMesAñoXCentro0" runat="server" AutoGenerateColumns="False" DataSourceID="SdsFacturasXRegionalXMesAñoXCentro" class="grvGrilla" PageSize="15" Visible="False">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="Mes-Año" HeaderText="Mes-Año" ReadOnly="True" SortExpression="Mes-Año" />
                        <asp:BoundField DataField="NroFacturas" HeaderText="Prefactura" ReadOnly="True" SortExpression="NroFacturas" />
                        <asp:BoundField DataField="Pagada" HeaderText="Pagada" SortExpression="Pagada">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
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
        </table>
<table class="auto-style8">
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsFacturasXRegionalXMesAñoXCentro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturasXRegionalXMesAñoXCentro]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
