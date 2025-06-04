<%@ Page Title="Prefactura No Pagada" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="CuponPagoSinAsignar.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.CuponPagoSinAsignar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td>
                <h2>Buscar Cupón Pago Sin Asignar: Ultima fecha de Ejecución:
                    <asp:Label ID="lblFechaPagoSinAsignar" runat="server"></asp:Label>
                </h2>
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td class="auto-style9">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" Width="170px" ValidationGroup="btnBuscar" />
            </td>
            <td>
            <asp:Button ID="btn_Limpiar" runat="server" Text="Limpiar" Width="170px" OnClick="btn_Limpiar_Click" ToolTip="Limpia el Formulario" />
            </td>
            <td>
				<asp:Button ID="btnContinuar" runat="server" Enabled="False" Text="Continuar" ValidationGroup="btnContinuar" Width="170px" OnClick="btnContinuar_Click" />
			    <ajax:confirmbuttonextender ID="btnContinuar_ConfirmButtonExtender" runat="server" BehaviorID="btnContinuar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnContinuar" />
			</td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td class="auto-style9">
				<asp:GridView ID="grvCentroFormacion" runat="server" CellPadding="3" AutoGenerateColumns="False" DataKeyNames="IdCentroFormacion" BackColor="White" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Visible="False">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="IdCentroFormacion" HeaderText="IdCentroFormacion" InsertVisible="False" ReadOnly="True" SortExpression="IdCentroFormacion" />
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
			    <asp:GridView ID="grvCuponPagoSinAsignar" runat="server" AutoGenerateColumns="False" CellPadding="3" BackColor="White" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" PageSize="15" Font-Bold="True" ForeColor="Black">
                    <AlternatingRowStyle BackColor="Gainsboro" />
                    <Columns>
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" >
                        </asp:BoundField>
                        <asp:BoundField DataField="PrimerNombre" HeaderText="PrimerNombre" SortExpression="PrimerNombre" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="NúmeroPreFactura" SortExpression="NumeroFactura" >
                        <ItemStyle Font-Bold="True" ForeColor="Maroon" HorizontalAlign="Right" BackColor="#FFFFCC" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorTotaldelPago" HeaderText="Valor del Pago" SortExpression="ValorTotaldelPago">
                        <ControlStyle BorderStyle="Solid" />
                        <ItemStyle Font-Bold="True" ForeColor="Maroon" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="Cupón de Pago" SortExpression="NroInternodeTransaccion" />
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha de Pago" SortExpression="Fecha" />
                        <asp:BoundField DataField="Centro" HeaderText="Centro Formación" SortExpression="Centro" ReadOnly="True">
                        <ItemStyle Font-Bold="True" ForeColor="Maroon" />
                        </asp:BoundField>
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
            <td class="auto-style9">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>&nbsp;</td>
            <td>
			    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_BuscarUsuarioCentroFormacionCuponSinAsignar]" SelectCommandType="StoredProcedure">
                </asp:SqlDataSource>
			    </td>
            <td>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_BuscarCuponPagoSinAsignar]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
