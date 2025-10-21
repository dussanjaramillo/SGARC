<%@ Page Title="Catálogo UNSPSC" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="Catalogo.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Catalogo.Catalogo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style10">
        <tr>
            <td>
                <h2><span lang="es">Productos y Servicios Estándar de las Naciones Unidas</span> - 
            <asp:HyperLink ID="HyperLink1" runat="server" target="_blank" NavigateUrl="https://www.unspsc.org/">UNSPSC</asp:HyperLink>
             &nbsp;-&nbsp;<asp:HyperLink ID="HyperLink2" target="_blank" runat="server" NavigateUrl="https://www.colombiacompra.gov.co/clasificador-de-bienes-y-Servicios">Colombia Compra Eficiente</asp:HyperLink>
                &nbsp;</h2>
            </td>
        </tr>
    </table>
    <table class="auto-style11">
        <tr>
            <td class="auto-style15">Grupo</td>
            <td class="auto-style15">Segmento</td>
            <td>Familia</td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:DropDownList ID="ddlGrupo" runat="server" DataSourceID="SdsGrupo" DataTextField="NombreGrupo" DataValueField="IdGrupo" AutoPostBack="True" OnDataBound="ddlGrupo_DataBound" Width="350px" OnSelectedIndexChanged="ddlGrupo_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="auto-style10">
                <asp:DropDownList ID="ddlSegmento" runat="server" DataSourceID="SdsSegmento" DataTextField="NombreSegmento" DataValueField="IdSegmento" AutoPostBack="True" OnDataBound="ddlSegmento_DataBound" Width="350px" OnSelectedIndexChanged="ddlSegmento_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="auto-style16">
                <asp:DropDownList ID="ddlFamilia" runat="server" DataSourceID="SdsFamiliaXSegmento" DataTextField="NombreFamilia" DataValueField="IdFamilia" AutoPostBack="True" OnDataBound="ddlFamilia_DataBound" Width="350px" OnSelectedIndexChanged="ddlFamilia_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>Clase</td>
            <td>Producto</td>
            <td></td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:DropDownList ID="ddlClase" runat="server" AutoPostBack="True" DataSourceID="SdsClaseXFamilia" DataTextField="NombreClase" DataValueField="IdClase" OnDataBound="ddlClase_DataBound" Width="350px" OnSelectedIndexChanged="ddlClase_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="auto-style10" colspan="2">
                <asp:DropDownList ID="ddlProducto" runat="server" DataSourceID="SdsProductoXClase" DataTextField="NombreProducto" DataValueField="IdProducto" OnDataBound="ddlProducto_DataBound" Width="700px" AutoPostBack="True" OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="auto-style21">Descripción del Producto</td>
            <td class="auto-style21">&nbsp;</td>
            <td class="auto-style21">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style21" colspan="3">
                <asp:DropDownList ID="ddlDescripcionProducto" runat="server" DataSourceID="SdsBuscarXCodigoProducto" DataTextField="DescripcionProducto" DataValueField="IdProducto" Width="1050px">
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style6">Codigo</td>
            <td class="auto-style6" colspan="2">Nombre Producto</td>
            <td class="auto-style6">Descripción del Producto</td>
        </tr>
        <tr>
            <td class="auto-style6">
                <asp:TextBox ID="txtCodigoProducto" runat="server" MaxLength="10" Width="170px" Enabled="False"></asp:TextBox>
            </td>
            <td class="auto-style6">
                <asp:TextBox ID="txtNombreProducto" runat="server" MaxLength="250" Width="425px" Enabled="False"></asp:TextBox>
            </td>
            <td class="auto-style6" colspan="2">
                <asp:TextBox ID="txtDescripcionProducto" runat="server" MaxLength="250" Width="425px" Enabled="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style13">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCodigoProducto" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style13" colspan="2">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNombreProducto" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style13">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDescripcionProducto" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
        </tr>
        </table>
    <table class="auto-style12">
        <tr>
            <td class="auto-style6">Inventariable</td>
            <td class="auto-style6">Seleccione la Acción</td>
            <td class="auto-style6">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style6">
                <asp:DropDownList ID="ddlInventariable" runat="server" Width="170px" Enabled="False">
                    <asp:ListItem>Si</asp:ListItem>
                    <asp:ListItem>No</asp:ListItem>
                </asp:DropDownList>
                </td>
            <td class="auto-style6">
                <asp:DropDownList ID="ddlAccion" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlAccion_SelectedIndexChanged" Width="170px" Enabled="False">
                    <asp:ListItem Value="1">Modificar</asp:ListItem>
                    <asp:ListItem Value="2">Agregar</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="auto-style6">
                <asp:CheckBox ID="chbEsActivo" runat="server" Checked="True" Font-Bold="True" ForeColor="Maroon" Text="Activo" TextAlign="Left" Enabled="False" />
            </td>
        </tr>
        <tr>
            <td class="auto-style6">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlInventariable" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" InitialValue="-1"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style6">&nbsp;</td>
            <td class="auto-style6">
                &nbsp;</td>
        </tr>
        </table>
    <table class="auto-style9">
        <tr>
            <td class="auto-style22">
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" Width="170px" ValidationGroup="btnGuardar" Enabled="False" />
            </td>
            <td class="auto-style24">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>
                <asp:DropDownList ID="ddlTipoArchivo" runat="server" Width="170px">
                    <asp:ListItem Value="1" Selected="True">Txt</asp:ListItem>
                    <asp:ListItem Value="2">Excel</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
            </td>
        </tr>
    </table>
    <table class="auto-style6">
        <tr>
            <td colspan="7">
                <asp:GridView ID="grvCatalogoUNSPSC" runat="server" DataSourceID="SdsCatalogoUNSPSC" AutoGenerateColumns="False" Visible="False">
                    <Columns>
                        <asp:BoundField DataField="CodigoProducto" HeaderText="CodigoProducto" SortExpression="CodigoProducto" />
                        <asp:BoundField DataField="NombreProducto" HeaderText="NombreProducto" SortExpression="NombreProducto" />
                        <asp:BoundField DataField="CodigoClase" HeaderText="CodigoClase" SortExpression="CodigoClase" />
                        <asp:BoundField DataField="NombreClase" HeaderText="NombreClase" SortExpression="NombreClase" />
                        <asp:BoundField DataField="CodigoFamilia" HeaderText="CodigoFamilia" SortExpression="CodigoFamilia" />
                        <asp:BoundField DataField="NombreFamilia" HeaderText="NombreFamilia" SortExpression="NombreFamilia" />
                        <asp:BoundField DataField="CodigoSegmento" HeaderText="CodigoSegmento" SortExpression="CodigoSegmento" />
                        <asp:BoundField DataField="NombreSegmento" HeaderText="NombreSegmento" SortExpression="NombreSegmento" />
                        <asp:BoundField DataField="CodigoGrupo" HeaderText="CodigoGrupo" SortExpression="CodigoGrupo" />
                        <asp:BoundField DataField="NombreGrupo" HeaderText="NombreGrupo" SortExpression="NombreGrupo" />
                        <asp:BoundField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
                        <asp:BoundField DataField="Inventariable" HeaderText="Inventariable" SortExpression="Inventariable" />
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
            <td>
                <asp:SqlDataSource ID="SdsGrupo" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[Usp_BuscarGrupo]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsSegmento" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[Usp_BuscarSegmentoXGrupo]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlGrupo" Name="IdGrupo" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsClaseXFamilia" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[Usp_BuscarClaseXFamilia]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlFamilia" Name="IdFamilia" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfIdProducto" runat="server" Visible="False" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsBuscarXCodigoProducto" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[UNSPSC].[Usp_BuscarProductoXCodigoProducto]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfCodigoProducto" Name="CodigoProducto" PropertyName="Value" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="auto-style7">&nbsp;</td>
            <td class="auto-style1">&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsUnidadMedida" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[Usp_BuscarUnidadMedida]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsFamiliaXSegmento" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[Usp_BuscarFamiliaXSegmento]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlSegmento" Name="IdSegmento" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsProductoXClase" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarProductoXClase" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlClase" Name="IdClase" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
            </td>
            <td>
                <asp:HiddenField ID="hfCodigoProducto" runat="server" />
            </td>
            <td class="auto-style7">&nbsp;</td>
            <td class="auto-style1">&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsCatalogoUNSPSC" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCatalogoUNSPSC]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td class="auto-style7">&nbsp;</td>
            <td class="auto-style1">&nbsp;</td>
        </tr>
    </table>
</asp:Content>
