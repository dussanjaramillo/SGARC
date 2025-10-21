<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ControlPresupuesto.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Presupuesto.ControlPresupuesto" %>

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
            <td colspan="8"><h2>Control Cargue Presupuesto</h2></td>
        </tr>
        <tr>
            <td class="auto-style9" colspan="8">
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SdsControlPresupuesto" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" PageSize="20">
                    <Columns>
                        <asp:BoundField DataField="NombreArchivo" HeaderText="Nombre Archivo" SortExpression="NombreArchivo" />
                        <asp:BoundField DataField="NumeroRegistros" HeaderText="Numero Registros" SortExpression="NumeroRegistros" />
                        <asp:BoundField DataField="FechaPresupuesto" HeaderText="Fecha Presupuesto" SortExpression="FechaPresupuesto" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Meta" HeaderText="Meta" SortExpression="Meta" DataFormatString="{0:N0}" />
                        <asp:BoundField DataField="FechaCrea" HeaderText="Fecha Creado" SortExpression="FechaCrea" />
                        <asp:BoundField DataField="Nombre" HeaderText="Usuario" SortExpression="Nombre" />
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
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsControlPresupuesto" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarControlPresupuesto_1]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
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
</asp:Content>
