<%@ Page Title="Imprimir Factura Electrónica" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ImprimirFacturaElectronica.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Siif.ImprimirFacturaElectronica" %>

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
            width: 100%;
        }

        .auto-style9 {
            width: 32%;
        }

        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td>
                <h2>Factura Electrónica Procesadas - Siif Nación:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grvFacturaXCentro" runat="server" AutoGenerateColumns="False" DataSourceID="SdsFacturasXCentro" OnDataBound="grvFacturaXCentro_DataBound" class="grvGrilla" AllowPaging="True" PageSize="15" AllowSorting="True" OnSelectedIndexChanged="grvFacturaXCentro_SelectedIndexChanged" DataKeyNames="IdPagosFacturaSiif">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdPagosFacturaSiif" HeaderText="Id" SortExpression="IdPagosFacturaSiif" InsertVisible="False" ReadOnly="True" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Centro" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Factura" SortExpression="NumeroFactura" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaRegistro" HeaderText="Fecha Registro" SortExpression="FechaRegistro" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorPago" HeaderText="ValorPago" SortExpression="ValorPago" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NumeroCuponPago" HeaderText="CuponPago" SortExpression="NumeroCuponPago" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Documento" HeaderText="Prefactura" SortExpression="Documento" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Nombre" HeaderText="ModificadoPor" SortExpression="Nombre" />
                        <asp:BoundField DataField="FechaModifica" HeaderText="FechaModifica" SortExpression="FechaModifica" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#4b6c9e" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
                <asp:GridView ID="grvFacturaXCentro0" runat="server" AutoGenerateColumns="False" DataSourceID="SdsFacturasXCentro" class="grvGrilla" Caption="Factura Electrónica Procesadas - Siif Nación" PageSize="15" Visible="False" DataKeyNames="IdPagosFacturaSiif">
                    <Columns>
                        <asp:BoundField DataField="IdPagosFacturaSiif" HeaderText="IdPagosFacturaSiif" SortExpression="IdPagosFacturaSiif" InsertVisible="False" ReadOnly="True" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="NombreRegional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="NombreCentroFormacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="NumeroFactura" SortExpression="NumeroFactura" />
                        <asp:BoundField DataField="FechaRegistro" HeaderText="FechaRegistro" SortExpression="FechaRegistro" />
                        <asp:BoundField DataField="CentroPci" HeaderText="CentroPci" SortExpression="CentroPci" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="ValorPago" HeaderText="ValorPago" SortExpression="ValorPago" >
                        </asp:BoundField>
                        <asp:BoundField DataField="NumeroCuponPago" HeaderText="NumeroCuponPago" SortExpression="NumeroCuponPago" />
                        <asp:BoundField DataField="Documento" HeaderText="Prefactura" SortExpression="Documento" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="FechaModifica" HeaderText="FechaModifica" SortExpression="FechaModifica" >
                        </asp:BoundField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#4b6c9e" Font-Bold="True" ForeColor="White" />
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
    <table class="auto-style9">
        <tr>
            <td>
                <asp:DropDownList ID="ddlTipoArchivo" runat="server" Width="170px">
                    <asp:ListItem Value="2" Selected="True">Excel</asp:ListItem>
                    <asp:ListItem Value="1">Txt</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsFacturasXCentro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarPagosFacturaElectronicaXCentroSiif]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfValorTotalFactura" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfCupon" runat="server" />
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
        </tr>
    </table>
</asp:Content>
