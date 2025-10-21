<%@ Page Title="Catálogo de Productos" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="CatalogoProducto.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Catalogo.CatalogoProducto" %>
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
            .auto-style6 {
                height: 27px;
            }
            .auto-style7 {
                height: 21px;
            }
            .auto-style14 {
                height: 33px;
                width: 102px;
            }
            .auto-style16 {
                height: 16px;
                width: 102px;
            }
            .auto-style17 {
                height: 16px;
            }
            .auto-style21 {
                height: 12px;
            }
            .auto-style22 {
                height: 12px;
                width: 102px;
            }
            .auto-style23 {
                height: 6px;
            }
            .auto-style24 {
                height: 6px;
                width: 102px;
            }
            .auto-style25 {
                height: 15px;
            }
            .auto-style26 {
                height: 15px;
                width: 102px;
            }
            .auto-style27 {
                height: 26px;
                width: 102px;
            }
            .auto-style28 {
                height: 27px;
                width: 1125px;
            }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
    <tr>
        <td colspan="5"><h2>Catálogo de Productos: <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                  </h2>  </td>
        
    </tr>
    <tr>
        <td class="auto-style23">Nombre del Producto<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNombreProducto" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
                </td>
        <td class="auto-style24" colspan="2"></td>
        <td class="auto-style24"></td>
        <td class="auto-style24"></td>
    </tr>
    <tr>
        <td class="auto-style25">
            <asp:TextBox ID="txtNombreProducto" runat="server" Width="250px" ValidationGroup="btnBuscar" MaxLength="20" ></asp:TextBox>
            <Ajax:BalloonPopupExtender ID="txtNombreProducto_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel1" BehaviorID="txtNombreProducto_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtNombreProducto">
            </Ajax:BalloonPopupExtender>
        </td>
        <td class="auto-style26" colspan="2">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="250px" />
            </td>
        <td class="auto-style26">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="250px" />
            </td>
        <td class="auto-style26">
                </td>
    </tr>
    <tr>
        <td class="auto-style21">Productos Disponibles</td>
        <td class="auto-style21">Precio Mínimo</td>
        <td class="auto-style21">Precio Máximo</td>
        <td class="auto-style21">Unidad de Medida</td>
        <td class="auto-style22">
                </td>
    </tr>
    <tr>
        <td class="auto-style6">
            <asp:DropDownList ID="ddlProducto" runat="server" Width="250px" AutoPostBack="True" OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged" Enabled="False">
            </asp:DropDownList>
        </td>
        <td class="auto-style6">
            <asp:TextBox ID="txtPrecioMinimo" runat="server" Width="115px" ValidationGroup="btnGuardar" Enabled="False"></asp:TextBox>
            <Ajax:BalloonPopupExtender ID="txtPrecioMinimo_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel2" BehaviorID="txtPrecioMinimo_BalloonPopupExtender" CustomCssUrl="" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtPrecioMinimo">
            </Ajax:BalloonPopupExtender>
            <Ajax:FilteredTextBoxExtender ID="txtPrecioMinimo_FilteredTextBoxExtender" runat="server" BehaviorID="txtPrecioMinimo_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtPrecioMinimo" />
        </td>
        <td class="auto-style6">
            <asp:TextBox ID="txtPrecioMaximo" runat="server" Width="115px" ValidationGroup="btnGuardar" Enabled="False"></asp:TextBox>
            <Ajax:FilteredTextBoxExtender ID="txtPrecioMaximo_FilteredTextBoxExtender" runat="server" BehaviorID="txtPrecioMaximo_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtPrecioMaximo" />
            <Ajax:BalloonPopupExtender ID="txtPrecioMaximo_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel3" BehaviorID="txtPrecioMaximo_BalloonPopupExtender" CustomCssUrl="" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtPrecioMaximo">
            </Ajax:BalloonPopupExtender>
        </td>
        <td class="auto-style6">
            <asp:DropDownList ID="ddlUnidadMedida" runat="server" DataSourceID="SdsUnidadMedida" DataTextField="NombreUnidadMedida" DataValueField="IdUnidadMedida" OnDataBound="ddlUnidadMedida_DataBound" Width="250px" Enabled="False" OnSelectedIndexChanged="ddlUnidadMedida_SelectedIndexChanged" AutoPostBack="True">
            </asp:DropDownList>
        </td>
        <td class="auto-style14">
                <asp:CheckBox ID="chbEsActivo" runat="server" Checked="True" Font-Bold="True" ForeColor="Maroon" Text="Activo" ToolTip="Es Activo?" Width="100px" TextAlign="Left" />
            </td>
    </tr>
    <tr>
        <td class="auto-style16">
                </td>
        <td class="auto-style17">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPrecioMinimo" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
        </td>
        <td class="auto-style17">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtPrecioMaximo" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
        </td>
        <td class="auto-style17">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlUnidadMedida" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar" InitialValue="-1"></asp:RequiredFieldValidator>
        </td>
        <td class="auto-style17">
                </td>
    </tr>
    <tr>
        <td class="auto-style27">
                <asp:Button ID="btnActualizar" runat="server" OnClick="btnActualizar_Click" Text="Actualizar" Width="250px" Enabled="False" />
        </td>
        <td class="auto-style27" colspan="2">
                <asp:Button ID="btnBorrar" runat="server" OnClick="btnBorrar_Click" Text="Desactivar" Width="250px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnBorrar_ConfirmButtonExtender" runat="server" BehaviorID="btnBorrar_ConfirmButtonExtender" ConfirmText="Quiere Desactivar el Producto?" TargetControlID="btnBorrar" />
        </td>
        <td class="auto-style27">
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="250px" Enabled="False" />
        </td>
        <td class="auto-style27">
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar Catálogo" Width="250px" />
            </td>
    </tr>
    </table>
    <table class="auto-style6">
    <tr>
        <td class="auto-style8">
            <asp:GridView ID="grvProductosCentro" runat="server" AutoGenerateColumns="False" DataKeyNames="Icc" DataSourceID="SdsCatalogoCentroBuscarXIdCentroFormacion" class="grvGrilla" AllowPaging="True" AllowSorting="True" OnSelectedIndexChanged="grvProductosCentro_SelectedIndexChanged" Caption="Catálogo de Productos" PageSize="8">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="Icc" HeaderText="Icc" InsertVisible="False" ReadOnly="True" SortExpression="Icc" />
                    <asp:BoundField DataField="Ip" HeaderText="Ip" SortExpression="Ip" />
                    <asp:BoundField DataField="Codigo" HeaderText="Codigo" SortExpression="Codigo" >
                    </asp:BoundField>
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" >
                    </asp:BoundField>
                    <asp:BoundField DataField="PrecioMinimo" HeaderText="Minimo" SortExpression="PrecioMinimo" DataFormatString="{0:N0}" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="PrecioMaximo" HeaderText="Maximo" SortExpression="PrecioMaximo" DataFormatString="{0:N0}">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Medida" HeaderText="Medida" SortExpression="Medida" />
                    <asp:BoundField DataField="Clase" HeaderText="Clase" SortExpression="Clase" />
                    <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" >
                    <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>
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
            <asp:GridView ID="grvCatalogoCentro" runat="server" Visible="False" AutoGenerateColumns="False" DataKeyNames="Icc" DataSourceID="SdsCatalogoCentroBuscarXIdCentroFormacion" Caption="Catálogo de Productos del Centro de Formación">
                                <AlternatingRowStyle BackColor="#DCDCDC" />
                                <Columns>
                                    <asp:BoundField DataField="Codigo" HeaderText="Codigo" SortExpression="Codigo">
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre">
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PrecioMinimo" HeaderText="PrecioMinimo" SortExpression="PrecioMinimo" />
                                    <asp:BoundField DataField="PrecioMaximo" HeaderText="PrecioMaximo" SortExpression="PrecioMaximo" />
                                    <asp:BoundField DataField="Medida" HeaderText="Medida" SortExpression="Medida" />
                                    <asp:BoundField DataField="Clase" HeaderText="Clase" SortExpression="Clase" />
                                    <asp:BoundField DataField="CodigoFamilia" HeaderText="CodigoFamilia" SortExpression="CodigoFamilia" />
                                    <asp:BoundField DataField="NombreFamilia" HeaderText="NombreFamilia" SortExpression="NombreFamilia" />
                                    <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
                                </Columns>
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
<table class="auto-style28">
    <tr>
        <td>
            <asp:Panel ID="Panel1" runat="server">
                Escriba el Nombre del Producto - Como Mínimo Tres Caracteres en Singular - Luego haga Clic en Buscar.</asp:Panel>
        </td>
        <td>
            <asp:Panel ID="Panel2" runat="server">
                El Precio Mínimo: debe ser el menor valor en el que se vende en producto</asp:Panel>
        </td>
        <td>
                <asp:Panel ID="Panel3" runat="server">
                    El Precio Máximo: debe ser el mayor&nbsp; valor en el que se vende en producto</asp:Panel>
            </td>
        <td>
                <asp:HiddenField ID="hfPrecioMinimo" runat="server" Visible="False" />
            </td>
    </tr>
    <tr>
        <td>
            <asp:SqlDataSource ID="SdsNombreProducto" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_NombreProductoBuscar" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtNombreProducto" Name="NombreProducto" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
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
    </tr>
    <tr>
        <td>
                <asp:HiddenField ID="hfdExisteProducto" runat="server" />
        </td>
        <td>
            <asp:SqlDataSource ID="SdsCatalogoCentroBuscarXIdCentroFormacion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_CatalogoCentroBuscarXIdCentroFormacion" SelectCommandType="StoredProcedure" >
                <SelectParameters>
                    <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
        <td>
                <asp:HiddenField ID="hfdProductoCatalogo" runat="server" />
        </td>
        <td>
                <asp:HiddenField ID="hfdCatalogoCentro" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
                <asp:HiddenField ID="hfdInventariable" runat="server" />
        </td>
        <td>
                <asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
        </td>
        <td>
                <asp:HiddenField ID="hfPrecioMaximo" runat="server" Visible="False" />
        </td>
        <td>
                &nbsp;</td>
    </tr>
</table>
</asp:Content>
