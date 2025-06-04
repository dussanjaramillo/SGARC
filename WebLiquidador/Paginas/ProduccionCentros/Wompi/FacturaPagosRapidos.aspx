<%@ Page Title="Prefactura Pagos Rápidos" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="FacturaPagosRapidos.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Wompi.FacturaPagosRapidos" %>

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
            <td colspan="6">
                <h2>Prefactura Pagos Rápidos:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                    &nbsp;</h2>
            </td>

        </tr>
        <tr>
            <td class="auto-style16">Identificación</td>
            <td class="auto-style16">Nombre Comprador</td>
            <td class="auto-style16">Dirección</td>
            <td class="auto-style16">Teléfono</td>
            <td class="auto-style16">Departamento</td>
            <td class="auto-style16">Municipio</td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:TextBox ID="txtIdentificacion" runat="server" Width="170px" MaxLength="16" AutoPostBack="True"></asp:TextBox>
            </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtNombre" runat="server" Width="170px" MaxLength="100"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtNombre_FilteredTextBoxExtender" runat="server" BehaviorID="txtNombre_FilteredTextBoxExtender" TargetControlID="txtNombre" ValidChars="áéíóúüÁÉÍÓÚÜ ABCDEFGHIJKLMNÑOPQRSTUVWXYZ abcdefghijklmnñopqrstuvwxyz 0123456789 -_&amp;$()=." />
            </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtDireccion" runat="server" Width="170px" MaxLength="100"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtDireccion_FilteredTextBoxExtender" runat="server" BehaviorID="txtDireccion_FilteredTextBoxExtender" TargetControlID="txtDireccion" ValidChars="áéíóúüÁÉÍÓÚÜ ABCDEFGHIJKLMNÑOPQRSTUVWXYZ abcdefghijklmnñopqrstuvwxyz 0123456789 -_&amp;$()=." />
            </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtTelefono" runat="server" Width="170px" MaxLength="100"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtTelefono_FilteredTextBoxExtender" runat="server" BehaviorID="txtTelefono_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtTelefono" />
            </td>
            <td>
                <asp:DropDownList ID="ddlDepartamento" runat="server" AutoPostBack="True" DataSourceID="SdsDepartamento" DataTextField="NombreDepartamento" DataValueField="IdDepartamento" OnDataBound="ddlDepartamento_DataBound" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged" Width="170px">
                </asp:DropDownList>
            </td>
            <td>
                <asp:DropDownList ID="ddlMunicipio" runat="server" Width="170px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="auto-style20" style="background-color: #546E96" colspan="6">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style14" colspan="6">
                <asp:GridView ID="grvPagosRapidos" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataSourceID="SqlPagosRapidos" ForeColor="Black" GridLines="Horizontal" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" PageSize="5" OnSelectedIndexChanged="grvPagosRapidos_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Centro" HeaderText="Centro" SortExpression="Centro" />
                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" ReadOnly="True" SortExpression="Cantidad" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" ReadOnly="True" SortExpression="Valor" />
                        <asp:BoundField DataField="FechaEntidadFinanciera" DataFormatString="{0:d}" HeaderText="Fecha" SortExpression="FechaEntidadFinanciera" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>
                <asp:Panel ID="Panel6" runat="server" Visible="False">
                    Seleccione el Pago al que le va hacer la Prefactura. <span class="auto-style15"><strong>Recuerde que el Valor de la Prefactura Debe ser el Mismo del Valor de los Pagos Rápidos Recibidos Por Día</strong></span></asp:Panel>
                <Ajax:BalloonPopupExtender ID="grvPagosRapidos_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel6" BehaviorID="grvPagosRapidos_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="grvPagosRapidos" Position="TopRight" BalloonSize="Medium">
                </Ajax:BalloonPopupExtender>
            </td>
        </tr>
        <tr>
            <td>Productos<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlProducto" ErrorMessage=" :Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnAgregar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td>Precio Mínimo</td>
            <td>Precio Máximo</td>
            <td class="auto-style13">Medida</td>
            <td>Precio Venta<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPrecio" ErrorMessage=" :Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAgregar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td>Cantidad<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCantidad" ErrorMessage=" :Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAgregar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:DropDownList ID="ddlProducto" runat="server" Width="170px" AutoPostBack="True" OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged" DataSourceID="SdsProductosXCentrro" DataTextField="NombreProducto" DataValueField="IdProducto" OnDataBound="ddlProducto_DataBound" ForeColor="Maroon" Enabled="False">
                </asp:DropDownList>
                <Ajax:BalloonPopupExtender ID="ddlProducto_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel5" BehaviorID="ddlProducto_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="ddlProducto">
                </Ajax:BalloonPopupExtender>
            </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtPrecioMinimo" runat="server" Width="170px" Enabled="False"></asp:TextBox>
            </td>
            <td class="auto-style12">
                <asp:TextBox ID="txtPrecioMaximo" runat="server" Width="170px" Enabled="False"></asp:TextBox>
            </td>
            <td class="auto-style9">
                <asp:DropDownList ID="ddlUnidadMedida" runat="server" DataSourceID="SdsUnidadMedida" DataTextField="NombreUnidadMedida" DataValueField="IdUnidadMedida" OnDataBound="ddlUnidadMedida_DataBound" Width="170px" Enabled="False" OnSelectedIndexChanged="ddlUnidadMedida_SelectedIndexChanged" AutoPostBack="True">
                </asp:DropDownList>
            </td>
            <td>
                <asp:TextBox ID="txtPrecio" runat="server" Width="170px" MaxLength="8" Enabled="False"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtPrecio_FilteredTextBoxExtender" runat="server" BehaviorID="txtPrecio_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".,-" TargetControlID="txtPrecio" />
                <Ajax:BalloonPopupExtender ID="txtPrecio_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel1" BehaviorID="txtPrecio_BalloonPopupExtender" CustomCssUrl="" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtPrecio" DisplayOnFocus="True" DisplayOnMouseOver="True">
                </Ajax:BalloonPopupExtender>
            </td>
            <td>
                <asp:TextBox ID="txtCantidad" runat="server" Width="170px" MaxLength="6" Enabled="False"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtCantidad_FilteredTextBoxExtender" runat="server" BehaviorID="txtCantidad_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".,-" TargetControlID="txtCantidad" />
                <Ajax:BalloonPopupExtender ID="txtCantidad_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel2" BehaviorID="txtCantidad_BalloonPopupExtender" CustomCssUrl="" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtCantidad" DisplayOnFocus="True" DisplayOnMouseOver="True">
                </Ajax:BalloonPopupExtender>
            </td>
        </tr>
        <tr>
            <td class="auto-style11" style="background-color: #465767" colspan="6">
                    &nbsp;</td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style10">
                <asp:Button ID="btnAgregar" runat="server" Text="+ Agregar" Width="170px" OnClick="btnAgregar_Click" ValidationGroup="btnAgregar" Enabled="False" />
            </td>
            <td class="auto-style12">
                <asp:Button ID="btnActualizaProducto" runat="server" OnClick="btnActualizaProducto_Click" Text="Actualizar Producto" Visible="False" Width="170px" />
                <asp:Button ID="btnActualizar" runat="server" OnClick="btnActualizar_Click" Text="Actualizar" Width="170px" Enabled="False" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnBorrar" runat="server" OnClick="btnBorrar_Click" Text="- Borrar" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnBorrar_ConfirmButtonExtender" runat="server" BehaviorID="btnBorrar_ConfirmButtonExtender" ConfirmText="Esta Seguro?" TargetControlID="btnBorrar" />
            </td>
            <td>
                <asp:Button ID="btnGenerar" runat="server" Enabled="False" OnClick="btnGenerar_Click" Text="Generar Prefactura" ValidationGroup="btnGenerar" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnGenerar_ConfirmButtonExtender" runat="server" BehaviorID="btnGenerar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnGenerar" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style20">
                <h2>Valor de la Prefactura Diaria Pagos Rápidos:
                    <asp:TextBox ID="txtValorFactura" runat="server" BackColor="#FFFF99" Enabled="False" Font-Bold="True" ForeColor="Maroon" Font-Size="Medium" CssClass="alineacionDerecha" Width="170px"></asp:TextBox>
                </h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style17">
                <asp:GridView ID="grvProductosCentro" runat="server" AutoGenerateColumns="False" DataKeyNames="Item" class="grvGrilla"  OnSelectedIndexChanged="grvProductosCentro_SelectedIndexChanged" Caption="Productos Seleccionados">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Item" HeaderText="Item" InsertVisible="False" ReadOnly="True" SortExpression="Item" />
                        <asp:BoundField DataField="IdProducto" HeaderText="IdProducto" InsertVisible="False" ReadOnly="True" SortExpression="Item" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre">
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" SortExpression="Cantidad">
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Precio" HeaderText="Precio" SortExpression="Precio">
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="IdUnidadMedida" HeaderText="IdU" InsertVisible="False" ReadOnly="True" SortExpression="IdUnidadMedida" />
                        <asp:BoundField DataField="NombreUnidadMedida" HeaderText="Medida" InsertVisible="False" ReadOnly="True" SortExpression="NombreUnidadMedida" />

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
    <table class="auto-style6">
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:HiddenField ID="hfFechaCupon" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsUnidadMedida" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarUnidadMedida" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfValorPreFactura" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfUsuarioFacturaDiaria" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:SqlDataSource ID="SdsDepartamento" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarDepartamento" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfErrorValidacion" runat="server" Visible="False" />
            </td>
            <td>
                <asp:HiddenField ID="hfPrecio" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfCantidad" runat="server" />
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:HiddenField ID="hfdIdProducto" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfdProductoCatalogo" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfdItem" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsProductosXCentrro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarProductoxCentro]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfValorCupones" runat="server" />
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:HiddenField ID="hfCantidadMaxima" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfPlazoMaximo" runat="server" />
            </td>
            <td colspan="2">
                <asp:SqlDataSource ID="SdsCatalogoCentroBuscarXIdCentroFormacion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_CatalogoCentroBuscarXIdCentroFormacion" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SqlPagosRapidos" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[Wompi].[Usp_BuscarPagosRapidosWompi]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="CodigoCentro" SessionField="_CodigoCentroFormacion" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
