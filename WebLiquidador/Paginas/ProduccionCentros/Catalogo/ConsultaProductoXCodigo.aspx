<%@ Page Title="Producto por Código" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ConsultaProductoXCodigo.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Catalogo.ConsultaProductoXCodigo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td><h2>Consulta de Producto por Código</h2></td>
        </tr>
        </table>
    <table class="auto-style9">
        <tr>
            <td class="auto-style10">Código del Producto</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:TextBox ID="txtCodigoProducto" runat="server" MaxLength="10" ValidationGroup="btnBuscar" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtCodigoProducto_FilteredTextBoxExtender" runat="server" BehaviorID="txtCodigoProducto_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtCodigoProducto" />
                <Ajax:BalloonPopupExtender ID="txtCodigoProducto_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel1" BehaviorID="txtCodigoProducto_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" ExtenderControlID="" TargetControlID="txtCodigoProducto">
                </Ajax:BalloonPopupExtender>
            </td>
            <td>
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="250px" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="250px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCodigoProducto" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        </table>
    <table class="auto-style9">
        <tr>
            <td colspan="5">
            <asp:Panel ID="Panel1" runat="server">
                Escriba el Código del Producto - Como Mínimo 10 Caracteres - Luego haga Clic en Buscar.</asp:Panel>
                <asp:GridView ID="grvNombreProducto" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" class="grvGrilla" AllowPaging="True" AllowSorting="True" Width="1162px" AutoGenerateColumns="False" DataSourceID="SdsCodigoProducto" OnDataBound="grvNombreProducto_DataBound" DataKeyNames="IdProducto">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="IdProducto" HeaderText="Id" SortExpression="IdProducto" InsertVisible="False" ReadOnly="True" />
                        <asp:BoundField DataField="CodigoProducto" HeaderText="Codigo" SortExpression="CodigoProducto" />
                        <asp:BoundField DataField="NombreProducto" HeaderText="Producto" SortExpression="NombreProducto" />
                        <asp:BoundField DataField="NombreClase" HeaderText="Clase" SortExpression="NombreClase" />
                        <asp:BoundField DataField="NombreFamilia" HeaderText="Familia" SortExpression="NombreFamilia" />
                        <asp:BoundField DataField="NombreSegmento" HeaderText="Segmento" SortExpression="NombreSegmento" />
                        <asp:BoundField DataField="NombreGrupo" HeaderText="Grupo" SortExpression="NombreGrupo" />
                        <asp:BoundField DataField="Inventariable" HeaderText="In" SortExpression="Inventariable" >
                        </asp:BoundField>
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
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
            </td>
        </tr>
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsCodigoProducto" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[UNSPSC].[Usp_BuscarProductoXCodigoProducto_]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtCodigoProducto" Name="CodigoProducto" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfExiste" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
