<%@ Page Title="Fondo Vivienda" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EstadoPago.aspx.cs" Inherits="WebLiquidador.Paginas.FondoVivienda.Empleado.EstadoPago" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            width: 100%;
        }
    .auto-style9 {
        height: 21px;
    }
        .auto-style10 {
            width: 42%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style10">
        <tr>
            <td colspan="4"><h2>Estado de Pagos</h2></td>
        </tr>
        <tr>
            <td>Identificación</td>
            <td colspan="3">Empleado</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtIdentificacion" runat="server" MaxLength="16" Width="170px" Font-Bold="True" ForeColor="Maroon"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtIdentificacion_FilteredTextBoxExtender" runat="server" BehaviorID="txtIdentificacion_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtIdentificacion" />
            </td>
            <td colspan="3">
                <asp:TextBox ID="txtNombreEmpleado" runat="server" Width="470px" ToolTip="Nombre Empleado" MaxLength="100" Enabled="False" Font-Bold="True" ForeColor="Maroon"></asp:TextBox>
                <ajaxToolkit:TextBoxWatermarkExtender ID="txtNombreEmpleado_TextBoxWatermarkExtender" runat="server" BehaviorID="txtNombreEmpleado_TextBoxWatermarkExtender" TargetControlID="txtNombreEmpleado" WatermarkText="Nombre Empleado" />
                <ajaxToolkit:FilteredTextBoxExtender ID="txtNombreEmpleado_FilteredTextBoxExtender" runat="server" BehaviorID="txtNombreEmpleado_FilteredTextBoxExtender" FilterType="Custom, Numbers, UppercaseLetters" TargetControlID="txtNombreEmpleado" ValidChars="ÑñÁÉÍÓÚáéíóú ." />
            </td>
        </tr>
        <tr>
            <td class="auto-style9">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtIdentificacion" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style9" colspan="3"></td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td><asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
            </td>
            <td>
                <asp:Button ID="btnImprimir" runat="server" Enabled="False" OnClick="btnImprimir_Click" Text="Imprimir" Width="170px" />
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td colspan="8">
                <asp:GridView ID="grvPagosAhorro" runat="server" DataSourceID="SdsBuscarAhorro" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" PageSize="15">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="NombreRegional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="PeriodoPago" HeaderText="PeriodoPago" SortExpression="PeriodoPago" />
                        <asp:BoundField DataField="Valor" DataFormatString="{0:N0}" HeaderText="Valor" SortExpression="Valor">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CodigoConcepto" HeaderText="CodigoConcepto" SortExpression="CodigoConcepto" />
                        <asp:BoundField DataField="NombreConcepto" HeaderText="NombreConcepto" SortExpression="NombreConcepto" />
                        <asp:BoundField DataField="U" HeaderText="U" SortExpression="U" />
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
                <asp:GridView ID="grvPagosAhorro0" runat="server" DataSourceID="SdsBuscarAhorro" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" PageSize="15" Visible="False">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="NombreRegional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="NombreEmpleado" HeaderText="NombreEmpleado" SortExpression="NombreEmpleado" />
                        <asp:BoundField DataField="PeriodoPago" HeaderText="PeriodoPago" SortExpression="PeriodoPago" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor"></asp:BoundField>
                        <asp:BoundField DataField="CodigoConcepto" HeaderText="CodigoConcepto" SortExpression="CodigoConcepto" />
                        <asp:BoundField DataField="NombreConcepto" HeaderText="NombreConcepto" SortExpression="NombreConcepto" />
                        <asp:BoundField DataField="U" HeaderText="U" SortExpression="U" />
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
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
                            </td>
            <td>
                <asp:SqlDataSource ID="SdsBuscarAhorro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[FondoVivienda].[Usp_BuscarAhorro]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtIdentificacion" Name="Identificacion" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
