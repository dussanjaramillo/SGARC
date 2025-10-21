<%@ Page Title="Estado de Cuenta Historico - Cartera" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EstadoCuentaHistorico.aspx.cs" Inherits="WebLiquidador.Paginas.AtencionCiudadano.EstadoCuentaHistorico" %>

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
            .auto-style12 {
                width: 165px;
            }
            .auto-style13 {
                width: 89px;
            }
            .auto-style14 {
                width: 3px;
            }
            .auto-style15 {
            }
        </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td class="auto-style15" colspan="8"><h2>Estado de Cuenta Cartera Regional - Histórico Acumulado Desde May 2015 a Ago 2018</h2></td>
        </tr>
        <tr>
            <td class="auto-style15">Identificación</td>
            <td class="auto-style12">&nbsp;</td>
            <td class="auto-style13">&nbsp;</td>
            <td class="auto-style14">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style12">
                <asp:TextBox ID="txtIdentificacion" runat="server" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtIdentificacion_FilteredTextBoxExtender" runat="server" FilterType="Numbers" TargetControlID="txtIdentificacion" />
            </td>
            <td class="auto-style13">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td class="auto-style14">
                <asp:Button ID="btn_Limpiar" runat="server" Text="Limpiar" Width="170px" OnClick="btn_Limpiar_Click" />
            </td>
            <td>
                <asp:Button ID="btnImprimir" runat="server" Text="Exportar a Txt" Width="170px" OnClick="btnImprimir_Click" Visible="False" />
            </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtIdentificacion" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style12">
                &nbsp;</td>
            <td class="auto-style13">
                &nbsp;</td>
            <td class="auto-style14">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <table class="auto-style6">
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:GridView ID="grvHistorico" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsHistoricos" AllowPaging="True" Caption="Cartera Histórica Acumulada Desde May 2015 a Ago 2018" class="grvGrilla" CaptionAlign="Left" OnDataBound="grvHistorico_DataBound" Width="100%" AllowSorting="True">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="Mes" HeaderText="Mes" SortExpression="Mes" ReadOnly="True" />
                        <asp:BoundField DataField="REGIONAL" HeaderText="Regional" SortExpression="REGIONAL" />
                        <asp:BoundField DataField="IDAPORTANTE" HeaderText="Nit" SortExpression="IDAPORTANTE" />
                        <asp:BoundField DataField="NOMBRE" HeaderText="Nombre" SortExpression="NOMBRE" />
                        <asp:BoundField DataField="IDRESLIQ" HeaderText="Nro" SortExpression="IDRESLIQ" />
                        <asp:BoundField DataField="LRN_TYPE" HeaderText="LR" SortExpression="LRN_TYPE" />
                        <asp:BoundField DataField="FECHA" HeaderText="Fecha" SortExpression="FECHA" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="FUENTE" HeaderText="Con" SortExpression="FUENTE" />
                        <asp:BoundField DataField="ESTADO" HeaderText="Estado" SortExpression="ESTADO" />
                        <asp:BoundField DataField="VALOR" HeaderText="Valor" SortExpression="VALOR" />
                        <asp:BoundField DataField="SALDOAPORTE" HeaderText="Saldo" SortExpression="SALDOAPORTE" />
                        <asp:BoundField DataField="OBSERVACIONES" HeaderText="Observacion" SortExpression="OBSERVACIONES" />
                        <asp:BoundField DataField="PROMOTOR" HeaderText="Promotor" ReadOnly="True" SortExpression="PROMOTOR" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#FF9536" Font-Bold="True" ForeColor="Black" />
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
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>
                <asp:SqlDataSource ID="SdsHistoricos" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_Buscar_APOV_LIQRESS_MES"
                SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtIdentificacion" Name="Identificacion" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                <asp:HiddenField ID="hfRegistros" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
