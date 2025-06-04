<%@ Page Title="Interés Bancario Corriente" Language="C#" MasterPageFile="~/SiteCpp.Master" AutoEventWireup="true" CodeBehind="TasaInteresMoratorio.aspx.cs" Inherits="WebLiquidador.Paginas.CostasProcesales.Global.TasaInteresMoratorio" %>

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
        .auto-style11 {
            height: 23px;
        }

        .auto-style13 {
            width: 170px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td>
                <h2>Tasa Interés Bancario Corriente -&nbsp; 
                <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                    &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="https://www.superfinanciera.gov.co/inicio/sala-de-prensa/comunicados-de-prensa-/interes-bancario-corriente-10829" Target="_blank">Intéres Bancario Corriente</asp:HyperLink>
                </h2>
            </td>
        </tr>
    </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style11">Tasa<br />
                <asp:TextBox ID="txtTasa" runat="server" MaxLength="6" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtTasa_TextBoxWatermarkExtender" runat="server" BehaviorID="txtTasa_TextBoxWatermarkExtender" TargetControlID="txtTasa" WatermarkText="Formato 99,99" />
                <Ajax:FilteredTextBoxExtender ID="txtTasa_FilteredTextBoxExtender" runat="server" BehaviorID="txtTasa_FilteredTextBoxExtender" FilterType="Custom, Numbers" TargetControlID="txtTasa" ValidChars="," />
            </td>
            <td class="auto-style11">Vigencia Desde
                <br />
                <asp:TextBox ID="txtVigenciaDesde" runat="server" MaxLength="10" Width="170px"></asp:TextBox>
                <Ajax:CalendarExtender ID="txtVigenciaDesde_CalendarExtender" runat="server" BehaviorID="txtVigenciaDesde_CalendarExtender" TargetControlID="txtVigenciaDesde" />
            </td>
            <td class="auto-style11">Vigencia Hasta<br />
                <asp:TextBox ID="txtVigenciaHasta" runat="server" MaxLength="10" Width="170px" AutoPostBack="True" OnTextChanged="txtVigenciaHasta_TextChanged"></asp:TextBox>
                <Ajax:CalendarExtender ID="txtVigenciaHasta_CalendarExtender" runat="server" BehaviorID="txtVigenciaHasta_CalendarExtender" TargetControlID="txtVigenciaHasta" />
            </td>
            <td class="auto-style11">
                <asp:CheckBox ID="chbEsActivo" runat="server" Checked="True" Font-Bold="True" ForeColor="Maroon" Text="Activo" TextAlign="Left" ToolTip="Es Activo?" />
            </td>
        </tr>
        <tr>
            <td class="auto-style13" colspan="4" style="background-color: #6E8A34">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style13">
                <asp:Button ID="btnAgregar" runat="server" OnClick="btnAgregar_Click" Text="Agregar" ValidationGroup="btnAgregar" Width="170px" Enabled="False" />
            </td>
            <td class="auto-style14">
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" Enabled="False" />
            </td>
            <td class="auto-style17">
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
            </td>
            <td class="auto-style19">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
    </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style10">
                <asp:GridView ID="grvTasaInteresMoratorio" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SdsTasaInteres" Width="417px" PageSize="15" DataKeyNames="IdTasaInteresBancario" OnSelectedIndexChanged="grvTasaInteresMoratorio_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdTasaInteresBancario" HeaderText="Id" ReadOnly="True" SortExpression="IdTasaInteresBancario" />
                        <asp:BoundField DataField="Tasa" HeaderText="Tasa" SortExpression="Tasa" />
                        <asp:BoundField DataField="VigenciaDesde" HeaderText="VigenciaDesde" SortExpression="VigenciaDesde" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="VigenciaHasta" HeaderText="VigenciaHasta" SortExpression="VigenciaHasta" DataFormatString="{0:d}" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#CCCCCC" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="DarkOliveGreen" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
                <br />
                <asp:GridView ID="grvTasaInteresMoratorio0" runat="server" AutoGenerateColumns="False" DataSourceID="SdsTasaInteres" Width="421px" PageSize="15" Visible="False" DataKeyNames="IdTasaInteresBancario">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="IdTasaInteresBancario" HeaderText="Id" ReadOnly="True" SortExpression="IdTasaInteresBancario" />
                        <asp:BoundField DataField="Tasa" HeaderText="Tasa" SortExpression="Tasa" />
                        <asp:BoundField DataField="VigenciaDesde" HeaderText="VigenciaDesde" SortExpression="VigenciaDesde" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="VigenciaHasta" HeaderText="VigenciaHasta" SortExpression="VigenciaHasta" DataFormatString="{0:d}" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#CCCCCC" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="DarkOliveGreen" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </td>
        </tr>
    </table>
    <table class="auto-style6">
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsTasaInteres" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CostasProcesales].[Usp_TasaInteresBancarioBuscar_]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfErrorValidacion" runat="server" Visible="False" />
            </td>
            <td>
                <asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
            </td>
            <td>
                <asp:HiddenField ID="hfIdTasa" runat="server" Visible="False" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
