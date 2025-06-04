<%@ Page Title="Inventario Entradas - Apoyo Emergencia Económica" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="InventarioEntrada.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.InventarioAyudas.InventarioEntrada" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <table class="auto-style8">
        <tr>
            <td><h2>Inventario Entradas - Apoyo Emergencia Económica
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2></td>
            <td>&nbsp;</td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td class="auto-style9" colspan="2">Productos Inventariables Disponibles<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlProducto" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnAgregar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style9">Cantidad en Existencia</td>
            <td class="auto-style9">Unidad de Medida</td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:DropDownList ID="ddlProducto" runat="server" Width="340px" AutoPostBack="True" OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged" DataSourceID="SdsProductosXCentrro" DataTextField="NombreProducto" DataValueField="IdProducto" OnDataBound="ddlProducto_DataBound">
                </asp:DropDownList>
                <Ajax:BalloonPopupExtender ID="ddlProducto_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel5" BehaviorID="ddlProducto_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="ddlProducto" BalloonSize="Medium">
                </Ajax:BalloonPopupExtender>
            </td>
            <td>
                <asp:TextBox ID="txtCantidadExistencia" runat="server" Enabled="False" Font-Bold="True" ForeColor="Maroon" Width="170px"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtNombreUnidadMedida" runat="server" Enabled="False" ForeColor="Maroon" Width="170px" Font-Bold="True"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                &nbsp;</td>
            <td colspan="2">Cantidad<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtCantidad" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAgregar" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtCantidad" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnRestar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnAgregar" runat="server" OnClick="btnAgregar_Click" Text="+Agregar" ValidationGroup="btnAgregar" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnAgregar_ConfirmButtonExtender" runat="server" BehaviorID="btnAgregar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnAgregar" />
            </td>
            <td>
                <asp:Button ID="btnRestar" runat="server" OnClick="btnRestar_Click" Text="- Restar" ValidationGroup="btnRestar" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnRestar_ConfirmButtonExtender" runat="server" BehaviorID="btnRestar_ConfirmButtonExtender" ConfirmText="" TargetControlID="btnRestar" />
            </td>
            <td>
                <asp:TextBox ID="txtCantidad" PlaceHolder="Escriba la Cantidad" runat="server" Width="170px" Enabled="False" BackColor="#FFFFCC"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtCantidad_FilteredTextBoxExtender" runat="server" BehaviorID="txtCantidad_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtCantidad" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="340px" />
            </td>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:GridView ID="grvInventario" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" Width="100%" BorderStyle="None" CellPadding="3" DataSourceID="SdsInventarioProductos" ForeColor="#333333">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:BoundField DataField="CodigoProducto" HeaderText="Codigo" SortExpression="CodigoProducto" />
                        <asp:BoundField DataField="NombreProducto" HeaderText="Producto" SortExpression="NombreProducto" />
                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" SortExpression="Cantidad" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Usuario" HeaderText="Usuario" SortExpression="Usuario" />
                        <asp:BoundField DataField="FechaModifica" DataFormatString="{0:d}" HeaderText="FechaModifica" SortExpression="FechaModifica" />
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#000066" />
                    <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                    <RowStyle ForeColor="#000066" />
                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#00547E" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td colspan="3">
                <asp:Panel ID="Panel5" runat="server">
                    Seleccione un Producto - Para facilitar la busqueda escriba la primera letra. La Cantidad en Existencia que se Muestra Corresponde al Día Anterior</asp:Panel>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsProductosXCentrro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarProductoInventariableXCentro]" SelectCommandType="StoredProcedure">
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
                <asp:HiddenField ID="hfIdInventario" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsInventarioProductos" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarInventarioProductosAyudas]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hdIdUnidadMedida" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hfNombreUsuario" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfIdTipoMovimiento" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfNombreTipoMovimiento" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfIdUsuario" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hdEstadoEmergencia" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
