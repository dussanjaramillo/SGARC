<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MantenimientoSgarc.aspx.cs" Inherits="WebLiquidador.Paginas.AtencionCiudadano.MantenimientoSgarc" %>
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
            <td><h2>Mantenimiento de los Aplicativos</h2></td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="gvrMantenimiento" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataSourceID="SqlMantenimientoApp" ForeColor="Black">
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    <Columns>
                        <asp:CommandField ShowEditButton="True" />
                        <asp:CheckBoxField DataField="Sgarc" HeaderText="Atención" SortExpression="Sgarc" >
                        </asp:CheckBoxField>
                        <asp:CheckBoxField DataField="SgPc" HeaderText="Producción" SortExpression="SgPc" >
                        </asp:CheckBoxField>
                        <asp:CheckBoxField DataField="SgIn" HeaderText="Inmuebles" SortExpression="SgIn" >
                        </asp:CheckBoxField>
                    </Columns>
                    <FooterStyle BackColor="Tan" />
                    <HeaderStyle BackColor="Tan" Font-Bold="True" />
                    <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                    <SortedAscendingCellStyle BackColor="#FAFAE7" />
                    <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                    <SortedDescendingCellStyle BackColor="#E1DB9C" />
                    <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SqlMantenimientoApp" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarMantenimientoApp" SelectCommandType="StoredProcedure" UpdateCommand="Usp_MantenimientoAppUpdate" UpdateCommandType="StoredProcedure">
                    <UpdateParameters>
                        <asp:Parameter Name="Sgarc" Type="Boolean" />
                        <asp:Parameter Name="SgPc" Type="Boolean" />
                        <asp:Parameter Name="SgIn" Type="Boolean" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
