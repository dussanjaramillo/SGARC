<%@ Page Title="Mantenimiento de los Aplicativos" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="MantenimientoCf.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.MantenimientoCf" %>
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
                <asp:GridView ID="gvrMantenimiento" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlMantenimientoApp" ForeColor="#333333">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:CommandField ShowEditButton="True" />
                        <asp:CheckBoxField DataField="Sgarc" HeaderText="Atención" SortExpression="Sgarc" >
                        </asp:CheckBoxField>
                        <asp:CheckBoxField DataField="SgPc" HeaderText="Producción" SortExpression="SgPc" >
                        </asp:CheckBoxField>
                        <asp:CheckBoxField DataField="SgIn" HeaderText="Costas" SortExpression="SgIn" >
                        </asp:CheckBoxField>
                    </Columns>
                    <EditRowStyle BackColor="#EFF3FB" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
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
