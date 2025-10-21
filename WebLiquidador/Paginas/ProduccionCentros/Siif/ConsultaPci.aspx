<%@ Page Title="Posición de Catálogo Institucional (Pci) - Siif Nación" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ConsultaPci.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Siif.ConsultaPci" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            width: 100%;
        }
        .auto-style10 {
            width: 428px;
        }
        .auto-style11 {
            width: 689px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td><h2>Posición de Catálogo Institucional (Pci) - Siif Nación</h2></td>
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
                <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SqlBuscarPci" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" PageSize="15">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="Pci" HeaderText="Pci" ReadOnly="True" SortExpression="Pci" />
                        <asp:BoundField DataField="Descripción" HeaderText="Descripción" ReadOnly="True" SortExpression="Descripción" />
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
                <asp:GridView ID="GridView2" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SqlBuscarPci" AutoGenerateColumns="False" PageSize="20" Visible="False">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="Pci" HeaderText="Pci" ReadOnly="True" SortExpression="Pci" />
                        <asp:BoundField DataField="Descripción" HeaderText="Descripción" ReadOnly="True" SortExpression="Descripción" />
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
    <table class="auto-style8">
        <tr>
            <td>
                <asp:DropDownList ID="ddlTipoArchivo" runat="server" Width="170px">
                    <asp:ListItem Value="2" Selected="True">Excel</asp:ListItem>
                    <asp:ListItem Value="1">Txt</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="auto-style11">
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
            </td>
            <td class="auto-style10">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SqlBuscarPci" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[Siif].[Usp_BuscarPci]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td class="auto-style11">
                &nbsp;</td>
            <td class="auto-style10">
                &nbsp;</td>
        </tr>
        </table>
</asp:Content>
