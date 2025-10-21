<%@ Page Title="Juzgado" Language="C#" MasterPageFile="~/SiteCpp.Master" AutoEventWireup="true" CodeBehind="Juzgado.aspx.cs" Inherits="WebLiquidador.Paginas.CostasProcesales.Juzgado.Juzgado" %>

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
        .auto-style11 {
        height: 45px;
    }
        .auto-style12 {
            height: 47px;
        }
    </style>

    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="5">
                <h2>Juzgado -&nbsp; 
                <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                    &nbsp;</h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style12">
                Departamento<br />
                <asp:DropDownList ID="ddlDepartamento" runat="server" AutoPostBack="True" DataSourceID="SdsDepartamento" DataTextField="NombreDepartamento" DataValueField="IdDepartamento" Width="170px" OnDataBound="ddlDepartamento_DataBound">
                </asp:DropDownList>
                <br />
            </td>
            <td class="auto-style12">
                Municipio<br />
                <asp:DropDownList ID="ddlMunicipio" runat="server" Width="170px" AutoPostBack="True" DataSourceID="SdsMunicipoXDepartamento" DataTextField="NombreMunicipio" DataValueField="IdMunicipio" OnDataBound="ddlMunicipio_DataBound" OnSelectedIndexChanged="ddlMunicipio_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="auto-style12" colspan="2">
                Nombre del Juzgado<br />
                <asp:DropDownList ID="ddlJuzgado" runat="server" Width="340px" DataSourceID="SdsJuzgadosXMunicipio" DataTextField="Nombre" DataValueField="IdJuzgado" OnDataBound="ddlJuzgado_DataBound" AutoPostBack="True" OnSelectedIndexChanged="ddlJuzgado_SelectedIndexChanged">
                </asp:DropDownList>
                <br />
            </td>
            <td class="auto-style12">
                <asp:CheckBox ID="chbEsActivo" runat="server" Checked="True" Font-Bold="True" ForeColor="Maroon" Text="Activo" TextAlign="Left" ToolTip="Es Activo?" />
                </td>
        </tr>
        <tr>
            <td class="auto-style11">
                &nbsp;</td>
            <td class="auto-style11">
                &nbsp;</td>
            <td class="auto-style11" colspan="2">
                Nombre del Juzgado<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNombre" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="txtNombre" runat="server" Width="340px" MaxLength="200" Enabled="False" ></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtNombre_TextBoxWatermarkExtender" runat="server" BehaviorID="txtNombre_TextBoxWatermarkExtender" TargetControlID="txtNombre" WatermarkText="Nombre del Juzgado" />
            </td>
            <td class="auto-style11">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style13" colspan="5" style="background-color: #6E8A34">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style13">
                <asp:Button ID="btnAgregar" runat="server" OnClick="btnAgregar_Click" Text="Agregar" ValidationGroup="btnAgregar" Width="170px" Enabled="False" />
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
            <td class="auto-style10">
                <asp:GridView ID="grvJuzgado" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SdsJuzgado" Width="801px" PageSize="15" DataKeyNames="IdJuzgado" OnSelectedIndexChanged="grvJuzgado_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdJuzgado" HeaderText="IdJ" InsertVisible="False" ReadOnly="True" SortExpression="IdJuzgado" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="NombreDepartamento" HeaderText="Departamento" SortExpression="NombreDepartamento" />
                        <asp:BoundField DataField="NombreMunicipio" HeaderText="Municipio" SortExpression="NombreMunicipio" />
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
                <asp:GridView ID="grvJuzgado0" runat="server" AutoGenerateColumns="False" DataSourceID="SdsJuzgado" Width="716px" PageSize="15" Visible="False" DataKeyNames="IdJuzgado">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="IdJuzgado" HeaderText="IdJuzgado" InsertVisible="False" ReadOnly="True" SortExpression="IdJuzgado" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="NombreDepartamento" HeaderText="NombreDepartamento" SortExpression="NombreDepartamento" />
                        <asp:BoundField DataField="NombreMunicipio" HeaderText="NombreMunicipio" SortExpression="NombreMunicipio" />
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
                <asp:SqlDataSource ID="SdsJuzgado" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CostasProcesales].[Usp_BuscarJuzgado]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
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
                <asp:SqlDataSource ID="SdsJuzgadosXMunicipio" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_JuzgadoPorMunicipio" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlMunicipio" Name="IdMunicipio" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
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
                <asp:HiddenField ID="hfIdJuzgado" runat="server" Visible="False" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsDepartamento" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarDepartamento" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsMunicipoXDepartamento" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_MunicipiosPorDepartamento" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlDepartamento" Name="IdDepartamento" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
