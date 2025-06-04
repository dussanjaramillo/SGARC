<%@ Page Title="Unir Cupón" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="UnirCupon.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.UnirCupon" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table>
        <tr>
            <td>
                <h2>Unir Cupón de Pago X Centro</h2>
            </td>
        </tr>
    </table>
    <table class="auto-style17">
        <tr>
            <td>Regional<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlRegional" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnBuscar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td>Centro Formación<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlCentroFormacion" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnBuscar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="ddlRegional" runat="server" Width="170px" ToolTip="Regional del Usuario" DataSourceID="SdsRegional" DataTextField="NombreRegional" DataValueField="IdRegional" OnDataBound="ddlRegional_DataBound" AutoPostBack="True" OnSelectedIndexChanged="ddlRegional_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td>
                <asp:DropDownList ID="ddlCentroFormacion" runat="server" Width="340px" AutoPostBack="True" DataSourceID="SdsCentroXRegional" DataTextField="NombreCentroFormacion" DataValueField="IdCentroFormacion" OnDataBound="ddlCentroFormacion_DataBound">
                </asp:DropDownList>
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <table class="auto-style17">
        <tr>
            <td>
                <asp:GridView ID="grvFacturaXCentro" runat="server" AutoGenerateColumns="False" DataSourceID="SdsFacturasXCentro" OnDataBound="grvFacturaXCentro_DataBound" class="grvGrilla" Caption="Documento Equivalente Disponibles" AllowPaging="True" AllowSorting="True" OnSelectedIndexChanged="grvFacturaXCentro_SelectedIndexChanged" PageSize="8">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Regional" HeaderText="Regional" SortExpression="Regional" />
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" SortExpression="Codigo" />
                        <asp:BoundField DataField="Documento" HeaderText="Prefactura" SortExpression="Documento" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" ReadOnly="True" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" SortExpression="FechaCrea" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Pagada" HeaderText="Pagada" SortExpression="Pagada">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CodigoTipoCliente" HeaderText="TC" SortExpression="CodigoTipoCliente" />
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
    <table class="auto-style17">
        <tr>
            <td>
                <asp:GridView ID="grvPagos" runat="server" AutoGenerateColumns="False" DataSourceID="SdsCuponPagoXIdCentroFormacion" class="grvGrilla" AllowSorting="True" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" Caption="Cupones de Pago Disponibles" PageSize="8">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSel" runat="server" AutoPostBack="True" OnCheckedChanged="chkSel_CheckedChanged" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="IdCuponPago" HeaderText="Id" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" />
                        <asp:BoundField DataField="PrimerNombre" HeaderText="PrimerNombre" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Prefactura" />
                        <asp:BoundField DataField="ValorTotaldelPago" HeaderText="ValorPago" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="NroCupón" />
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:d}" />
                    </Columns>
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <SortedAscendingCellStyle BackColor="#F4F4FD" />
                    <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                    <SortedDescendingCellStyle BackColor="#D8D8F0" />
                    <SortedDescendingHeaderStyle BackColor="#3E3277" />
                </asp:GridView>
            </td>
        </tr>
    </table>
    <table class="auto-style17">
        <tr>
            <td>Valor Documento </td>
            <td class="auto-style10">&nbsp;</td>
            <td class="auto-style10">Suma Cupones</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Medium"></asp:Label>
            </td>
            <td class="auto-style10">&nbsp;</td>
            <td class="auto-style10">
                <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Medium"></asp:Label>
            </td>
            <td>&nbsp;</td>
            <td>
                <asp:Button ID="btnUnirCupones" runat="server" Enabled="False" Text="Unir Cupones" Width="170px" OnClick="btnUnirCupones_Click" />
                <Ajax:ConfirmButtonExtender ID="btnUnirCupones_ConfirmButtonExtender" runat="server" BehaviorID="btnUnirCupones_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnUnirCupones" />
            </td>
        </tr>
    </table>
    <table class="auto-style8">
        <tr>
            <td class="auto-style20">&nbsp;</td>
            <td class="auto-style21">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style20">
                <asp:HiddenField ID="hfValorDocumento" runat="server" />
            </td>
            <td class="auto-style21">
                <asp:HiddenField ID="hfNumeroFactura" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="CuponesPago" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="auto-style20">
                <asp:HiddenField ID="hfIdCentroFormación" runat="server" />
            </td>
            <td class="auto-style21">
                <asp:SqlDataSource ID="SdsCentroXRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[dbo].[Usp_BuscarCentroFormacionXRegional]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlRegional" Name="IdRegional" PropertyName="SelectedValue" Type="Int32" />
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
                <asp:SqlDataSource ID="SdsFacturasXCentro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaXCentroNoPagada]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlCentroFormacion" Name="IdCentroFormacion" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
