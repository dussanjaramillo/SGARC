<%@ Page Title="Estado Pagos Cartera Masivos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EstadoPagosCarteraMasivo.aspx.cs" Inherits="WebLiquidador.Paginas.DireccionGeneral.EstadoPagosCarteraMasivo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="8"><h2>Estado Pagos Cartera Masivos</h2></td>
        </tr>
        <tr>
            <td class="auto-style10">&nbsp;</td>
            <td class="auto-style14">Seleccione el Archivo</td>
            <td class="auto-style11">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15"></td>
            <td class="auto-style13" colspan="3">
                <asp:FileUpload ID="FuCargarArchivo" runat="server" accept="application/vnd.ms-excel" Width="481px"  />
            </td>
            <td class="auto-style13">
                </td>
            <td class="auto-style13"></td>
            <td class="auto-style13"></td>
            <td class="auto-style13"></td>
        </tr>
        <tr>
            <td class="auto-style10">&nbsp;</td>
            <td class="auto-style14">
                <asp:Button ID="btnCargarArchivo" runat="server" Text="Cargar Archivo" Width="170px" OnClick="btnCargarArchivo_Click" />
                <Ajax:ConfirmButtonExtender ID="btnCargarArchivo_ConfirmButtonExtender" runat="server" BehaviorID="btnCargarArchivo_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnCargarArchivo" />
            </td>
            <td class="auto-style11">
                <asp:Button ID="btnGenerar" runat="server" style="margin-left: 0px" Text="Generar" Width="170px" Enabled="False" OnClick="btnGenerar_Click" />
                <Ajax:ConfirmButtonExtender ID="btnGenerar_ConfirmButtonExtender" runat="server" BehaviorID="btnCalcular_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnGenerar" />
            </td>
            <td>
                <asp:Button ID="btnExportar" runat="server" Text="Exportar" Width="170px" Enabled="False" OnClick="btnExportar_Click" BackColor="#FF6600" />
                <Ajax:ConfirmButtonExtender ID="btnExportar_ConfirmButtonExtender" runat="server" BehaviorID="btnExportar_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnExportar" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" Width="170px" OnClick="btnLimpiar_Click" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style10">&nbsp;</td>
            <td>
                <asp:GridView ID="grvEstadoPagosCarteraLicitacion" runat="server" AutoGenerateColumns="False" DataSourceID="SdsEstadoPagosCarteraLicitacion" PageSize="15" style="margin-left: 0px" Visible="False">
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion" />
                        <asp:BoundField DataField="Municipio" HeaderText="Municipio" SortExpression="Municipio" />
                        <asp:BoundField DataField="Telefono" HeaderText="Telefono" SortExpression="Telefono" />
                        <asp:BoundField DataField="Correo" HeaderText="Correo" SortExpression="Correo" />
                        <asp:BoundField DataField="CedulaRepresentante" HeaderText="CedulaRepresentante" SortExpression="CedulaRepresentante" />
                        <asp:BoundField DataField="NombreRepresentante" HeaderText="NombreRepresentante" SortExpression="NombreRepresentante" />
                        <asp:BoundField DataField="Resolucion" HeaderText="Resolucion" SortExpression="Resolucion" />
                        <asp:BoundField DataField="NombreConcepto" HeaderText="Concepto" SortExpression="NombreConcepto" />
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" SortExpression="Fecha" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" />
                        <asp:BoundField DataField="Saldo" HeaderText="Saldo" SortExpression="Saldo" />
                        <asp:BoundField DataField="Estado" HeaderText="Estado" SortExpression="Estado" />
                        <asp:BoundField DataField="NOMINSTANCIA" HeaderText="Instancia" SortExpression="NOMINSTANCIA" />
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#FF9536" Font-Bold="True" ForeColor="Black" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
            </td>
            <td>&nbsp;</td>
        </tr>
        </table>
<table class="auto-style6">
        <tr>
            <td class="auto-style7">
                <asp:SqlDataSource ID="SdsEstadoPagosCarteraLicitacion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarEstadoPagosCarteraLicitacion" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td class="auto-style8">
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
