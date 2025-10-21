<%@ Page Title="Producto por Nombre y/o Código" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="NombreProducto.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Catalogo.NombreProducto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td><h2>Consulta de Producto por:
                <asp:DropDownList ID="ddlProducto" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="#FF3300" Width="170px">
                    <asp:ListItem Selected="True" Value="1">Nombre</asp:ListItem>
                    <asp:ListItem Value="2">Código</asp:ListItem>
                </asp:DropDownList>
&nbsp;</h2></td>
        </tr>
        </table>
    <table class="auto-style9">
        <tr>
            <td class="auto-style10">
                <asp:TextBox ID="txtNombreProducto" runat="server" MaxLength="30" ValidationGroup="btnBuscar" Width="270px"></asp:TextBox>
                <Ajax:BalloonPopupExtender ID="txtNombreProducto_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel1" BehaviorID="txtNombreProducto_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" ExtenderControlID="" TargetControlID="txtNombreProducto" BalloonSize="Medium">
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
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNombreProducto" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        </table>
    <table class="auto-style9">
        <tr>
            <td colspan="6">
            <asp:Panel ID="Panel1" runat="server">
                Escriba el Nombre del Producto - Como Mínimo Tres Caracteres en Singular O el Código del Producto - Solo Números (10) - Luego haga Clic en Buscar.</asp:Panel>
                <asp:GridView ID="grvNombreProducto" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" class="grvGrilla" AllowPaging="True" AllowSorting="True" Width="1162px" AutoGenerateColumns="False" OnDataBound="grvNombreProducto_DataBound" DataSourceID="SdsNombreProducto">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" SortExpression="Codigo" />
                        <asp:BoundField DataField="NombreProducto" HeaderText="Producto" SortExpression="NombreProducto" />
                        <asp:BoundField DataField="NombreClase" HeaderText="Clase" SortExpression="NombreClase" />
                        <asp:BoundField DataField="NombreFamilia" HeaderText="Familia" SortExpression="NombreFamilia" />
                        <asp:BoundField DataField="NombreSegmento" HeaderText="Segmento" SortExpression="NombreSegmento" />
                        <asp:BoundField DataField="NombreGrupo" HeaderText="Grupo" SortExpression="NombreGrupo" />
                        <asp:BoundField DataField="Inventariable" HeaderText="In" SortExpression="Inventariable" />
                        <asp:BoundField DataField="EsActivo" HeaderText="Activo" SortExpression="EsActivo" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
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
                <asp:GridView ID="grvNombreProducto0" runat="server" CellPadding="4" class="grvGrilla" Width="1162px" AutoGenerateColumns="False" OnDataBound="grvNombreProducto_DataBound" DataSourceID="SdsProductoSiif" Caption="Código de Producto o Servicio Siif Nación" ForeColor="#333333">
                    <AlternatingRowStyle BackColor="Gainsboro" />
                    <Columns>
                        <asp:BoundField DataField="Nivel1" HeaderText="Nivel1" SortExpression="Nivel1" />
                        <asp:BoundField DataField="Nivel2" HeaderText="Nivel2" SortExpression="Nivel2" />
                        <asp:BoundField DataField="Nivel3" HeaderText="Nivel3" SortExpression="Nivel3" />
                        <asp:BoundField DataField="Nivel4" HeaderText="Nivel4" SortExpression="Nivel4" />
                        <asp:BoundField DataField="Nivel5" HeaderText="Nivel5" SortExpression="Nivel5" />
                        <asp:BoundField DataField="Nivel6" HeaderText="Nivel6" SortExpression="Nivel6" />
                        <asp:BoundField DataField="Nivel7" HeaderText="Nivel7" SortExpression="Nivel7" />
                        <asp:BoundField DataField="Nivel8" HeaderText="Nivel8" SortExpression="Nivel8" >
                        </asp:BoundField>
                        <asp:BoundField DataField="DESCRIPCION" HeaderText="DESCRIPCION" SortExpression="DESCRIPCION" />
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsNombreProducto" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_NombreProductoBuscarXTodos]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtNombreProducto" Name="NombreProducto" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="ddlProducto" Name="Opcion" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
            <td>
                <asp:SqlDataSource ID="SdsProductoSiif" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_ProductoCatalogoSiifNacion]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtNombreProducto" Name="CodigoProducto" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
