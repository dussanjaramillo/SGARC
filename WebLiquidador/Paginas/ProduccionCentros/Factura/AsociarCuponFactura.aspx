<%@ Page Title="Asociar Cupón de Pago a la Prefactura" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="AsociarCuponFactura.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Factura.AsociarCuponFactura" %>

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

    <style type="text/css">
        .auto-style8 {
            height: 21px;
        }
        .auto-style9 {
            width: 11px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td>
                <h2>Asociar Cupón de Pago a la Prefactura:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grvFacturaXCentro" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SdsFacturasXCentro" OnDataBound="grvFacturaXCentro_DataBound" class="grvGrilla" Caption="Seleccione el Número de la Prefactura" OnSelectedIndexChanged="grvFacturaXCentro_SelectedIndexChanged" Width="782px" OnPageIndexChanged="grvFacturaXCentro_PageIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Prefactura" SortExpression="NumeroFactura" ReadOnly="True" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" ReadOnly="True" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" ReadOnly="True" SortExpression="Nombre" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" ReadOnly="True" SortExpression="Valor" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" SortExpression="FechaCrea" ReadOnly="True" DataFormatString="{0:d}" />
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#4b6c9e" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#FFFFCC" Font-Bold="True" ForeColor="Black" />
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
                <strong>Valor Seleccionado</strong></td>
            <td>
                <asp:TextBox ID="txtValorSeleccionado" runat="server" BackColor="#FFFFCC" Enabled="False" Font-Bold="True" ForeColor="Maroon" Width="170px"></asp:TextBox>
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:GridView ID="grvCupones" runat="server" AutoGenerateColumns="False" class="grvGrilla" AllowPaging="True" OnPageIndexChanged="grvCupones_PageIndexChanged" OnPageIndexChanging="grvCupones_PageIndexChanging" Width="784px">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox1_CheckedChanged" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="IdCuponPago" HeaderText="Id" SortExpression="IdCuponPago" InsertVisible="False" ReadOnly="True" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="PrimerNombre" HeaderText="PrimerNombre" SortExpression="PrimerNombre" />
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="Nro Interno" SortExpression="NroInternodeTransaccion" />
                        <asp:BoundField DataField="Documento" HeaderText="Prefactura" SortExpression="Documento" />
                        <asp:BoundField DataField="ValorPago" HeaderText="Valor Pago" SortExpression="ValorPago" DataFormatString="{0:N0}">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaPago" HeaderText="Fecha Pago" SortExpression="FechaPago" DataFormatString="{0:d}" />
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#465767" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="False" ForeColor="White" />
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
            <td class="auto-style8">
                <asp:Panel ID="Panel2" runat="server" Font-Bold="True" Visible="False">
                    Seleccione el(los) Número(s) de (los) Cupón(es) a asociar a la Prefactura, Recuerde los valores Seleccionados deben ser Iguales a el Valor de la Prefactura
                </asp:Panel>
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td class="auto-style11">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnAsociarCupon" runat="server" Font-Bold="True" OnClick="btnAsociarCupon_Click" Text="Asociar Cupón" Visible="False" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnAsociarCupon_ConfirmButtonExtender" runat="server" BehaviorID="btnAsociarCupon_ConfirmButtonExtender" ConfirmText="Esta Seguro?" TargetControlID="btnAsociarCupon" />
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td style="font-weight: 700">
                <asp:SqlDataSource ID="SdsCuponPagoXCentro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCuponPagoXCentroXAsignar]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                        <asp:ControlParameter ControlID="hfFechaFactura" DbType="Date" Name="FechaEntidadFinanciera" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsFacturasXCentro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaNoAsociadaXCentro]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfFechaCrea" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfValorTotaldelPagoAsociado" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hfNumeroFactura" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfCuponPago" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfValorCuponPago" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfValorFactura" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfCantidad" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hfFechaCuponPago" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfFechaFactura" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfIdCuponPago" runat="server" />
            </td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
