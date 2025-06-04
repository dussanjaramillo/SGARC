<%@ Page Title="Deudor" Language="C#" MasterPageFile="~/SiteCpp.Master" AutoEventWireup="true" CodeBehind="Deudor.aspx.cs" Inherits="WebLiquidador.Paginas.CostasProcesales.Deudor.Deudor" %>

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
        .auto-style11 {
            height: 43px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="5">
                <h2>Deudor -&nbsp; 
                <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                    &nbsp;</h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style13">
                Identificación<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtIdentificacion" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="txtIdentificacion" runat="server" Width="170px" MaxLength="10"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtIdentificacion_TextBoxWatermarkExtender" runat="server" BehaviorID="txtIdentificacion_TextBoxWatermarkExtender" TargetControlID="txtIdentificacion" WatermarkText="Identificacion" />
                <Ajax:FilteredTextBoxExtender ID="txtIdentificacion_FilteredTextBoxExtender" runat="server" BehaviorID="txtIdentificacion_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=",." TargetControlID="txtIdentificacion" />
            </td>
            <td class="auto-style14">
                Deudor<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNombre" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
                <br /><asp:TextBox ID="txtNombre" runat="server" Width="170px" MaxLength="200" ></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtNombre_TextBoxWatermarkExtender" runat="server" BehaviorID="txtNombre_TextBoxWatermarkExtender" TargetControlID="txtNombre" WatermarkText="Nombre y Apellidos" />
            </td>
            <td class="auto-style19">
                Departamento<br />
                <asp:DropDownList ID="ddlDepartamento" runat="server" AutoPostBack="True" DataSourceID="SdsDepartamento" DataTextField="NombreDepartamento" DataValueField="IdDepartamento" OnDataBound="ddlDepartamento_DataBound" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged" Width="170px">
                </asp:DropDownList>
            </td>
            <td class="auto-style19">
                Municipio<br />
                <asp:DropDownList ID="ddlMunicipio" runat="server" Width="170px">
                </asp:DropDownList>
            </td>
            <td class="auto-style20">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style11">
                Dirección (Ubicación)<br />
                <asp:TextBox ID="txtDireccion" runat="server" Width="170px" MaxLength="100" ></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtDireccion_TextBoxWatermarkExtender" runat="server" BehaviorID="txtDireccion_TextBoxWatermarkExtender" TargetControlID="txtDireccion" WatermarkText="Dirección" />
            </td>
            <td class="auto-style11">
                Celular<br />
                <asp:TextBox ID="txtCelular" runat="server" Width="170px" MaxLength="10" ></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtCelular_TextBoxWatermarkExtender" runat="server" BehaviorID="txtCelular_TextBoxWatermarkExtender" TargetControlID="txtCelular" WatermarkText="Celular" />
            </td>
            <td class="auto-style11">
                Correo<br />
                <asp:TextBox ID="txtCorreo" runat="server" Width="170px" MaxLength="100" ></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtCorreo_TextBoxWatermarkExtender" runat="server" BehaviorID="txtCorreo_TextBoxWatermarkExtender" TargetControlID="txtCorreo" WatermarkText="Correo" />
            </td>
            <td class="auto-style11">
                <asp:CheckBox ID="chbEsActivo" runat="server" Checked="True" Font-Bold="True" ForeColor="Maroon" Text="Activo" TextAlign="Left" ToolTip="Es Activo?" />
            </td>
        </tr>
        <tr>
            <td class="auto-style13" colspan="5" style="background-color: #6E8A34">
                &nbsp;</td>
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
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style8">
                <asp:GridView ID="grvDeudor" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SdsDeudor" Width="1248px" DataKeyNames="IdDeudor" OnSelectedIndexChanged="grvDeudor_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdDeudor" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdDeudor" />
                        <asp:HyperLinkField DataNavigateUrlFields="Identificacion" DataNavigateUrlFormatString="~/Paginas/CostasProcesales/Obligacion/Obligacion.aspx?id={0}" DataTextField="Identificacion" HeaderText="Identificación" NavigateUrl="~/Paginas/CostasProcesales/Obligacion/Obligacion.aspx" Text="Identificación" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="Correo" HeaderText="Correo" SortExpression="Correo" />
                        <asp:BoundField DataField="Celular" HeaderText="Celular" SortExpression="Celular" />
                        <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion" />
                        <asp:BoundField DataField="NombreMunicipio" HeaderText="Municipio" SortExpression="NombreMunicipio" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
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
                <asp:GridView ID="grvDeudor0" runat="server" AutoGenerateColumns="False" DataSourceID="SdsDeudor" Width="1248px" PageSize="1" Visible="False" DataKeyNames="IdDeudor">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="IdDeudor" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdDeudor" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="Correo" HeaderText="Correo" SortExpression="Correo" />
                        <asp:BoundField DataField="Celular" HeaderText="Celular" SortExpression="Celular" />
                        <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion" />
                        <asp:BoundField DataField="NombreMunicipio" HeaderText="Municipio" SortExpression="NombreMunicipio" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
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
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarRegional" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfIdDeudor" runat="server" Visible="False" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsDeudor" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CostasProcesales].[Usp_BuscarDeudor_]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
