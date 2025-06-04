<%@ Page Title="Modificar Apoyo Emergencia Económica" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="FacturaModificar.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.InventarioAyudas.FacturaModificar" %>

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
            <td colspan="7">
                <h2>Modificar Apoyo Emergencia Económica -
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
            </td>

        </tr>
        <tr>
            <td class="auto-style10" colspan="7">
                <asp:GridView ID="grvFacturaXCentro" runat="server" AutoGenerateColumns="False" OnDataBound="grvFacturaXCentro_DataBound" class="grvGrilla" Caption="Apoyos Emergecia Económica Disponibles" AllowPaging="True" PageSize="15" AllowSorting="True" OnSelectedIndexChanged="grvFacturaXCentro_SelectedIndexChanged" DataSourceID="SdsFacturasXCentro" Width="1228px">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" >
                        </asp:BoundField>
                        <asp:BoundField DataField="NroApoyo" HeaderText="NroApoyo" SortExpression="NroApoyo" >
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" ReadOnly="True" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" SortExpression="FechaCrea" DataFormatString="{0:d}" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Anulada" HeaderText="Anulada" SortExpression="Anulada" ReadOnly="True" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
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
        <tr>
            <td class="auto-style10">Identificación<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" ControlToValidate="txtIdentificacion" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </td>
            <td class="auto-style10">Nombre<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" ControlToValidate="txtNombre" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </td>
            <td class="auto-style10">Dirección<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" ControlToValidate="txtDireccion" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </td>
            <td>Teléfono<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" ControlToValidate="txtTelefono" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </td>
            <td>Departamento<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" ControlToValidate="ddlDepartamento" InitialValue="-1" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </td>
            <td>Municipio<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" ControlToValidate="ddlMunicipio" InitialValue="-1" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:TextBox ID="txtIdentificacion" runat="server" Width="170px" MaxLength="16" PlaceHolder="Identificación" ToolTip="Escriba la Identificación Sin Digito de Verificación"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtIdentificacion_FilteredTextBoxExtender" runat="server" BehaviorID="txtIdentificacion_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=",." TargetControlID="txtIdentificacion" />
            </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtNombre" runat="server" Width="170px" MaxLength="100" PlaceHolder="Nombre del Aprendiz" ToolTip="Escriba el Nombre del Aprendiz"></asp:TextBox>
            </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtDireccion" runat="server" Width="170px" MaxLength="100" PlaceHolder="Dirección del Aprendiz" ToolTip="Escriba la Dirección del Aprendiz" ></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtTelefono" runat="server" Width="170px" MaxLength="100" PlaceHolder="Número Telefónico" ToolTip="Escriba el Número Telefónico"></asp:TextBox>
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
            <td class="auto-style10" colspan="3">
                Contacto<br />
                <asp:TextBox ID="txtContacto" runat="server" MaxLength="100" PlaceHolder="Contacto" Width="510px"></asp:TextBox>
            </td>
            <td class="auto-style10" colspan="3">
                Referencia<br />
                <asp:TextBox ID="txtReferencia" runat="server" MaxLength="100" PlaceHolder="Referencia" Width="510px"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style20" style="background-color: #465767" colspan="7">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style20">
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnGuardar_ConfirmButtonExtender" runat="server" BehaviorID="btnGuardar_ConfirmButtonExtender" ConfirmText="Esta Seguro?" TargetControlID="btnGuardar" />
            </td>
            <td class="auto-style10">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td class="auto-style12">
                &nbsp;</td>
            <td class="auto-style9">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
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
                &nbsp;</td>
            <td>
                <asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsTipoCliente" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarTipoCliente]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsFacturasXCentro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaAyudasXCentro_]" SelectCommandType="StoredProcedure">
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfNumeroFactura" runat="server" />
            </td>
            <td>
                &nbsp;</td>
            <td>
                <asp:HiddenField ID="hfValorTotalFactura" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfIdTipoCliente" runat="server" />
            </td>
        </tr>
        </table>
</asp:Content>
