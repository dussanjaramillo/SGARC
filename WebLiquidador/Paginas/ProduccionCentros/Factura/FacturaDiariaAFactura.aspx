<%@ Page Title="Prefactura Diaria A Prefactura Definitiva" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="FacturaDiariaAFactura.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Factura.FacturaDiariaAFactura" %>

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

        .auto-style9 {
            width: 170px;
        }

        .auto-style10 {
            height: 20px;
        }

        .auto-style20 {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="7">
                <h2>Prefactura Diaria A Prefactura Definitiva:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
            </td>

        </tr>
        <tr>
            <td class="auto-style10">Identificación</td>
            <td class="auto-style10">Nombre Comprador</td>
            <td class="auto-style10">Dirección</td>
            <td class="auto-style10">Teléfono</td>
            <td>Departamento</td>
            <td>Municipio</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:TextBox ID="txtIdentificacion" runat="server" Width="170px" MaxLength="16" AutoPostBack="True"></asp:TextBox>
            </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtNombre" runat="server" Width="170px" MaxLength="100"></asp:TextBox>
            </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtDireccion" runat="server" Width="170px" MaxLength="100"></asp:TextBox>
            </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtTelefono" runat="server" Width="170px" MaxLength="100"></asp:TextBox>
            </td>
            <td>
                <asp:DropDownList ID="ddlDepartamento" runat="server" AutoPostBack="True" DataSourceID="SdsDepartamento" DataTextField="NombreDepartamento" DataValueField="IdDepartamento" OnDataBound="ddlDepartamento_DataBound" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged" Width="170px">
                </asp:DropDownList>
            </td>
            <td>
                <asp:DropDownList ID="ddlMunicipio" runat="server" Width="170px">
                </asp:DropDownList>
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
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td class="auto-style10" colspan="2">
                <h1>Valor de la PreFactura Diaria:</h1>
            </td>
            <td class="auto-style9">
                <asp:TextBox ID="txtValorFactura" runat="server" BackColor="#FFFF99" Enabled="False" Font-Bold="True" ForeColor="Maroon" Font-Size="Medium" CssClass="alineacionDerecha" Width="170px"></asp:TextBox>
            </td>
            <td>
                <asp:Button ID="btnEjecutar" runat="server" OnClick="btnEjecutar_Click" Text="Ejecutar" Width="170px" Enabled="False" />
                <Ajax:BalloonPopupExtender ID="btnEjecutar_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel1" BehaviorID="btnEjecutar_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="btnEjecutar">
                </Ajax:BalloonPopupExtender>
                <Ajax:ConfirmButtonExtender ID="btnEjecutar_ConfirmButtonExtender" runat="server" BehaviorID="btnEjecutar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnEjecutar" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style20" colspan="7">
                <asp:GridView ID="grvProductosCentro" runat="server" AutoGenerateColumns="False" DataKeyNames="Item" class="grvGrilla"  AllowSorting="True" Caption="Productos Seleccionados" OnDataBound="grvProductosCentro_DataBound">
                    <Columns>
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
                <asp:Panel ID="Panel1" runat="server">
                    Genera la Prefactura Numerada
                </asp:Panel>
            </td>
            <td>&nbsp;</td>
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
                <asp:HiddenField ID="hfUltimoItem" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsProductosXCentrro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarProductoxCentro]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsCatalogoCentroBuscarXIdCentroFormacion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_CatalogoCentroBuscarXIdCentroFormacion" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:HiddenField ID="hfdIdFactura" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsDepartamento" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarDepartamento" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfFilas" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
