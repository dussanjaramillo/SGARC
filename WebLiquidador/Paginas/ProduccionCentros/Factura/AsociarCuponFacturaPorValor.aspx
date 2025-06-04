<%@ Page Title="Asociar Cupón Por Diferente Valor" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="AsociarCuponFacturaPorValor.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Factura.AsociarCuponFacturaPorValor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table>
        <tr>
            <td><h2>Asociar Cupón por Diferente Valor (Solo con Fecha &gt;= 2021-02-01)</h2></td>
        </tr>
        </table>
    <table class="auto-style17">
        <tr>
            <td class="auto-style9">Regional</td>
            <td colspan="2">Centro Formación</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                            <asp:DropDownList ID="ddlRegional" runat="server" Width="170px" ToolTip="Regional del Usuario" DataSourceID="SdsRegional" DataTextField="NombreRegional" DataValueField="IdRegional" OnDataBound="ddlRegional_DataBound" AutoPostBack="True">
                            </asp:DropDownList>
            </td>
            <td colspan="2">
                            <asp:DropDownList ID="ddlCentroFormacion" runat="server" Width="340px" AutoPostBack="True" DataSourceID="SdsCentroXRegional" DataTextField="NombreCentroFormacion" DataValueField="IdCentroFormacion" OnDataBound="ddlCentroFormacion_DataBound">
                            </asp:DropDownList>
                        </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlRegional" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnBuscar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style16">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlCentroFormacion" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnBuscar" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
            <td class="auto-style16"></td>
            <td class="auto-style15"></td>
        </tr>
        <tr>
            <td>Nro Prefactura</td>
            <td class="auto-style10">&nbsp;</td>
            <td class="auto-style10">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtNumeroFactura" runat="server" Width="170px" ForeColor="Maroon" ValidationGroup="btnBuscar" Enabled="False" MaxLength="8"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtNumeroFactura_FilteredTextBoxExtender" runat="server" BehaviorID="txtNumeroFacturaNew_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=",." TargetControlID="txtNumeroFactura" />
            </td>
            <td class="auto-style10">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" Enabled="False" />
            </td>
            <td class="auto-style10">
                <asp:Button ID="btnAsociar" runat="server" Enabled="False" Text="Asociar" Width="170px" OnClick="btnAsociar_Click" />
                <Ajax:ConfirmButtonExtender ID="btnAsociar_ConfirmButtonExtender" runat="server" BehaviorID="btnAsociar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnAsociar" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        <tr>
            <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtNumeroFactura" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnBuscar" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtMotivoAsociacion" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnAsociar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style10" colspan="3">
                <asp:TextBox ID="txtMotivoAsociacion" runat="server" Enabled="False" PlaceHolder="Motivo de Asociación" MaxLength="100" ValidationGroup="btnAsociar" Width="515px"></asp:TextBox>
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td colspan="3">
                <asp:GridView ID="grvCupones" runat="server" BackColor="White" class="grvGrilla" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" DataSourceID="SdsCuponPagoXIdCentroFormacion" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IdCuponPago" OnDataBound="grvCupones_DataBound" OnSelectedIndexChanged="grvCupones_SelectedIndexChanged" PageSize="5" Caption="Seleccione el Cupón a Asisgnar" OnPageIndexChanged="grvCupones_PageIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdCuponPago" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdCuponPago" />
                        <asp:BoundField DataField="Centro" HeaderText="Centro" SortExpression="Centro" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="PrimerNombre" HeaderText="PrimerNombre" SortExpression="PrimerNombre" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Docum" SortExpression="NumeroFactura" />
                        <asp:BoundField DataField="ValorTotaldelPago" HeaderText="ValorPago" SortExpression="ValorTotaldelPago" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="Cupón" SortExpression="NroInternodeTransaccion" />
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" SortExpression="Fecha" DataFormatString="{0:d}" />
                    </Columns>
                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                    <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#594B9C" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#33276A" />
                </asp:GridView>
                <asp:GridView ID="grvDocumento" runat="server" BackColor="White" class="grvGrilla" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsBuscarFactura" AutoGenerateColumns="False" DataKeyNames="IdFactura" Caption="Prefactura" OnDataBound="grvDocumento_DataBound">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="IdFactura" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdFactura" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Docum" SortExpression="NumeroFactura" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="ValorFactura" HeaderText="Valor" ReadOnly="True" SortExpression="ValorFactura" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" ReadOnly="True" SortExpression="FechaCrea" DataFormatString="{0:d}" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
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
            <td class="auto-style20">
                <asp:HiddenField ID="hfBuscar" runat="server" />
            </td>
            <td class="auto-style21">
                <asp:HiddenField ID="hfIdFactura" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfIdCuponPago" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="auto-style20">
                <asp:HiddenField ID="hfIdCentroFormación" runat="server" />
            </td>
            <td class="auto-style21">
                <asp:SqlDataSource ID="SdsBuscarFactura" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarValorFactura_]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlCentroFormacion" Name="IdCentroFormacion" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="txtNumeroFactura" Name="NumeroFactura" PropertyName="Text" Type="Int64" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsCuponPagoXIdCentroFormacion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCuponPagoXIdCentroFormacion_]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlCentroFormacion" Name="IdCentroFormacion" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="auto-style20">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td class="auto-style21">
                            <asp:SqlDataSource ID="SdsRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarRegional" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsCentroXRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[dbo].[Usp_BuscarCentroFormacionXRegional]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlRegional" Name="IdRegional" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
