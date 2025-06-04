<%@ Page Title="Liberar Cupón de Pago y Anular Prefactura" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="AnularFacturaXNumero.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Factura.AnularFacturaXNumero" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td>
                <h2>Liberar Cupón de Pago y Anular Prefactura
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>Número Prefactura</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtNumeroFactura" runat="server" MaxLength="8" Width="170px"></asp:TextBox>
                <ajax:filteredtextboxextender ID="txtNumeroFactura_FilteredTextBoxExtender" runat="server" BehaviorID="txtNumeroFactura_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtNumeroFactura" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnEjecutar" runat="server" OnClick="btnEjecutar_Click" Text="Ejecutar" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnEjecutar_ConfirmButtonExtender" runat="server" ConfirmText="Usted está Seguro?" TargetControlID="btnEjecutar" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNumeroFactura" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnBuscar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style8"></td>
            <td class="auto-style8"></td>
            <td class="auto-style8">&nbsp;</td>
        </tr>
    </table>
    <table class="auto-style8">
        <tr>
            <td colspan="3">
                <asp:GridView ID="grvFacturaXCentro" runat="server" AutoGenerateColumns="False" DataSourceID="SdsNumeroFactura" class="grvGrilla" Caption="Prefactura" OnDataBound="grvFacturaXCentro_DataBound" OnSelectedIndexChanged="grvFacturaXCentro_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Nombre" SortExpression="NombreCentroFormacion" >
                        <ItemStyle Font-Bold="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Docum" SortExpression="NumeroFactura" >
                        <ItemStyle Font-Bold="True" ForeColor="Maroon" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion"></asp:BoundField>
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" ReadOnly="True" DataFormatString="{0:N0}" />
                        <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" SortExpression="FechaCrea" DataFormatString="{0:d}"></asp:BoundField>
                        <asp:BoundField DataField="Pagada" HeaderText="Pagada" SortExpression="Pagada">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="Cupón">
                        <ItemStyle Font-Bold="True" ForeColor="Maroon" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaEntidadFinanciera" DataFormatString="{0:d}" HeaderText="FechaCupón" />
                        <asp:BoundField DataField="Tc" HeaderText="Tc" SortExpression="Tc" />
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
                <asp:GridView ID="grvFacturaXProductos" runat="server" AutoGenerateColumns="False" DataSourceID="SdsFacturaProductos" class="grvGrilla" Caption="Productos" AllowPaging="True" AllowSorting="True">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="CodigoProducto" HeaderText="CodigoProducto" SortExpression="CodigoProducto" />
                        <asp:BoundField DataField="NombreProducto" HeaderText="NombreProducto" SortExpression="NombreProducto" />
                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" SortExpression="Cantidad" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Medida" HeaderText="Medida" SortExpression="Medida" />
                        <asp:BoundField DataField="Precio" HeaderText="Precio" SortExpression="Precio" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Valor" HeaderText="Valor" ReadOnly="True" SortExpression="Valor" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
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
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
        </tr>
    </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:HiddenField ID="hfNumeroCuponPago" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsFacturaProductos" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaProducto]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtNumeroFactura" Name="NumeroFactura" PropertyName="Text" Type="Int64" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsNumeroFactura" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaXNumeroFactura0]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtNumeroFactura" Name="NumeroFactura" PropertyName="Text" Type="Int64" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
