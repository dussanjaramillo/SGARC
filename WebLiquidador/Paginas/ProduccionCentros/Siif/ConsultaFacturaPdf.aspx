<%@ Page Title="Factura Electrónica" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ConsultaFacturaPdf.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Siif.ConsultaFacturaPdf" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style12">
        <tr>
            <td><h2>Factura Electrónica Siif Nación:&nbsp;
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2></td>
        </tr>
        </table>
    <table class="auto-style12">
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SdsFacturaPdf" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderWidth="1px" CellPadding="3" DataKeyNames="Id" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="1096px" BorderStyle="None" PageSize="20">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" >
                        </asp:BoundField>
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" SortExpression="Codigo" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="NumeroFactura" SortExpression="NumeroFactura" />
                        <asp:BoundField DataField="NombreArchivo" HeaderText="NombreArchivo" SortExpression="NombreArchivo" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" ForeColor="White" Font-Bold="True" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
            </td>
        </tr>
        </table>
<table class="auto-style11">
        <tr>
            <td class="auto-style10">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>
                <asp:HyperLink ID="HyperLink1" runat="server" CssClass="auto-style9" target="_blank" Visible="False">[HyperLink1]</asp:HyperLink>
            </td>
        </tr>
        </table>
<table class="auto-style8">
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsFacturaPdf" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaElectronicaSiif]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:TextBox ID="txtNombreArchivo" runat="server" Visible="False"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
