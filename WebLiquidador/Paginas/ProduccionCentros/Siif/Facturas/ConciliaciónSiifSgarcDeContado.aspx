<%@ Page Title="Conciliación Siif - Sgarc De Contado" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ConciliaciónSiifSgarcDeContado.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Siif.Facturas.ConciliaciónSiifSgarcDeContado" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style12">
        <tr>
            <td><h2>Conciliación Siif - Sgarc De Contado:&nbsp;
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2></td>
        </tr>
        </table>
    <table class="auto-style12">
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SdsFacturaElectronicas" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderWidth="1px" CellPadding="3" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="1096px" BorderStyle="None" PageSize="15">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" />
                        <asp:BoundField DataField="CodigoCentro" HeaderText="Centro" SortExpression="CodigoCentro" >
                        </asp:BoundField>
                        <asp:BoundField DataField="FacturaElectronica" HeaderText="Factura" SortExpression="FacturaElectronica" />
                        <asp:BoundField DataField="FechaFacturacion" HeaderText="FechaFacturacion" SortExpression="FechaFacturacion" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="FechaCuponPago" HeaderText="FechaCupon" SortExpression="FechaCuponPago" DataFormatString="{0:d}" >
                        <ItemStyle BackColor="#CCCCCC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorVenta" HeaderText="ValorVenta" SortExpression="ValorVenta" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Diferencia" DataFormatString="{0:N0}" HeaderText="Diferencia" SortExpression="Diferencia">
                        <ItemStyle HorizontalAlign="Right" BackColor="#FFFFCC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorCupon" DataFormatString="{0:N0}" HeaderText="ValorCupon" SortExpression="ValorCupon">
                        <ItemStyle HorizontalAlign="Right" BackColor="#CCCCCC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Prefactura" HeaderText="Prefactura" SortExpression="Prefactura" >
                        <ItemStyle BackColor="#CCCCCC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CuponPago" HeaderText="CuponPago" SortExpression="CuponPago" >
                        <ItemStyle BackColor="#CCCCCC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Consignacion" HeaderText="Consignacion" SortExpression="Consignacion" />
                        <asp:BoundField DataField="UsuarioSiif" HeaderText="UsuarioSiif" SortExpression="UsuarioSiif" />
                        <asp:BoundField DataField="TipoFactura" HeaderText="TipoFactura" SortExpression="TipoFactura" />
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
                <br />
                <asp:GridView ID="GridView2" runat="server" DataSourceID="SdsFacturaElectronicas" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderWidth="1px" CellPadding="3" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="1096px" BorderStyle="None" PageSize="15" Visible="False">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" />
                        <asp:BoundField DataField="CodigoCentro" HeaderText="Centro" SortExpression="CodigoCentro" >
                        </asp:BoundField>
                        <asp:BoundField DataField="FacturaElectronica" HeaderText="Factura" SortExpression="FacturaElectronica" />
                        <asp:BoundField DataField="FechaFacturacion" HeaderText="FechaFacturacion" SortExpression="FechaFacturacion" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="FechaCuponPago" HeaderText="FechaCupon" SortExpression="FechaCuponPago" DataFormatString="{0:d}" >
                        <ItemStyle BackColor="#CCCCCC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorVenta" HeaderText="ValorVenta" SortExpression="ValorVenta" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Diferencia" HeaderText="Diferencia" SortExpression="Diferencia">
                        <ItemStyle HorizontalAlign="Right" BackColor="#FFFFCC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorCupon" HeaderText="ValorCupon" SortExpression="ValorCupon">
                        <ItemStyle HorizontalAlign="Right" BackColor="#CCCCCC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Prefactura" HeaderText="Prefactura" SortExpression="Prefactura" >
                        <ItemStyle BackColor="#CCCCCC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CuponPago" HeaderText="CuponPago" SortExpression="CuponPago" >
                        <ItemStyle BackColor="#CCCCCC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Consignacion" HeaderText="Consignacion" SortExpression="Consignacion" />
                        <asp:BoundField DataField="UsuarioSiif" HeaderText="UsuarioSiif" SortExpression="UsuarioSiif" />
                        <asp:BoundField DataField="TipoFactura" HeaderText="TipoFactura" SortExpression="TipoFactura" />
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
                <br />
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>
                Consignación
                <br />
                <asp:TextBox ID="txtConsignacion" runat="server" Enabled="False" MaxLength="11"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtConsignacion_FilteredTextBoxExtender" runat="server" BehaviorID="txtConsignacion_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtConsignacion" />
            </td>
            <td>
                Guardar<br />
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" Width="170px" Enabled="False" ValidationGroup="btnGuardar" />
                <Ajax:ConfirmButtonExtender ID="btnGuardar_ConfirmButtonExtender" runat="server" BehaviorID="btnGuardar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnGuardar" />
            </td>
            <td>
                <br />
                <asp:DropDownList ID="ddlTipoArchivo" runat="server" Width="170px">
                    <asp:ListItem Value="2" Selected="True">Excel</asp:ListItem>
                    <asp:ListItem Value="1">Txt</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <br />
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
            </td>
        </tr>
        </table>
<table class="auto-style8">
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsFacturaElectronicas" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaElectronicaSiifXTipoFacturaXCentro]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfId" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
