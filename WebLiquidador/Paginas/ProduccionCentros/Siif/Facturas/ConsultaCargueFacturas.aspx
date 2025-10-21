<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ConsultaCargueFacturas.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Siif.Facturas.ConsultaCargueFacturas" %>

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
            <td><h2>Consulta Cargue Facturas
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style9">
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SdsControlCargueArchivo" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" PageSize="15" Width="663px" DataKeyNames="Id">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                        <asp:BoundField DataField="NombreArchivo" HeaderText="NombreArchivo" SortExpression="NombreArchivo" />
                        <asp:BoundField DataField="Registros" HeaderText="Registros" SortExpression="Registros" />
                        <asp:BoundField DataField="ValorTotal" HeaderText="ValorTotal" SortExpression="ValorTotal" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaMinima" HeaderText="FechaMinima" SortExpression="FechaMinima" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="FechaMaxima" HeaderText="FechaMaxima" SortExpression="FechaMaxima" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="CodigoCentro" HeaderText="Centro" SortExpression="CodigoCentro" />
                        <asp:BoundField DataField="TipoFactura" HeaderText="TipoFactura" SortExpression="TipoFactura" />
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
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsControlCargueArchivo" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarControlFacturaElectronicaSiifXCentro]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
