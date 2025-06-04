<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="AsignacionFacturaPagoAnticipado.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.AsignacionFacturaPagoAnticipado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="6">
                <h2>Asignación de Facturas al Cupón de Pago Anticipado</h2>
            </td>
        </tr>
        <tr>
            <td>Cupón de Pago Anticipado</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>
                <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Maroon" Text="Valor Facturas Asignadas:" Visible="False"></asp:Label>
            </td>
            <td>
                <asp:Label ID="Label2" runat="server" Font-Bold="True" ForeColor="Maroon" Text="Saldo del Cupón:" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtCuponPago" runat="server" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtCuponPago_FilteredTextBoxExtender" runat="server" BehaviorID="txtCuponPago_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=",." TargetControlID="txtCuponPago" />
            </td>
            <td>
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" OnClick="btnBuscar_Click" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" Width="170px" OnClick="btnLimpiar_Click" />
            </td>
            <td>&nbsp;</td>
            <td>
                <asp:TextBox ID="txtValorFactura" runat="server" BackColor="#FFFF99" Enabled="False" Font-Bold="True" ForeColor="Maroon" CssClass="alineacionDerecha" Font-Size="Medium" Width="170px" Visible="False"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtSaldo" runat="server" BackColor="#FFFF99" Enabled="False" Font-Bold="True" ForeColor="Maroon" CssClass="alineacionDerecha" Font-Size="Medium" Width="170px" Visible="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnBuscar" ControlToValidate="txtCuponPago"></asp:RequiredFieldValidator>
            </td>
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
                <asp:GridView ID="grvCuponPago" runat="server" DataSourceID="SdsCuponPago" class="grvGrilla" AutoGenerateColumns="False" DataKeyNames="IdCuponPago" OnSelectedIndexChanged="grvCuponPago_SelectedIndexChanged" OnDataBound="grvCuponPago_DataBound" Caption="Cupón de Pago" Width="788px">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdCuponPago" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdCuponPago" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Factura" SortExpression="NumeroFactura">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorTotaldelPago" HeaderText="Valor del Pago" SortExpression="ValorTotaldelPago">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="Número Cupón" SortExpression="NroInternodeTransaccion">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaEntidadFinanciera" DataFormatString="{0:d}" HeaderText="FechaPago" SortExpression="FechaEntidadFinanciera" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:CheckBoxField>
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
                <asp:GridView ID="grvFacturasAsignadas" runat="server" class="grvGrilla" AutoGenerateColumns="False" Caption="Facturas Asignadas" OnDataBound="grvFacturasAsignadas_DataBound" AllowPaging="True" AllowSorting="True" OnSelectedIndexChanged="grvFacturasAsignadas_SelectedIndexChanged" PageSize="5" Width="788px" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdPagosAnticipados" HeaderText="Id" SortExpression="IdPagosAnticipados" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Factura" SortExpression="NumeroFactura" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="ValorFactura" HeaderText="ValorFactura" ReadOnly="True" SortExpression="ValorFactura">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Pagada" HeaderText="Pagada" SortExpression="Pagada" >

                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

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
            <td>&nbsp;</td>
        </tr>
    </table>
    <table class="auto-style8">
        <tr>
            <td colspan="2">
                <asp:Button ID="btnEliminar" runat="server" OnClick="btnEliminar_Click" Text="- Eliminar" ValidationGroup="btnEliminar" Width="170px" Visible="False" />
                <Ajax:ConfirmButtonExtender ID="btnEliminar_ConfirmButtonExtender" runat="server" BehaviorID="btnEliminar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnEliminar" />
                <asp:Button ID="btnCancelar" runat="server" OnClick="btnCancelar_Click" Text="Cancelar" ValidationGroup="btnCancelar" Width="170px" Visible="False" />
            </td>
            <td colspan="3">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" colspan="7">
                <asp:GridView ID="grvFacturasCentro" runat="server" class="grvGrilla" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" Caption="Facturas Disponibles" Visible="False" PageSize="5" OnSelectedIndexChanged="grvFacturasCentro_SelectedIndexChanged" Width="788px" CellPadding="4" ForeColor="#333333">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdFactura" HeaderText="Id" SortExpression="IdFactura" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Factura" SortExpression="NumeroFactura" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" ReadOnly="True" SortExpression="Valor">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaCrea" DataFormatString="{0:d}" HeaderText="FechaCrea" SortExpression="FechaCrea" />
                        <asp:BoundField DataField="Pagada" HeaderText="Pagada" SortExpression="Pagada">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#465767" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnAgregar" runat="server" OnClick="btnAgregar_Click" Text="+ Agregar" ValidationGroup="btnAgregar" Width="170px" Visible="False" />
                <Ajax:ConfirmButtonExtender ID="btnAgregar_ConfirmButtonExtender" runat="server" BehaviorID="btnAgregar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnAgregar" />
                <asp:Button ID="btnCancelar0" runat="server" OnClick="btnCancelar0_Click" Text="Cancelar" ValidationGroup="btnCancelar" Width="170px" Visible="False" />
            </td>
            <td colspan="2">&nbsp;</td>
            <td>&nbsp;</td>
            <td class="auto-style8" colspan="3">&nbsp;</td>
        </tr>
    </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsCuponPago" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCuponPagoXCentroXNroInternodeTransaccion]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                        <asp:ControlParameter ControlID="txtCuponPago" Name="NroInternodeTransaccion" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfIdCuponPago" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsFacturasAsignadas" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaDelPagoAnticipado]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfIdCuponPago" Name="IdCuponPago" PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="auto-style8">
                <asp:HiddenField ID="hfValorCupon" runat="server" />
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsFacturaNoAsociadaXCentro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaNoAsociadaXCentro]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hfIdPagosAnticipados" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfIdFactura" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfValorFactura" runat="server" />
            </td>
            <td class="auto-style8">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
