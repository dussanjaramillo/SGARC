<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="Centros.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.AsignacionRecursos.Centros" %>
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
            width: 25%;
        }
        .auto-style10 {
            height: 21px;
        }
    
        .auto-style28 {
            font-family: Arial, Helvetica, sans-serif;
        }

        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td><h2>Asignación de Recursos:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
                </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:GridView ID="grvAsignacionRecursos" runat="server" DataSourceID="SdsAsignacionRecursos" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdAsignacionRecursos" GridLines="Vertical" OnDataBound="grvAsignacionRecursos_DataBound" OnSelectedIndexChanged="grvAsignacionRecursos_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdAsignacionRecursos" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdAsignacionRecursos" />
                        <asp:BoundField DataField="Radicado" HeaderText="Radicado" SortExpression="Radicado" />
                        <asp:BoundField DataField="FechaRadicado" DataFormatString="{0:d}" HeaderText="FechaRadicado" SortExpression="FechaRadicado" />
                        <asp:BoundField DataField="ValorSolicitado" DataFormatString="{0:N0}" HeaderText="Valor Solicitado" SortExpression="ValorSolicitado" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NombreEstadoAsignacionRecursos" HeaderText="Estado" SortExpression="NombreEstadoAsignacionRecursos" />
                        <asp:BoundField DataField="Observacion" HeaderText="Observacion" SortExpression="Observacion" />
                        <asp:BoundField DataField="NumeroResolucion" HeaderText="Resolucion" SortExpression="NumeroResolucion" />
                        <asp:BoundField DataField="FechaResolucion" HeaderText="Fecha" SortExpression="FechaResolucion" />
                        <asp:BoundField DataField="ValorAprobado" HeaderText="ValorAprobado" SortExpression="ValorAprobado" />
                        <asp:BoundField DataField="Nombre" HeaderText="Usuario" SortExpression="Nombre" />
                    </Columns>
                   <AlternatingRowStyle BackColor="#DCDCDC" />
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
    <table class="auto-style9">
        <tr>
            <td>
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" />
                <Ajax:BalloonPopupExtender ID="btnGuardar_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel1" BalloonSize="Large" DisplayOnClick="False" DisplayOnFocus="True" DisplayOnMouseOver="True" TargetControlID="btnGuardar">
                </Ajax:BalloonPopupExtender>
                <Ajax:ConfirmButtonExtender ID="btnGuardar_ConfirmButtonExtender" runat="server" BehaviorID="btnGuardar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnGuardar" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10">Radicado<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtRadicado" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style10">Fecha Radicado<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFechaRadicado" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style10">Valor Solicitado<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtValorSolicitado" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style10"></td>
            <td class="auto-style10"></td>
            <td class="auto-style10"></td>
            <td class="auto-style10"></td>
            <td class="auto-style10"></td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtRadicado" runat="server" Width="170px" MaxLength="13"></asp:TextBox>
                <Ajax:MaskedEditExtender ID="txtRadicado_MaskedEditExtender" runat="server" BehaviorID="txtRadicado_MaskedEditExtender" Century="2000" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder="" Mask="9-9999-999999" TargetControlID="txtRadicado" ClearMaskOnLostFocus="False" MaskType="Number" />
            </td>
            <td>
                <asp:TextBox ID="txtFechaRadicado" runat="server" ValidationGroup="btnGuardar" Width="170px"></asp:TextBox>
                <Ajax:CalendarExtender ID="txtFechaRadicado_CalendarExtender" runat="server" BehaviorID="txtFechaRadicado_CalendarExtender" Format="dd-MM-yyyy" TargetControlID="txtFechaRadicado" />
            </td>
            <td>
                <asp:TextBox ID="txtValorSolicitado" runat="server" MaxLength="10" ValidationGroup="btnGuardar" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtValorSolicitado_FilteredTextBoxExtender" runat="server" BehaviorID="txtValorSolicitado_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtValorSolicitado" InvalidChars=".," />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="8">
        <asp:Panel ID="Panel1" runat="server" Font-Bold="True" Font-Size="Medium">
            <span class="auto-style28">Recuerde El Correo Interno (CI) debe ser enviado al Director(a) Administrativo y Financiero con Copia al Coordinador(a) del Grupo de Recaudo y Cartera</span></asp:Panel>
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsAsignacionRecursos" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_AsignacionRecursosBuscar]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfIdAsignacionRecursos" runat="server" Visible="False" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
