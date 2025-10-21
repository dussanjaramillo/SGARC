<%@ Page Title="Ingresos Sin Prefactura" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="CorregirNumeroFactura.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Factura.CorregirNumeroFactura" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <script type="text/javascript">
        (function () {
            // Union of Chrome, Firefox, IE, Opera, and Safari console methods
            var methods = ["assert", "cd", "clear", "count", "countReset",
                "debug", "dir", "dirxml", "error", "exception", "group", "groupCollapsed",
                "groupEnd", "info", "log", "markTimeline", "profile", "profileEnd",
                "select", "table", "time", "timeEnd", "timeStamp", "timeline",
                "timelineEnd", "trace", "warn"];
            var length = methods.length;
            var console = (window.console = window.console || {});
            var method;
            var noop = function () { };
            while (length--) {
                method = methods[length];
                // define undefined methods as noops to prevent errors
                if (!console[method])
                    console[method] = noop;
            }
        })();
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table>
        <tr>
            <td>
                <h2>Ingresos sin Prefactura - Corregir el Número:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td>
                <asp:GridView ID="grvCupoPago" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdCuponPago" OnSelectedIndexChanged="grvCupoPago_SelectedIndexChanged" DataSourceID="SdsCuponPagoXIdCentro">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdCuponPago" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdCuponPago" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="PrimerNombre" HeaderText="PrimerNombre" SortExpression="PrimerNombre" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Prefactura" SortExpression="NumeroFactura">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorTotaldelPago" HeaderText="ValorTotal" SortExpression="ValorTotaldelPago" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="Nro. Cupón" SortExpression="NroInternodeTransaccion">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" SortExpression="Fecha" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Centro" HeaderText="Centro" SortExpression="Centro" />
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
    <table class="auto-style12">
        <tr>
            <td class="auto-style11">Número del Cupón<br />
                <asp:TextBox ID="txtNumeroCupon" runat="server" Width="170px" Enabled="False" Font-Bold="True" ForeColor="Maroon"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtNumeroCupon_FilteredTextBoxExtender" runat="server" BehaviorID="txtNumeroCupon_FilteredTextBoxExtender" TargetControlID="txtNumeroCupon" FilterType="Numbers" InvalidChars=",." />
            </td>
            <td class="auto-style10"># Prefactura<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ControlToValidate="txtNumeroFacturaNew" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="txtNumeroFacturaNew" runat="server" Width="170px" Enabled="False"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtNumeroFacturaNew_FilteredTextBoxExtender" runat="server" BehaviorID="txtNumeroFacturaNew_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=",." TargetControlID="txtNumeroFacturaNew" />
            </td>
            <td class="auto-style9">
                <br />
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" Enabled="False" Width="170px" />
            </td>
            <td class="auto-style9">
                <br />
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Enabled="False" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnGuardar_ConfirmButtonExtender" runat="server" BehaviorID="btnGuardar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnGuardar" />
            </td>
            <td class="auto-style9">
                <br />
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
    </table>
    <table class="auto-style8">
        <tr>
            <td colspan="4">
                <asp:GridView ID="grvValorFactura" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsBuscarValorFactura" GridLines="Vertical" AutoGenerateColumns="False" DataKeyNames="IdFactura" OnDataBound="grvValorFactura_DataBound" OnSelectedIndexChanged="grvValorFactura_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdFactura" HeaderText="IdFactura" InsertVisible="False" ReadOnly="True" SortExpression="IdFactura" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Prefactura" SortExpression="NumeroFactura" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="ValorFactura" DataFormatString="{0:N0}" HeaderText="ValorPreFactura" ReadOnly="True" SortExpression="ValorFactura">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" SortExpression="FechaCrea" />
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
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsCuponPagoXIdCentro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCuponPagoXIdCentroFormacion]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfIdCuponPago" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfCuponPago" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsBuscarValorFactura" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_BuscarValorFactura_]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                        <asp:ControlParameter ControlID="txtNumeroFacturaNew" Name="NumeroFactura" PropertyName="Text" Type="Int64" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfFacturaExiste" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfValorDocumento" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfValorCupon" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
