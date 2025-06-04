<%@ Page Title="Asociar Cupón A Prefactura" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="AsociarCuponADocumentoEquivalente.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Factura.AsociarCuponADocumentoEquivalente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td>
                <h2>Asociar Cupón A Prefactura
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td># Prefactura</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtNumeroFactura" PlaceHolder="Prefactura" runat="server" MaxLength="8" Width="160px"></asp:TextBox>
                <ajax:filteredtextboxextender ID="txtNumeroFactura_FilteredTextBoxExtender" runat="server" BehaviorID="txtNumeroFactura_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtNumeroFactura" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnEjecutar" runat="server" OnClick="btnEjecutar_Click" Text="Ejecutar" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnEjecutar_ConfirmButtonExtender" runat="server" ConfirmText="Usted está Seguro?" TargetControlID="btnEjecutar" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNumeroFactura" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnBuscar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style8"></td>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style8">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8">
                # Prefactura A Asociar</td>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style8">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:TextBox ID="txtNewNumeroFactura" runat="server" PlaceHolder="Prefactura a Asociar" MaxLength="8" Width="160px" Enabled="False"></asp:TextBox>
                <ajax:filteredtextboxextender ID="txtNewNumeroFactura_FilteredTextBoxExtender" runat="server" BehaviorID="txtNumeroFactura_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtNewNumeroFactura" />
            </td>
            <td class="auto-style8">
                <asp:Button ID="btnBuscar0" runat="server" OnClick="btnBuscar0_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" Enabled="False" />
            </td>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style8">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNewNumeroFactura" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnEjecutar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style8">&nbsp;</td>
        </tr>
    </table>
    <table class="auto-style8">
        <tr>
            <td colspan="3">
                <asp:GridView ID="grvFacturaXCentro" runat="server" AutoGenerateColumns="False" DataSourceID="SdsNumeroFactura" class="grvGrilla" Caption="Prefactura y Cupón de Pago" OnDataBound="grvFacturaXCentro_DataBound" OnSelectedIndexChanged="grvFacturaXCentro_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Nombre" SortExpression="NombreCentroFormacion" >
                        <ItemStyle Font-Bold="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Docum" SortExpression="NumeroFactura" >
                        <ItemStyle Font-Bold="True" ForeColor="Maroon" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion"></asp:BoundField>
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" ReadOnly="True" DataFormatString="{0:N0}" >
                            <ItemStyle Font-Bold="True" ForeColor="Black" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" SortExpression="FechaCrea" DataFormatString="{0:d}"></asp:BoundField>
                        <asp:BoundField DataField="Pagada" HeaderText="Pagada" SortExpression="Pagada">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Cupon" HeaderText="Cupón">
                        <ItemStyle Font-Bold="True" ForeColor="Maroon" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorCupon" DataFormatString="{0:N0}" HeaderText="ValorCupon">
                        <ItemStyle Font-Bold="True" ForeColor="#0033CC" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaCupon" DataFormatString="{0:d}" HeaderText="FechaCupón" />
                        <asp:BoundField DataField="Tc" HeaderText="Tc" SortExpression="Tc" />
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
            <td colspan="3">
                <asp:GridView ID="grvDocumento" runat="server" BackColor="White" class="grvGrilla" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsBuscarFactura" AutoGenerateColumns="False" DataKeyNames="IdFactura" Caption="Prefactura A Asociar" OnDataBound="grvDocumento_DataBound">
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
                        <asp:BoundField DataField="Pagada" HeaderText="Pagada" SortExpression="Pagada" />
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
            <td>
                &nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
        </tr>
    </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:HiddenField ID="hfNumeroCuponPago" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsBuscarFactura" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_BuscarValorFactura0]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtNewNumeroFactura" Name="NumeroFactura" PropertyName="Text" Type="Int64" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsNumeroFactura" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaXNumeroFactura1]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtNumeroFactura" Name="NumeroFactura" PropertyName="Text" Type="Int64" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfBuscar" runat="server" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
