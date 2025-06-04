<%@ Page Title="Precio Mínimo y Máximo de Poductos" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ControlCentroFormacion.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.ControlCentroFormacion" %>
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
    <table class="auto-style8">
        <tr>
            <td colspan="5"><h2>Control Centros de Formación - 
                <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                    </h2></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style23">Precio Mínimo Producto</td>
            <td class="auto-style23">Precio Máximo Producto</td>
            <td class="auto-style24">Plazo Máximo Factura</td>
            <td class="auto-style24">Cantidad Máxima Venta</td>
            <td class="auto-style24">Cantidad Max de Inventario</td>
            <td class="auto-style24">Coordinador</td>
        </tr>
        <tr>
            <td class="auto-style9">
                <asp:TextBox ID="txtPrecioMinimo" runat="server" MaxLength="5" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtPrecioMinimo_FilteredTextBoxExtender" runat="server" BehaviorID="txtPrecioMinimo_FilteredTextBoxExtender" TargetControlID="txtPrecioMinimo" FilterType="Numbers" InvalidChars=".," />
                <Ajax:BalloonPopupExtender ID="txtPrecioMinimo_BalloonPopupExtender" runat="server" BehaviorID="txtPrecioMinimo_BalloonPopupExtender" CustomCssUrl="" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtPrecioMinimo" BalloonPopupControlID="Panel1" DisplayOnFocus="True" DisplayOnMouseOver="True">
                </Ajax:BalloonPopupExtender>
            </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtPrecioMaximo" runat="server" MaxLength="9" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtPrecioMaximo_FilteredTextBoxExtender" runat="server" BehaviorID="txtPrecioMaximo_FilteredTextBoxExtender" TargetControlID="txtPrecioMaximo" FilterType="Numbers" InvalidChars=".," />
                <Ajax:BalloonPopupExtender ID="txtPrecioMaximo_BalloonPopupExtender" runat="server" BehaviorID="txtPrecioMaximo_BalloonPopupExtender" CustomCssUrl="" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtPrecioMaximo" BalloonPopupControlID="Panel2" DisplayOnFocus="True" DisplayOnMouseOver="True">
                </Ajax:BalloonPopupExtender>
            </td>
            <td class="auto-style11">
                <asp:TextBox ID="txtPlazoMaximo" runat="server" MaxLength="1" Width="170px"></asp:TextBox>
                <Ajax:BalloonPopupExtender ID="txtPlazoMaximo_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel3" BehaviorID="txtPlazoMaximo_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtPlazoMaximo">
                </Ajax:BalloonPopupExtender>
                <Ajax:FilteredTextBoxExtender ID="txtPlazoMaximo_FilteredTextBoxExtender" runat="server" BehaviorID="txtPlazoMaximo_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=",." TargetControlID="txtPlazoMaximo" />
            </td>
            <td>
                <asp:TextBox ID="txtCantidadMaxima" runat="server" MaxLength="6" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtCantidadMaxima_TextBoxWatermarkExtender" runat="server" BehaviorID="txtCantidadMaxima_TextBoxWatermarkExtender" TargetControlID="txtCantidadMaxima" WatermarkText="Cantidad Máxima" />
                <Ajax:BalloonPopupExtender ID="txtCantidadMaxima_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel4" BehaviorID="txtCantidadMaxima_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtCantidadMaxima">
                </Ajax:BalloonPopupExtender>
            </td>
            <td>
                <asp:TextBox ID="txtCantidadInventario" runat="server" MaxLength="6" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtCantidadInventario_TextBoxWatermarkExtender" runat="server" BehaviorID="txtCantidadInventario_TextBoxWatermarkExtender" TargetControlID="txtCantidadInventario" WatermarkText="Cantidad Máxima Inventario" />
                <Ajax:BalloonPopupExtender ID="txtCantidadInventario_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel5" BehaviorID="txtCantidadInventario_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtCantidadInventario">
                </Ajax:BalloonPopupExtender>
            </td>
            <td>
                <asp:TextBox ID="txtNombreCoordinadorRecaudoCartera" runat="server" MaxLength="80" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtNombreCoordinadorRecaudoCartera_TextBoxWatermarkExtender" runat="server" BehaviorID="txtCantidadInventario_TextBoxWatermarkExtender" TargetControlID="txtNombreCoordinadorRecaudoCartera" WatermarkText="Cantidad Máxima Inventario" />
                <Ajax:BalloonPopupExtender ID="txtNombreCoordinadorRecaudoCartera_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel5" BehaviorID="txtCantidadInventario_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtNombreCoordinadorRecaudoCartera">
                </Ajax:BalloonPopupExtender>
            </td>
        </tr>
        <tr>
            <td class="auto-style21">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPrecioMinimo" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style21">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPrecioMaximo" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style22">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPlazoMaximo" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style22">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtCantidadMaxima" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style22">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtCantidadInventario" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style22">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtNombreCoordinadorRecaudoCartera" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style15">
                Año Vigencia</td>
            <td class="auto-style15">
                Año Vigencia Sirec</td>
            <td class="auto-style15"></td>
            <td class="auto-style15"></td>
            <td class="auto-style15"></td>
            <td class="auto-style15"></td>
        </tr>
        <tr>
            <td class="auto-style12">
                <asp:TextBox ID="txtAñoVigencia" runat="server" MaxLength="4" Width="170px"></asp:TextBox>
            </td>
            <td class="auto-style12">
                <asp:TextBox ID="txtAñoVigenciaSirec" runat="server" MaxLength="4" Width="170px"></asp:TextBox>
            </td>
            <td class="auto-style13"></td>
            <td class="auto-style13"></td>
            <td class="auto-style13"></td>
            <td class="auto-style13"></td>
        </tr>
        <tr>
            <td class="auto-style12">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtAñoVigencia" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style12">
                </td>
            <td class="auto-style13"></td>
            <td class="auto-style13"></td>
            <td class="auto-style13"></td>
            <td class="auto-style13"></td>
        </tr>
        <tr>
            <td class="auto-style16">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" OnClick="btnGuardar_Click" />
                <Ajax:ConfirmButtonExtender ID="btnGuardar_ConfirmButtonExtender" runat="server" BehaviorID="btnGuardar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnGuardar" />
            </td>
            <td class="auto-style16">
                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" Width="170px" OnClick="btnLimpiar_Click" />
            </td>
            <td class="auto-style17"></td>
            <td class="auto-style17"></td>
            <td class="auto-style17"></td>
            <td class="auto-style17"></td>
        </tr>
        <tr>
            <td colspan="2" class="auto-style18">
                <asp:Panel ID="Panel1" runat="server">
                    Escriba el precio Mínimo de venta del producto</asp:Panel>
            </td>
            <td class="auto-style18"></td>
            <td class="auto-style18"></td>
            <td class="auto-style18"></td>
            <td class="auto-style18"></td>
        </tr>
        <tr>
            <td colspan="2" class="auto-style18">
                <asp:Panel ID="Panel2" runat="server">
                    Escriba el precio Máximo de venta del producto</asp:Panel>
            </td>
            <td class="auto-style18"></td>
            <td class="auto-style18"></td>
            <td class="auto-style18"></td>
            <td class="auto-style18"></td>
        </tr>
        <tr>
            <td colspan="2" class="auto-style19">
                <asp:Panel ID="Panel3" runat="server">
                    Escriba el plazo Máximo de Pagos para una Factura</asp:Panel>
            </td>
            <td class="auto-style19"></td>
            <td class="auto-style19"></td>
            <td class="auto-style19"></td>
            <td class="auto-style19"></td>
        </tr>
        <tr>
            <td colspan="2" class="auto-style19">
                <asp:Panel ID="Panel4" runat="server">
                    Escriba el la Cantidad Máxima para una Factura</asp:Panel>
            </td>
            <td class="auto-style19"></td>
            <td class="auto-style19"></td>
            <td class="auto-style19"></td>
            <td class="auto-style19"></td>
        </tr>
        <tr>
            <td class="auto-style20" colspan="2">
                <asp:Panel ID="Panel5" runat="server" Width="359px">
                    Escriba el la Cantidad Máxima para el Inventario</asp:Panel>
            </td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td class="auto-style9">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td class="auto-style10">
                &nbsp;</td>
            <td class="auto-style11">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
