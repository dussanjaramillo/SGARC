<%@ Page Title="Imprimir Prefactura" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ImprimirFactura.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Factura.ImprimirFactura" %>

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
                <h2>Imprimir PreFactura:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grvFacturaXCentro" runat="server" AutoGenerateColumns="False" DataSourceID="SdsFacturasXCentro" OnDataBound="grvFacturaXCentro_DataBound" class="grvGrilla" AllowPaging="True" PageSize="15" AllowSorting="True" OnSelectedIndexChanged="grvFacturaXCentro_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Regional" HeaderText="Regional" SortExpression="Regional" />
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" SortExpression="Codigo" />
                        <asp:BoundField DataField="Documento" HeaderText="PreFactura" SortExpression="Documento" >
                        <ItemStyle Font-Bold="True" ForeColor="Maroon" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" ReadOnly="True" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" ReadOnly="True" SortExpression="Nombre" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" ReadOnly="True" SortExpression="Valor" DataFormatString="{0:c0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" SortExpression="FechaCrea" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Usuario" HeaderText="Usuario" SortExpression="Usuario" />
                        <asp:BoundField DataField="Anulada" HeaderText="Anulada" SortExpression="Anulada" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Pagada" HeaderText="Pagada" SortExpression="Pagada" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="CupónPago" SortExpression="NroInternodeTransaccion" >
                        <ItemStyle Font-Bold="True" ForeColor="Maroon" />
                        </asp:BoundField>
                         <asp:BoundField DataField="CodigoTipoCliente" HeaderText="TC" SortExpression="CodigoTipoCliente" />
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
                <asp:GridView ID="grvFacturaXCentro0" runat="server" AutoGenerateColumns="False" DataSourceID="SdsFacturasXCentroTodas" class="grvGrilla" Caption="Prefacturas Disponibles" PageSize="15" Visible="False">
                    <Columns>
                        <asp:BoundField DataField="Regional" HeaderText="Regional" SortExpression="Regional" />
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" SortExpression="Codigo" />
                        <asp:BoundField DataField="Documento" HeaderText="Prefactura" SortExpression="Documento" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" ReadOnly="True" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" ReadOnly="True" SortExpression="Nombre" />
                        <asp:BoundField DataField="Telefono" HeaderText="Telefono" SortExpression="Telefono" />
                        <asp:BoundField DataField="NombreMunicipio" HeaderText="Municipio" ReadOnly="True" SortExpression="NombreMunicipio" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" ReadOnly="True" SortExpression="Valor" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" SortExpression="FechaCrea" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Usuario" HeaderText="Usuario" SortExpression="Usuario" />
                        <asp:BoundField DataField="Anulada" HeaderText="Anulada" SortExpression="Anulada" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Pagada" HeaderText="Pagada" SortExpression="Pagada" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="CupónPago" SortExpression="NroInternodeTransaccion" />
                        <asp:BoundField DataField="Contacto" HeaderText="Contacto" SortExpression="Contacto" />
                        <asp:BoundField DataField="Referencia" HeaderText="Referencia" SortExpression="Referencia" />
                        <asp:BoundField DataField="CodigoTipoCliente" HeaderText="TC" SortExpression="CodigoTipoCliente" />

                    
                    
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
            <td colspan="2">
                <asp:DropDownList ID="ddlTipoArchivo" runat="server" Width="170px">
                    <asp:ListItem Value="2" Selected="True">Excel</asp:ListItem>
                    <asp:ListItem Value="1">Txt</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td colspan="2">
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
            </td>
            <td colspan="2">
                <asp:HiddenField ID="hfCupon" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsFacturasXCentro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaXCentro]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
            <td>
                <asp:HiddenField ID="hfValorTotalFactura" runat="server" />
            </td>
            <td>
                &nbsp;</td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsFacturasXCentroTodas" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaXCentroTodas]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
