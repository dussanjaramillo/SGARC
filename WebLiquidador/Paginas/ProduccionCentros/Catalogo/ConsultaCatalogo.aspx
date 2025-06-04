<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ConsultaCatalogo.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Catalogo.ConsultaCatalogo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            width: 100%;
        }
        .auto-style9 {
        }
        .auto-style10 {
            height: 26px;
        }
        .auto-style11 {
            width: 136px;
            height: 26px;
        }
        .auto-style12 {
            height: 21px;
        }
        .auto-style13 {
            width: 136px;
            height: 21px;
        }
        .auto-style14 {
            width: 161px;
        }
        .auto-style15 {
            height: 26px;
            }
        .auto-style16 {
            height: 21px;
            width: 161px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="7"><h2>Catálogo de Productos por Centros de Formación</h2></td>
        </tr>
        <tr>
            <td class="auto-style9">Regional</td>
            <td class="auto-style14">Centro Formación</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style11">
                            <asp:DropDownList ID="ddlRegional" runat="server" Width="170px" ToolTip="Regional del Usuario" DataSourceID="SdsRegional" DataTextField="NombreRegional" DataValueField="IdRegional" OnDataBound="ddlRegional_DataBound" AutoPostBack="True" OnSelectedIndexChanged="ddlRegional_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
            <td class="auto-style15" colspan="2">
                            <asp:DropDownList ID="ddlCentroFormacion" runat="server" Width="340px" OnSelectedIndexChanged="ddlCentroFormacion_SelectedIndexChanged" AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
            <td class="auto-style10"></td>
            <td class="auto-style10"></td>
            <td class="auto-style10"></td>
            <td class="auto-style10"></td>
        </tr>
        <tr>
            <td class="auto-style13">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlRegional" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
                        </td>
            <td class="auto-style16">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlCentroFormacion" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
                        </td>
            <td class="auto-style12"></td>
            <td class="auto-style12"></td>
            <td class="auto-style12"></td>
            <td class="auto-style12"></td>
            <td class="auto-style12"></td>
        </tr>
        <tr>
            <td class="auto-style9">
                            <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
                        </td>
            <td class="auto-style14">
                            <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
                        </td>
            <td>
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" Visible="False" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style9" colspan="7">
                <asp:GridView ID="grvCatalogoCentro" runat="server" DataSourceID="SdsBuscarCatalogoXCentro" AllowPaging="True" AllowSorting="True" class="grvGrilla" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="CodigoProducto" HeaderText="Producto" SortExpression="CodigoProducto" />
                        <asp:BoundField DataField="NombreProducto" HeaderText="Nombre" SortExpression="NombreProducto" />
                        <asp:BoundField DataField="PrecioMinimo" HeaderText="Minimo" SortExpression="PrecioMinimo" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PrecioMaximo" HeaderText="Maximo" SortExpression="PrecioMaximo" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NombreUnidadMedida" HeaderText="Medida" SortExpression="NombreUnidadMedida" />
                        <asp:BoundField DataField="NombreClase" HeaderText="Clase" SortExpression="NombreClase" />
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
                <asp:GridView ID="grvCatalogoCentro0" runat="server" DataSourceID="SdsBuscarCatalogoXCentro" class="grvGrilla" AutoGenerateColumns="False" Visible="False">
                    <Columns>
                        <asp:BoundField DataField="CodigoProducto" HeaderText="Producto" SortExpression="CodigoProducto" />
                        <asp:BoundField DataField="NombreProducto" HeaderText="Nombre" SortExpression="NombreProducto" />
                        <asp:BoundField DataField="PrecioMinimo" HeaderText="Minimo" SortExpression="PrecioMinimo" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PrecioMaximo" HeaderText="Maximo" SortExpression="PrecioMaximo" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NombreUnidadMedida" HeaderText="Medida" SortExpression="NombreUnidadMedida" />
                        <asp:BoundField DataField="NombreClase" HeaderText="Clase" SortExpression="NombreClase" />
                        <asp:BoundField DataField="NombreFamilia" HeaderText="Familia" SortExpression="NombreFamilia" />
                        <asp:BoundField DataField="NombreSegmento" HeaderText="Segmento" SortExpression="NombreSegmento" />
                        <asp:BoundField DataField="NombreGrupo" HeaderText="Grupo" SortExpression="NombreGrupo" />
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
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style14">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td class="auto-style9">
                            <asp:SqlDataSource ID="SdsRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarRegional" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                            </td>
            <td>
                            <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                            </asp:ScriptManager>
                            </td>
            <td>
                <asp:SqlDataSource ID="SdsBuscarCatalogoXCentro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCatalogoXCentro]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlCentroFormacion" Name="IdCentroFormacion" PropertyName="SelectedValue" Type="Int32" />
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
