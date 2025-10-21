<%@ Page Title="Ugpp - Aviso de Incumplimiento en el Pago" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AvisoIncumplimiento.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.AvisoIncumplimiento" %>

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
                text-align: center;
            }
        </style>

    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="4">
                <h2>Aviso de Incumplimiento</h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style26" rowspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Image ID="Image1" runat="server" Height="96px" ImageUrl="~/Imagenes/Logo_Ugpp.png" Style="text-align: center" />
            </td>
            <td class="auto-style23">Fecha Cálculo</td>
            <td class="auto-style9">Generar Aportantes?</td>
            <td class="auto-style14">Vigencia</td>
        </tr>
        <tr>
            <td class="auto-style23">
                <asp:TextBox ID="txtFechaCalculo" runat="server" Width="170px" ValidationGroup="btnCalcular"></asp:TextBox>
                <Ajax:CalendarExtender ID="txtFechaCalculo_CalendarExtender" runat="server" BehaviorID="txtFechaCalculo_CalendarExtender" Format="dd/MM/yyyy" TargetControlID="txtFechaCalculo" />
            </td>
            <td class="auto-style9">
                <asp:DropDownList ID="ddlGenerarAportantes" runat="server" Width="170px" Enabled="False" Font-Bold="True" ForeColor="Maroon">
                    <asp:ListItem>No</asp:ListItem>
                    <asp:ListItem>Si</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="auto-style14">
                <asp:TextBox ID="txtVigencia" runat="server" Width="170px" Enabled="False" Font-Bold="True" ForeColor="Maroon"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style17" colspan="3" style="background-color: #E48F43"></td>
        </tr>
        <tr>
            <td class="auto-style23">
                <asp:Button ID="btnCalcular" runat="server" Enabled="False" OnClick="btnCalcular_Click" Text="Calcular" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnCalcular_ConfirmButtonExtender" runat="server" BehaviorID="btnCalcular_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnCalcular" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnDesagregadoDiario" runat="server" Text="Desagregado Diario" Width="170px" OnClick="btnDesagregadoDiario_Click" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnDesagregadoDiario_ConfirmButtonExtender" runat="server" BehaviorID="btnDesagregadoDiario_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnDesagregadoDiario" />
            </td>
            <td class="auto-style14">
                <asp:Button ID="btnRefrescar" runat="server" Text="Refrescar" Width="170px" OnClick="btnRefrescar_Click" />
            </td>
        </tr>
        <tr>
            <td class="auto-style27">&nbsp;</td>
            <td class="auto-style24">Codigo Administradora</td>
            <td class="auto-style12" colspan="2">Nombre Administradora</td>
        </tr>
        <tr>
            <td class="auto-style27">&nbsp;</td>
            <td class="auto-style24">
                <asp:TextBox ID="txtCodigoAdministradora" runat="server" ReadOnly="True" Width="170px"></asp:TextBox>
            </td>
            <td class="auto-style12" colspan="2">
                <asp:TextBox ID="txtNombreAdministradora" runat="server" ReadOnly="True" Width="334px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style27">&nbsp;</td>
            <td class="auto-style11" colspan="3">
                <h2 class="auto-style8">Estado del Proceso</h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style27">&nbsp;</td>
            <td class="auto-style11" colspan="3">
                <asp:TextBox ID="txtMensaje" runat="server" ReadOnly="True" Width="520px" Font-Bold="True" ForeColor="#FF3300" Style="text-align: center" CssClass="alineacionCentral"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style27"></td>
            <td class="auto-style24" colspan="3">
                <h3>
                    <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" NavigateUrl="~/Paginas/Normas/Presentacion Resolucion 2082_16_Estandares I_II_III_IV_marzo_2017.pdf">Presentacion Resolucion 2082</asp:HyperLink>
                </h3>
            </td>
        </tr>
        <tr>
            <td class="auto-style26">&nbsp;</td>
            <td class="auto-style8" colspan="3">
                <asp:GridView ID="grvDosUltimosDigitos" runat="server" AutoGenerateColumns="False" DataSourceID="SdsUltimosDosDigitos">
                    <Columns>
                        <asp:BoundField DataField="NombreClasificacionEmpresa" HeaderText="Clasificación Empresa" SortExpression="NombreClasificacionEmpresa" />
                        <asp:BoundField DataField="DosUltimosDigitosDel" HeaderText="Digitos Del" SortExpression="DosUltimosDigitosDel" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DosUltimosDigitosAl" HeaderText="Digitos Al" SortExpression="DosUltimosDigitosAl" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DiaHabilVencimiento" HeaderText="Dia Habil" SortExpression="DiaHabilVencimiento" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
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
        </tr>
    </table>
    <table class="auto-style6">
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:HiddenField ID="hdfEstadoProceso" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsUltimosDosDigitos" runat="server" ConnectionString="<%$ ConnectionStrings:PlanillaConnectionString %>" ProviderName="<%$ ConnectionStrings:PlanillaConnectionString.ProviderName %>" SelectCommand="Usp_AportantesDosUltimosDigitos" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfGenerarAportantes" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hfFechaCalculada" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfPeriodoEvaluarDesde" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfPeriodoEvaluarHasta" runat="server" />
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
        </tr>
    </table>
</asp:Content>
