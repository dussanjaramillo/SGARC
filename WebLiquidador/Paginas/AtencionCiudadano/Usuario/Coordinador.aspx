<%@ Page Title="Coordinador" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Coordinador.aspx.cs" Inherits="WebLiquidador.Paginas.AtencionCiudadano.Usuario.Coordinador" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td class="auto-style6">
                <h2>Coordinador - Recaudo y cartera</h2>
            </td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SdsCoordinador" PageSize="20">
                    <Columns>
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" SortExpression="Codigo" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="CodigoRegional" HeaderText="Codigo" SortExpression="CodigoRegional" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion" />
                        <asp:BoundField DataField="Telefonos" HeaderText="Telefonos" SortExpression="Telefonos" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
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
                <asp:SqlDataSource ID="SdsCoordinador" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarCoordinadores" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
