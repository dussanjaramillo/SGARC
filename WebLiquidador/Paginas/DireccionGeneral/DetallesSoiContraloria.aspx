<%@ Page Title="Detalles Soi Contraloría" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DetallesSoiContraloria.aspx.cs" Inherits="WebLiquidador.Paginas.DireccionGeneral.DetallesSoiContraloria" %>
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
    <table class="auto-style6">
        <tr>
            <td colspan="4"><h2>Detalles Soi Contraloría</h2></td>
        </tr>
        <tr>
            <td class="auto-style8">Fecha Inicial</td>
            <td class="auto-style12">Fecha Final</td>
            <td class="auto-style12">Documento Causación</td>
            <td>Documento Recaudo</td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:TextBox ID="txtFechaInicial" runat="server" MaxLength="8" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtFechaInicial_FilteredTextBoxExtender" runat="server" BehaviorID="txtFechaInicial_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtFechaInicial" />
                <Ajax:TextBoxWatermarkExtender ID="txtFechaInicial_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaInicial_TextBoxWatermarkExtender" TargetControlID="txtFechaInicial" WatermarkText="AAAAMMDD" />
                <Ajax:CalendarExtender ID="txtFechaInicial_CalendarExtender" runat="server" BehaviorID="txtFechaInicial_CalendarExtender" Format="yyyyMMdd" TargetControlID="txtFechaInicial" />
                </td>
            <td class="auto-style12">
                <asp:TextBox ID="txtFechaFinal" runat="server" MaxLength="8" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtFechaFinal_FilteredTextBoxExtender" runat="server" BehaviorID="txtFechaFinal_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtFechaFinal" />
                <Ajax:TextBoxWatermarkExtender ID="txtFechaFinal_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaFinal_TextBoxWatermarkExtender" TargetControlID="txtFechaFinal" WatermarkText="AAAAMMDD" />
                <Ajax:CalendarExtender ID="txtFechaFinal_CalendarExtender" runat="server" BehaviorID="txtFechaFinal_CalendarExtender" Format="yyyyMMdd" TargetControlID="txtFechaFinal" />
                </td>
            <td class="auto-style12">
                <asp:TextBox ID="txtDocumentoCausacion" runat="server" MaxLength="10" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtDocumentoCausacion_FilteredTextBoxExtender" runat="server" BehaviorID="txtDocumentoCausacion_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtDocumentoCausacion" />
            </td>
            <td>
                <asp:TextBox ID="txtDocumentoRecaudo" runat="server" MaxLength="10" Width="170px" OnTextChanged="txtDocumentoRecaudo_TextChanged" AutoPostBack="True"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtDocumentoRecaudo_FilteredTextBoxExtender" runat="server" BehaviorID="txtDocumentoRecaudo_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtDocumentoRecaudo" />
            </td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Red" SetFocusOnError="True" ValidationGroup="btnExportar" ControlToValidate="txtFechaInicial"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style12">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Red" SetFocusOnError="True" ValidationGroup="btnExportar" ControlToValidate="txtFechaInicial"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style12">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Red" SetFocusOnError="True" ValidationGroup="btnExportar" ControlToValidate="txtDocumentoCausacion"></asp:RequiredFieldValidator>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Red" SetFocusOnError="True" ValidationGroup="btnExportar" ControlToValidate="txtDocumentoRecaudo"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style8">
                &nbsp;</td>
            <td class="auto-style12">
                &nbsp;</td>
            <td class="auto-style12">
                &nbsp;</td>
            <td>Regional</td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Calcular" Width="170px" Enabled="False" ValidationGroup="btnExportar" />
                <Ajax:ConfirmButtonExtender ID="btnExportar_ConfirmButtonExtender" runat="server" BehaviorID="btnExportar_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnExportar" />
            </td>
            <td class="auto-style12">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td class="auto-style12">
                <asp:Button ID="btnImprimir" runat="server" Enabled="False" OnClick="btnImprimir_Click" Text="Imprimir" Width="170px" ValidationGroup="btnImprimir" />
            </td>
            <td>
                <asp:DropDownList ID="ddlRegional" runat="server" DataSourceID="SdsRegional" DataTextField="NombreRegional" DataValueField="CodigoRegional" Enabled="False" OnDataBound="ddlRegional_DataBound" Width="170px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="auto-style8" colspan="2"><h2>Estado del Proceso</h2></td>
            <td class="auto-style12">&nbsp;</td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Red" SetFocusOnError="True" ValidationGroup="btnImprimir" ControlToValidate="ddlRegional" InitialValue="-1"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style10" colspan="3">
                <asp:TextBox ID="txtMensaje" runat="server" ReadOnly="True" Width="520px" Font-Bold="True" ForeColor="#FF3300" style="text-align: center" CssClass="alineacionCentral"></asp:TextBox>
            </td>
            <td class="auto-style11"></td>
        </tr>
        <tr>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style12">&nbsp;</td>
            <td class="auto-style12">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:HiddenField ID="hdfEstado" runat="server" />
            </td>
            <td class="auto-style12">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td class="auto-style12">
                <asp:SqlDataSource ID="SdsRegional" runat="server" ConnectionString="<%$ ConnectionStrings:PlanillaConnectionString %>" ProviderName="<%$ ConnectionStrings:PlanillaConnectionString.ProviderName %>" SelectCommand="Usp_BuscaRegional" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
