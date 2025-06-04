<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ControlCargueCatalogo.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Siif.ControlCargueCatalogo" %>

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
            <td><h2>Cargue de Catalogo de Bienes Y Servicios - Siif Nación</h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style9">
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SdsControlCarguePagos" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" PageSize="20" DataKeyNames="Id">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" InsertVisible="False" ReadOnly="True" />
                        <asp:BoundField DataField="NombreArchivo" HeaderText="NombreArchivo" SortExpression="NombreArchivo" >
                        </asp:BoundField>
                        <asp:BoundField DataField="NumeroRegistros" HeaderText="Registros Archivo" SortExpression="NumeroRegistros" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NumeroRegistrosSena" HeaderText="Registros Sena" SortExpression="NumeroRegistrosSena" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaUsuarioCrea" HeaderText="FechaUsuarioCrea" SortExpression="FechaUsuarioCrea" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" >
                        </asp:BoundField>
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
                <asp:SqlDataSource ID="SdsControlCarguePagos" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarControlCargueCatalogoSiif]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
