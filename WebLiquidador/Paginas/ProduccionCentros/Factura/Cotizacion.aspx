<%@ Page Title="Factura Diaria" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="Cotizacion.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Factura.Cotizacion" %>

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
            <td colspan="7">
                <h2>Cotización:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
            </td>

        </tr>
        <tr>
            <td class="auto-style10">Tipo de Cliente<asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAgregar" ControlToValidate="ddlTipoCliente" SetFocusOnError="True" InitialValue="-1"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style10">Identificación<asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAgregar" ControlToValidate="txtIdentificacion" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style10">Nombre<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAgregar" ControlToValidate="txtNombre" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style10">Dirección<asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAgregar" ControlToValidate="txtDireccion" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style21">Teléfono<asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAgregar" ControlToValidate="txtTelefono" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style21">Departamento<asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAgregar" ControlToValidate="ddlDepartamento" InitialValue="-1" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style21">Municipio<asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAgregar" ControlToValidate="ddlMunicipio" InitialValue="-1" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:DropDownList ID="ddlTipoCliente" runat="server" AutoPostBack="True" DataSourceID="SdsTipoCliente" DataTextField="NombreTipoCliente" DataValueField="IdTipoCliente" OnDataBound="ddlTipoCliente_DataBound" OnSelectedIndexChanged="ddlTipoCliente_SelectedIndexChanged" Width="170px" ForeColor="Maroon">
                </asp:DropDownList>
            </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtIdentificacion" PlaceHolder="Identificación" runat="server" Width="170px" MaxLength="16" Enabled="False"></asp:TextBox>
                <Ajax:BalloonPopupExtender ID="txtIdentificacion_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel4" BehaviorID="txtIdentificacion_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtIdentificacion">
                </Ajax:BalloonPopupExtender>
                <Ajax:FilteredTextBoxExtender ID="txtIdentificacion_FilteredTextBoxExtender" runat="server" BehaviorID="txtIdentificacion_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=",." TargetControlID="txtIdentificacion" />
            </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtNombre" PlaceHolder="Nombre" runat="server" Width="170px" MaxLength="100" Enabled="False"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtNombre_FilteredTextBoxExtender" runat="server" BehaviorID="txtNombre_FilteredTextBoxExtender" TargetControlID="txtNombre" ValidChars="áéíóúüÁÉÍÓÚÜ ABCDEFGHIJKLMNÑOPQRSTUVWXYZ abcdefghijklmnñopqrstuvwxyz 0123456789 -_&amp;$()=." />
                <Ajax:BalloonPopupExtender ID="txtNombre_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel4" BehaviorID="txtNombre_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtNombre">
                </Ajax:BalloonPopupExtender>
            </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtDireccion" PlaceHolder="Dirección" runat="server" Width="170px" MaxLength="100" Enabled="False"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtDireccion_FilteredTextBoxExtender" runat="server" BehaviorID="txtDireccion_FilteredTextBoxExtender" TargetControlID="txtDireccion" ValidChars="áéíóúüÁÉÍÓÚÜ ABCDEFGHIJKLMNÑOPQRSTUVWXYZ abcdefghijklmnñopqrstuvwxyz 0123456789 -_&amp;$()=." />
                <Ajax:BalloonPopupExtender ID="txtDireccion_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel4" BehaviorID="txtDireccion_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtDireccion">
                </Ajax:BalloonPopupExtender>
            </td>
            <td>
                <asp:TextBox ID="txtTelefono" PlaceHolder="Teléfono" runat="server" Width="170px" MaxLength="100" Enabled="False"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtTelefono_FilteredTextBoxExtender" runat="server" BehaviorID="txtTelefono_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtTelefono" />
                <Ajax:BalloonPopupExtender ID="txtTelefono_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel4" BehaviorID="txtTelefono_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtTelefono">
                </Ajax:BalloonPopupExtender>
            </td>
            <td>
                <asp:DropDownList ID="ddlDepartamento" runat="server" AutoPostBack="True" DataSourceID="SdsDepartamento" DataTextField="NombreDepartamento" DataValueField="IdDepartamento" OnDataBound="ddlDepartamento_DataBound" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged" Width="170px" Enabled="False">
                </asp:DropDownList>
                <Ajax:BalloonPopupExtender ID="ddlDepartamento_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel4" BehaviorID="ddlDepartamento_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="ddlDepartamento">
                </Ajax:BalloonPopupExtender>
            </td>
            <td>
                <asp:DropDownList ID="ddlMunicipio" runat="server" Width="170px" Enabled="False">
                </asp:DropDownList>
                <Ajax:BalloonPopupExtender ID="ddlMunicipio_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel4" BehaviorID="ddlMunicipio_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="ddlMunicipio">
                </Ajax:BalloonPopupExtender>
            </td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" ControlToValidate="ddlTipoCliente" SetFocusOnError="True" InitialValue="-1"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style10">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" ControlToValidate="txtIdentificacion" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style10">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" ControlToValidate="txtNombre" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style10">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" ControlToValidate="txtDireccion" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style21">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" ControlToValidate="txtTelefono" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style21">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" ControlToValidate="ddlDepartamento" InitialValue="-1" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style21">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" ControlToValidate="ddlMunicipio" InitialValue="-1" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style21" colspan="3">Correo Electrónico<asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAgregar" ControlToValidate="txtContacto" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txtContacto" PlaceHolder="Correo Electrónico" runat="server" MaxLength="100" Width="510px" Enabled="False"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtContacto_FilteredTextBoxExtender" runat="server" BehaviorID="txtContacto_FilteredTextBoxExtender" FilterMode="InvalidChars" InvalidChars=" " TargetControlID="txtContacto" />
            </td>
            <td class="auto-style21" colspan="3">Contacto y/o Referencia<asp:TextBox ID="txtReferencia" PlaceHolder="Contacto y/o Referencia" runat="server" MaxLength="100" Width="510px" Enabled="False"></asp:TextBox>
            </td>
            <td class="auto-style21">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style20" style="background-color: #546E96">&nbsp;</td>
            <td class="auto-style10" style="background-color: #546E96">&nbsp;</td>
            <td class="auto-style12" style="background-color: #546E96">&nbsp;</td>
            <td class="auto-style9" style="background-color: #546E96">&nbsp;</td>
            <td style="background-color: #546E96">&nbsp;</td>
            <td style="background-color: #546E96">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10">Productos Disponibles</td>
            <td class="auto-style10">Precio Mínimo</td>
            <td class="auto-style12">Precio Máximo</td>
            <td class="auto-style9">Unidad de Medida</td>
            <td>Precio Cotizado</td>
            <td>Cantidad Cotizada</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:DropDownList ID="ddlProducto" runat="server" Width="170px" AutoPostBack="True" OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged" DataSourceID="SdsProductosXCentrro" DataTextField="NombreProducto" DataValueField="IdProducto" OnDataBound="ddlProducto_DataBound" Enabled="False" ForeColor="Maroon">
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
                <asp:TextBox ID="txtPrecio" PlaceHolder="Precio Cotizado" runat="server" Width="170px" Enabled="False"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtPrecio_FilteredTextBoxExtender" runat="server" BehaviorID="txtPrecio_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".,-" TargetControlID="txtPrecio" />
                <Ajax:BalloonPopupExtender ID="txtPrecio_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel1" BehaviorID="txtPrecio_BalloonPopupExtender" CustomCssUrl="" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtPrecio" DisplayOnFocus="True" DisplayOnMouseOver="True">
                </Ajax:BalloonPopupExtender>
            </td>
            <td>
                <asp:TextBox ID="txtCantidad" PlaceHolder="Cantidad Cotizada" runat="server" Width="170px" Enabled="False" MaxLength="6"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtCantidad_FilteredTextBoxExtender" runat="server" BehaviorID="txtCantidad_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".,-" TargetControlID="txtCantidad" />
                <Ajax:BalloonPopupExtender ID="txtCantidad_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel2" BehaviorID="txtCantidad_BalloonPopupExtender" CustomCssUrl="" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtCantidad" DisplayOnFocus="True" DisplayOnMouseOver="True">
                </Ajax:BalloonPopupExtender>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlProducto" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnAgregar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style10">&nbsp;</td>
            <td class="auto-style12">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPrecio" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAgregar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCantidad" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAgregar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style20" style="background-color: #465767">&nbsp;</td>
            <td class="auto-style10" style="background-color: #465767">&nbsp;</td>
            <td class="auto-style12" style="background-color: #465767">&nbsp;</td>
            <td class="auto-style9" style="background-color: #465767">&nbsp;</td>
            <td style="background-color: #465767">&nbsp;</td>
            <td style="background-color: #465767">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style20">
                <asp:Button ID="btnAgregar" runat="server" Text="+ Agregar" Width="170px" OnClick="btnAgregar_Click" ValidationGroup="btnAgregar" Enabled="False" />
            </td>
            <td class="auto-style10">
                <asp:Button ID="btnActualizar" runat="server" OnClick="btnActualizar_Click" Text="Actualizar" Width="170px" Enabled="False" />
                <asp:Button ID="btnActualizaProducto" runat="server" OnClick="btnActualizaProducto_Click" Text="Actualizar Producto" Visible="False" Width="170px" />
            </td>
            <td class="auto-style12">
                <asp:Button ID="btnBorrar" runat="server" OnClick="btnBorrar_Click" Text="- Borrar" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnBorrar_ConfirmButtonExtender" runat="server" BehaviorID="btnBorrar_ConfirmButtonExtender" ConfirmText="Esta Seguro?" TargetControlID="btnBorrar" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar Cotización" ValidationGroup="btnGuardar" Width="170px" Enabled="False" />
                <Ajax:BalloonPopupExtender ID="btnGuardar_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel3" BehaviorID="btnGuardar_BalloonPopupExtender" CustomCssUrl="" DynamicServicePath="" ExtenderControlID="" Position="TopRight" TargetControlID="btnGuardar">
                </Ajax:BalloonPopupExtender>
                <Ajax:ConfirmButtonExtender ID="btnGuardar_ConfirmButtonExtender" runat="server" BehaviorID="btnGuardar_ConfirmButtonExtender" ConfirmText="Esta Seguro?" TargetControlID="btnGuardar" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>
                <asp:Button ID="btnImprimir" runat="server" OnClick="btnImprimir_Click" Text="Imprimir" Width="170px" Enabled="False" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" colspan="7">
                <h2>Valor de la Cotización:
                    <asp:TextBox ID="txtValorFactura" runat="server" BackColor="#FFFF99" Enabled="False" Font-Bold="True" ForeColor="Maroon" CssClass="alineacionDerecha" Font-Size="Medium" Width="170px"></asp:TextBox>
                </h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style20" colspan="7">
                <asp:GridView ID="grvProductosCentro" runat="server" AutoGenerateColumns="False" DataKeyNames="Item" class="grvGrilla" OnSelectedIndexChanged="grvProductosCentro_SelectedIndexChanged" Caption="Productos Seleccionados">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Item" HeaderText="Item" InsertVisible="False" ReadOnly="True" SortExpression="Item" />
                        <asp:BoundField DataField="IdProducto" HeaderText="IdProducto" InsertVisible="False" ReadOnly="True" SortExpression="Item" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre">
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" SortExpression="Cantidad" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Precio" HeaderText="Precio" SortExpression="Precio" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" DataFormatString="{0:c0}">
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
                <asp:Panel ID="Panel1" runat="server">
                    Escriba el precio de Cotización del producto
                </asp:Panel>
            </td>
            <td>
                <asp:Panel ID="Panel2" runat="server">
                    Escriba la cantidad del producto
                </asp:Panel>
            </td>
            <td>
                <asp:Panel ID="Panel5" runat="server">
                    Seleccione un Producto - Para facilitar la busqueda escriba la primera letra
                </asp:Panel>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td colspan="2">
                <asp:Panel ID="Panel4" runat="server">
                    Este Campo debe ser diligenciado
                </asp:Panel>
            </td>
            <td>
                <asp:Panel ID="Panel3" runat="server">
                    Recuerde: Cuando Usted Guarde la Cotización, ésta no podrá ser modificada
                </asp:Panel>
            </td>
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
                <asp:SqlDataSource ID="SdsUnidadMedida" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarUnidadMedida" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfErrorValidacion" runat="server" Visible="False" />
            </td>
            <td>
                <asp:HiddenField ID="hfCantidadMaxima" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:HiddenField ID="hfPrecio" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsDepartamento" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarDepartamento" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
            </td>
            <td>
                <asp:HiddenField ID="hfCantidad" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsTipoCliente" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarTipoCliente]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:HiddenField ID="hfdIdProducto" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsCatalogoCentroBuscarXIdCentroFormacion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_CatalogoCentroBuscarXIdCentroFormacion" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
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
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
