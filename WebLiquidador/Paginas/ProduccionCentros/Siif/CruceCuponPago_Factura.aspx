<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="CruceCuponPago_Factura.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Siif.CruceCuponPago_Factura" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td><h2><span style="color: rgb(0, 0, 0); font-family: &quot;Helvetica Neue&quot;, &quot;Lucida Grande&quot;, &quot;Segoe UI&quot;, Arial, Helvetica, Verdana, sans-serif; font-size: 20.48px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Cupón de Pago No Asociado al Documento Equivalente</span>:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                &nbsp;
                </h2>
                </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:GridView ID="grvIngresosXCentro" runat="server" AutoGenerateColumns="False" PageSize="15" Width="839px" class="grvGrilla" DataSourceID="SdsCuponNoAsociado" AllowPaging="True" AllowSorting="True" OnDataBound="grvIngresosXCentro_DataBound" OnSelectedIndexChanged="grvIngresosXCentro_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdCuponPago" HeaderText="Id" SortExpression="IdCuponPago" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Documento Equivalente" SortExpression="NumeroFactura">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorTotaldelPago" DataFormatString="{0:N0}" HeaderText="Valor Pagado" SortExpression="ValorTotaldelPago">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="Cupón de Pago" SortExpression="NroInternodeTransaccion">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaEntidadFinanciera" DataFormatString="{0:d}" HeaderText="Fecha Pago" SortExpression="FechaEntidadFinanciera">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion">
                        </asp:BoundField>
                        <asp:BoundField DataField="PrimerNombre" HeaderText="PrimerNombre" SortExpression="PrimerNombre">
                        </asp:BoundField>
                        <asp:BoundField DataField="PrimerApellido" HeaderText="PrimerApellido" SortExpression="PrimerApellido">
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
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td colspan="2">
                Número Documento Equivalente<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ControlToValidate="txtNumeroFacturaNew" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtNumeroFacturaNew" runat="server" Width="170px" Enabled="False"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtNumeroFacturaNew_FilteredTextBoxExtender" runat="server" BehaviorID="txtNumeroFacturaNew_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=",." TargetControlID="txtNumeroFacturaNew" />
            </td>
            <td>
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnGuardar_ConfirmButtonExtender" runat="server" BehaviorID="btnGuardar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnGuardar" />
            </td>
            <td>
            <asp:Button ID="btn_Limpiar" runat="server" Text="Limpiar" Width="170px" OnClick="btn_Limpiar_Click" ToolTip="Limpia el Formulario" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsCuponNoAsociado" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_BuscarIngresosXCentro_Cruce]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfIdCuponPago" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfFacturaExiste" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
