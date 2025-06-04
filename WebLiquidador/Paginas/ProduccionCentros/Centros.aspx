<%@ Page Title="Centros de Formación" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="Centros.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Centros" %>

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
        .auto-style10 {
            height: 21px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="6">
                <h2>Centros de Formación -&nbsp; 
                <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                    &nbsp;</h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style13">
                Código<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCodigoCentroFormacion" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="txtCodigoCentroFormacion" runat="server" Width="170px" MaxLength="4"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtCodigoCentroFormacion_TextBoxWatermarkExtender" runat="server" BehaviorID="txtCodigoCentroFormacion_TextBoxWatermarkExtender" TargetControlID="txtCodigoCentroFormacion" WatermarkText="Código Centro" />
                <Ajax:FilteredTextBoxExtender ID="txtCodigoCentroFormacion_FilteredTextBoxExtender" runat="server" BehaviorID="txtCodigoCentroFormacion_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=",." TargetControlID="txtCodigoCentroFormacion" />
            </td>
            <td class="auto-style14">
                Nombre Centro<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNombreCentroFormacion" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
                <br /><asp:TextBox ID="txtNombreCentroFormacion" runat="server" Width="170px" MaxLength="200" ></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtNombreCentroFormacion_TextBoxWatermarkExtender" runat="server" BehaviorID="txtNombreCentroFormacion_TextBoxWatermarkExtender" TargetControlID="txtNombreCentroFormacion" WatermarkText="Nombre del Centro" />
            </td>
            <td class="auto-style17">
                Regional<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlRegional" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar" InitialValue="-1"></asp:RequiredFieldValidator>
                <br />
                <asp:DropDownList ID="ddlRegional" runat="server" AutoPostBack="True" DataSourceID="SdsRegional" DataTextField="NombreRegional" DataValueField="IdRegional" OnDataBound="ddlRegional_DataBound" Width="170px">
                </asp:DropDownList>
            </td>
            <td class="auto-style19">
                Departamento<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlDepartamento" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar" InitialValue="-1"></asp:RequiredFieldValidator>
                <br />
                <asp:DropDownList ID="ddlDepartamento" runat="server" AutoPostBack="True" DataSourceID="SdsDepartamento" DataTextField="NombreDepartamento" DataValueField="IdDepartamento" OnDataBound="ddlDepartamento_DataBound" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged" Width="170px">
                </asp:DropDownList>
            </td>
            <td class="auto-style20">
                Municipio<br />
                <asp:DropDownList ID="ddlMunicipio" runat="server" Width="170px">
                </asp:DropDownList>
            </td>
            <td class="auto-style16">
                <asp:CheckBox ID="chbEstadoEmergencia" runat="server" Font-Bold="True" ForeColor="Maroon" Text="Emergencia Económica" TextAlign="Left" ToolTip="Está en Apoyo de Emergencia" />
            </td>
        </tr>
        <tr>
            <td class="auto-style13">
                Dirección<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlMunicipio" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar" InitialValue="-1"></asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="txtDireccion" runat="server" Width="170px" MaxLength="100" ></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtDireccion_TextBoxWatermarkExtender" runat="server" BehaviorID="txtDireccion_TextBoxWatermarkExtender" TargetControlID="txtDireccion" WatermarkText="Dirección" />
            </td>
            <td class="auto-style14">
                Conmutador<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtDireccion" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="txtConmutador" runat="server" Width="170px" MaxLength="100" ></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtConmutador_TextBoxWatermarkExtender" runat="server" BehaviorID="txtConmutador_TextBoxWatermarkExtender" TargetControlID="txtConmutador" WatermarkText="Conmutador" />
            </td>
            <td class="auto-style17">
                Fax<asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtFax" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="txtFax" runat="server" Width="170px" MaxLength="100" ></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtFax_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFax_TextBoxWatermarkExtender" TargetControlID="txtFax" WatermarkText="Fax" />
            </td>
            <td class="auto-style19">
                Indicativo<asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtIndicativo" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="txtIndicativo" runat="server" Width="170px" MaxLength="2" ></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtIndicativo_TextBoxWatermarkExtender" runat="server" BehaviorID="txtIndicativo_TextBoxWatermarkExtender" TargetControlID="txtIndicativo" WatermarkText="Indicativo" />
                <Ajax:FilteredTextBoxExtender ID="txtIndicativo_FilteredTextBoxExtender" runat="server" BehaviorID="txtIndicativo_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtIndicativo" />
            </td>
            <td class="auto-style20">
                Extensión<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtExtension" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="txtExtension" runat="server" Width="170px" MaxLength="100" ></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtExtension_TextBoxWatermarkExtender" runat="server" BehaviorID="txtExtension_TextBoxWatermarkExtender" TargetControlID="txtExtension" WatermarkText="Extension" />
            </td>
            <td class="auto-style16">
                <asp:CheckBox ID="chbEsActivo" runat="server" Checked="True" Font-Bold="True" ForeColor="Maroon" Text="Activo" TextAlign="Left" ToolTip="Es Activo?" />
            </td>
        </tr>
        <tr>
            <td class="auto-style13">
                Link
                Wompi Pagos Rapidos</td>
            <td class="auto-style14">
                &nbsp;</td>
            <td class="auto-style17">
                Link Wompi PreFactura</td>
            <td class="auto-style19">
                &nbsp;</td>
            <td class="auto-style20">
                &nbsp;</td>
            <td class="auto-style16">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:TextBox ID="txtWompiPagosRapidos" runat="server" PlaceHolder="Link Wompi Pagos Rapidos" Width="340px" MaxLength="100" ></asp:TextBox>
            </td>
            <td class="auto-style17" colspan="2">
                <asp:TextBox ID="txtLinkWompi" runat="server" Width="340px" PlaceHolder="Link Wompi Pagos Prefactura" MaxLength="100" ></asp:TextBox>
            </td>
            <td class="auto-style20">
                &nbsp;</td>
            <td class="auto-style16">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style13">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td class="auto-style14">
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" Enabled="False" />
            </td>
            <td class="auto-style17">
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
            </td>
            <td class="auto-style19">
                <asp:DropDownList ID="ddlTipoArchivo" runat="server" Width="170px">
                    <asp:ListItem Value="2" Selected="True">Excel</asp:ListItem>
                    <asp:ListItem Value="1">Txt</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="auto-style20">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td class="auto-style16"></td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style8">
                <asp:GridView ID="grvCentroFormacion" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SdsCentroFormacion" OnSelectedIndexChanged="grvCentroFormacion_SelectedIndexChanged" Width="1248px">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                        <asp:BoundField DataField="Regional" HeaderText="Regional" SortExpression="Regional" />
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" SortExpression="Codigo" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="Municipio" HeaderText="Municipio" SortExpression="Municipio" />
                        <asp:BoundField DataField="LinkWompi" HeaderText="LinkWompiPreFactura" SortExpression="LinkWompi" />
                        <asp:BoundField DataField="EstadoEmergencia" HeaderText="E.E." SortExpression="EstadoEmergencia" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#CCCCCC" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#465767" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
                <br />
                <asp:GridView ID="grvCentroFormacion0" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SdsCentroFormacion" OnSelectedIndexChanged="grvCentroFormacion_SelectedIndexChanged" Width="1248px" PageSize="15" Visible="False">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                        <asp:BoundField DataField="Regional" HeaderText="Regional" SortExpression="Regional" />
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" SortExpression="Codigo" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="Municipio" HeaderText="Municipio" SortExpression="Municipio" />
                        <asp:BoundField DataField="WompiPagosRapidos" HeaderText="WompiPagosRapidos" SortExpression="WompiPagosRapidos" />
                        <asp:BoundField DataField="LinkWompi" HeaderText="LinkWompi" SortExpression="LinkWompi" />
                        <asp:BoundField DataField="EstadoEmergencia" HeaderText="E.E." SortExpression="EstadoEmergencia" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#CCCCCC" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#465767" Font-Bold="True" ForeColor="White" />
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
                <asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
            </td>
            <td>
                &nbsp;</td>
            <td>
                <asp:SqlDataSource ID="SdsSector" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarSector" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfCentroFormacion" runat="server" Visible="False" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsCentroFormacion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarCentroFormacion" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarRegional" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
