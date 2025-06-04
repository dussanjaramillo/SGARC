<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="CentrosSinCatalogo.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Catalogo.CentrosSinCatalogo" %>

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
            <td>
                <h2>Centros Sin Catálogo de Productos</h2>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grvCentrosSinCatalogo" runat="server" AllowPaging="True" AllowSorting="True" DataSourceID="SdsCentrosSinCatalogo" AutoGenerateColumns="False" PageSize="20">
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Centro Formación" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Subdirector" SortExpression="Nombre" />
                        <asp:BoundField DataField="Correo" HeaderText="Correo" ReadOnly="True" SortExpression="Correo" />
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
                <asp:SqlDataSource ID="SdsCentrosSinCatalogo" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCentrosSinCatalogo]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
        </tr>
        </table>
</asp:Content>
