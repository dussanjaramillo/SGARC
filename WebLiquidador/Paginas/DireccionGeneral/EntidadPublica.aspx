<%@ Page Title="Entidad Publica" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EntidadPublica.aspx.cs" Inherits="WebLiquidador.Paginas.DireccionGeneral.EntidadPublica" %>

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
            <td colspan="5">
                <h2>Entidad Publica - Planilla Unica&nbsp; 
                <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                    &nbsp;</h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style8">Identificación</td>
            <td class="auto-style12">Reciproco</td>
            <td colspan="3">Nombre Entidad Pública</td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:TextBox ID="txtIdentificacion" runat="server" Width="170px" MaxLength="16" PlaceHolder="Identificación"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtIdentificacion_FilteredTextBoxExtender" runat="server" BehaviorID="txtIdentificacion_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtIdentificacion" InvalidChars=".," />
            </td>
            <td class="auto-style12">
                <asp:TextBox ID="txtReciproco" runat="server" Width="170px" MaxLength="16" PlaceHolder="Recíproco"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtReciproco_FilteredTextBoxExtender" runat="server" BehaviorID="txtReciproco_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtReciproco" />
            </td>
            <td colspan="3">
                <asp:TextBox ID="txtNombreEntidadPublica" runat="server" Width="540px" MaxLength="200" PlaceHolder="Nombre Entidad Pública"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtNombreEntidadPublica_FilteredTextBoxExtender" runat="server" BehaviorID="txtNombreEntidadPublica_FilteredTextBoxExtender" FilterType="Custom, Numbers, UppercaseLetters, LowercaseLetters" TargetControlID="txtNombreEntidadPublica" ValidChars="ÑñÁÉÍÓÚáéíóú -.ü" />
            </td>
        </tr>
        <tr>
            <td class="auto-style8">Departamento</td>
            <td class="auto-style12">Municipio</td>
            <td colspan="3">Dirección</td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:DropDownList ID="ddlDepartamento" runat="server" AutoPostBack="True" DataSourceID="SdsDepartamento" DataTextField="NombreDepartamento" DataValueField="IdDepartamento" OnDataBound="ddlDepartamento_DataBound" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged" Width="170px">
                </asp:DropDownList>
            </td>
            <td class="auto-style12">
                <asp:DropDownList ID="ddlMunicipio" runat="server" Width="170px">
                </asp:DropDownList>
            </td>
            <td colspan="3">
                <asp:TextBox ID="txtDireccion" runat="server" Width="540px" MaxLength="255" PlaceHolder="Dirección"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style8">Teléfono</td>
            <td class="auto-style12">Fax</td>
            <td colspan="3">Correo Electrónico</td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:TextBox ID="txtTelefono" runat="server" Width="170px" MaxLength="255" PlaceHolder="Teléfono"></asp:TextBox>
            </td>
            <td class="auto-style12">
                <asp:TextBox ID="txtFax" runat="server" Width="170px" MaxLength="255" PlaceHolder="Fax"></asp:TextBox>
            </td>
            <td colspan="3">
                <asp:TextBox ID="txtEmail" runat="server" Width="540px" MaxLength="60" PlaceHolder="Correo Electrónico"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style10">Sector</td>
            <td class="auto-style13"></td>
            <td class="auto-style11" colspan="3"></td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:DropDownList ID="ddlSector" runat="server" Width="170px" OnDataBound="ddlSector_DataBound" DataSourceID="SdsSector" DataTextField="NombreSector" DataValueField="IdSector">
                </asp:DropDownList>
            </td>
            <td class="auto-style12">
                <asp:CheckBox ID="chbEsActivo" runat="server" Checked="True" Font-Bold="True" ForeColor="Maroon" Text="Activo" TextAlign="Left" ToolTip="Es Activo?" />
            </td>
            <td colspan="3">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" colspan="5" style="background-color: #FF9900">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td class="auto-style12">
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" Enabled="False" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
            </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td class="auto-style8" colspan="5">
                <asp:GridView ID="grvEntidadPublica" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IdEntidadPublica" DataSourceID="SdsBuscarEntidadPublica" OnSelectedIndexChanged="grvEntidadPublica_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdEntidadPublica" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdEntidadPublica" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Reciproco" HeaderText="Reciproco" SortExpression="Reciproco" />
                        <asp:BoundField DataField="NombreEntidadPublica" HeaderText="Nombre Entidad Publica" SortExpression="NombreEntidadPublica" />
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
                <asp:HiddenField ID="hfEntidadPublica" runat="server" Visible="False" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsSector" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarSector" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsBuscarEntidadPublica" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarEntidadPublica1" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
