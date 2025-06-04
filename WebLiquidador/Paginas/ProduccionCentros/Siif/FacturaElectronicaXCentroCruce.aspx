<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="FacturaElectronicaXCentroCruce.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Siif.FacturaElectronicaXCentroCruce" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td><h2>Corregir el Número de Cupón de pago en la Factura Electrónica Siif - Nación:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2></td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grvFacturaElectronica" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsFacturaElectronica" GridLines="Vertical" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="IdPagosFacturaSiif" OnSelectedIndexChanged="grvFacturaElectronica_SelectedIndexChanged" OnDataBound="grvFacturaElectronica_DataBound">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdPagosFacturaSiif" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdPagosFacturaSiif" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="NumeroFactura" SortExpression="NumeroFactura" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaRegistro" HeaderText="FechaRegistro" SortExpression="FechaRegistro" />
                        <asp:BoundField DataField="CentroPci" HeaderText="CentroPci" SortExpression="CentroPci" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="ValorPago" HeaderText="ValorPago" SortExpression="ValorPago" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NumeroCuponPago" HeaderText="NumeroCuponPago" SortExpression="NumeroCuponPago" >
                        <HeaderStyle HorizontalAlign="Right" />
                        <ItemStyle HorizontalAlign="Right" />
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
            <td>
                Número del Cupón de Pago</td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ControlToValidate="txtNumeroCupon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style9">
                &nbsp;</td>
            <td class="auto-style9">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtNumeroCupon" PlaceHolder="Numero de Cupón (8)" runat="server" Width="170px" Enabled="False" Font-Bold="True" ForeColor="Maroon" MaxLength="8"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtNumeroCupon_FilteredTextBoxExtender" runat="server" BehaviorID="txtNumeroCupon_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtNumeroCupon" />
            </td>
            <td>
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnGuardar" Width="170px" Enabled="False" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnGuardar_ConfirmButtonExtender" runat="server" BehaviorID="btnGuardar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnGuardar" />
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td colspan="4">
                <asp:GridView ID="grvCuponPago" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsCuponPago" AutoGenerateColumns="False" DataKeyNames="IdCuponPago" OnSelectedIndexChanged="grvCuponPago_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdCuponPago" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdCuponPago" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="PrimerNombre" HeaderText="PrimerNombre" SortExpression="PrimerNombre" />
                        <asp:BoundField DataField="Centro" HeaderText="Centro" SortExpression="Centro" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Prefactura" SortExpression="NumeroFactura" />
                        <asp:BoundField DataField="ValorTotaldelPago" HeaderText="ValorPago" SortExpression="ValorTotaldelPago" />
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="CuponPago" SortExpression="NroInternodeTransaccion" />
                        <asp:BoundField DataField="FechaEntidadFinanciera" DataFormatString="{0:d}" HeaderText="Fecha" SortExpression="FechaEntidadFinanciera" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
                        <asp:BoundField DataField="Asignado" HeaderText="Asignado" ReadOnly="True" SortExpression="Asignado" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <SortedAscendingCellStyle BackColor="#F4F4FD" />
                    <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                    <SortedDescendingCellStyle BackColor="#D8D8F0" />
                    <SortedDescendingHeaderStyle BackColor="#3E3277" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hfValorPagoSiif" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfValorPagoSnpc" runat="server" />
            </td>
            <td class="auto-style9">
                <asp:HiddenField ID="hfCentroCuponPago" runat="server" />
            </td>
            <td class="auto-style9">
                <asp:HiddenField ID="hfIdCuponPago" runat="server" />
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsFacturaElectronica" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaElectronicaXCentroSiif_Cruce]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="CodigoCentroFormacion" SessionField="_CodigoCentroFormacion" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfIdPagosFacturaSiif" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsCuponPago" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_BuscarCuponPago_Siif]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtNumeroCupon" Name="NroInternodeTransaccion" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
        </tr>
        </table>
</asp:Content>
