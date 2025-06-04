<%@ Page Title="Distribución de Cupón de Pago" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="DistribucionCuponPago.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.DistribucionCuponPago" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">
        .auto-style8 {
            height: 26px;
        }
        .auto-style9 {
            height: 29px;
        }
        .auto-style10 {
        height: 14px;
    }
    .auto-style11 {
        height: 14px;
        width: 102px;
    }
        </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="7">
                <h2>Distribución de Cupón de Pago</h2>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #CCCCFF">
                <h1>Origen</h1>
            </td>
            <td>&nbsp;</td>
            <td colspan="3" style="background-color: #CCFFCC">
                <h1>Destino</h1>
            </td>
        </tr>
        <tr>
            <td class="auto-style10">Cupón de Pago<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCuponPago" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnBuscar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style11"></td>
            <td class="auto-style10"></td>
            <td class="auto-style10"></td>
            <td class="auto-style10">Regional<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlRegional" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnAgregarCentro"></asp:RequiredFieldValidator>
            </td>
            <td colspan="2" class="auto-style10">Centro Formación<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlCentroFormacion" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnAgregarCentro"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtCuponPago" runat="server" MaxLength="11" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtCuponPago_FilteredTextBoxExtender" runat="server" BehaviorID="txtCuponPago_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtCuponPago" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar0" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>&nbsp;</td>
            <td>
                <asp:DropDownList ID="ddlRegional" runat="server" Width="170px" ToolTip="Regional del Usuario" DataSourceID="SdsRegional" DataTextField="NombreRegional" DataValueField="IdRegional" OnDataBound="ddlRegional_DataBound" AutoPostBack="True" OnSelectedIndexChanged="ddlRegional_SelectedIndexChanged" Enabled="False">
                </asp:DropDownList>
            </td>
            <td colspan="2">
                <asp:DropDownList ID="ddlCentroFormacion" runat="server" Width="340px" AutoPostBack="True" Enabled="False">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td colspan="3" rowspan="6">
                <asp:GridView ID="grvPagosDisponibles" runat="server" DataSourceID="SdsCuponPagoActivoXNroInternodeTransaccion" AllowSorting="True" class="grvGrilla" Caption="Pagos Disponibles" AutoGenerateColumns="False" DataKeyNames="IdCuponPago" OnSelectedIndexChanged="grvPagosDisponibles_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdCuponPago" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdCuponPago" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Código" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Nombre" SortExpression="NombreCentroFormacion" />
<%--                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="NroInterno" SortExpression="NroInternodeTransaccion" />--%>
                        <asp:BoundField DataField="ValorPago" HeaderText="ValorPago" SortExpression="ValorPago" DataFormatString="{0:N0}">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
<%--                        <asp:BoundField DataField="FechaPago" DataFormatString="{0:d}" HeaderText="FechaPago" SortExpression="FechaPago" />--%>
                    </Columns>
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
            <td>&nbsp;</td>
            <td>
                Valor Cupón</td>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:TextBox ID="txtValorCupon" runat="server" Width="170px" MaxLength="10" Visible="False"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtValorCupon_FilteredTextBoxExtender" runat="server" BehaviorID="txtValorCupon_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtValorCupon" />
            </td>
            <td>
                <asp:Button ID="btnAgregarCentro" runat="server" OnClick="btnAgregarCentro_Click" Text="+ Agregar" ValidationGroup="btnAgregarCentro" Width="170px" Visible="False" />
            </td>
            <td>
                <asp:Button ID="btnBorrar" runat="server" OnClick="btnBorrar_Click" Text="- Borrar" Width="170px" Enabled="False" Visible="False" />
                <Ajax:ConfirmButtonExtender ID="btnBorrar_ConfirmButtonExtender" runat="server" BehaviorID="btnBorrar_ConfirmButtonExtender" ConfirmText="Esta Seguro?" TargetControlID="btnBorrar" />
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtValorCupon" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAgregarCentro"></asp:RequiredFieldValidator>
            </td>
            <td>
                Total Distribución</td>
            <td>
                <asp:TextBox ID="txtTotalDistribucion" runat="server" BackColor="#FFFF99" Enabled="False" Font-Bold="True" ForeColor="Maroon" Font-Size="Medium" Width="170px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style8"></td>
            <td class="auto-style8">
                &nbsp;</td>
            <td class="auto-style8">
                <asp:Button ID="btnDistribuirCuponPago" runat="server" OnClick="btnDistribuirCuponPago_Click" Text="Distribuir Cupón Pago" Visible="False" ValidationGroup="btnDistribuirCuponPago" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnDistribuirCuponPago_ConfirmButtonExtender" runat="server" BehaviorID="btnTrasladoCuponPago_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnDistribuirCuponPago" />
                </td>
            <td class="auto-style8">
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td colspan="3" rowspan="3">
                <asp:GridView ID="grvDistribucionCuponPago" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IdCentroProduccion"  class="grvGrilla" Caption="Distribución" OnSelectedIndexChanged="grvDistribucionCuponPago_SelectedIndexChanged" PageSize="5">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Item" HeaderText="Item" InsertVisible="False" ReadOnly="True" SortExpression="Item" />
                        <asp:BoundField DataField="IdCentroProduccion" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdCentroProduccion" />
                        <asp:BoundField DataField="NombreCentroProduccion" HeaderText="Centro Formación" SortExpression="NombreCentroProduccion" />
                        <asp:BoundField DataField="ValorCupon" DataFormatString="{0:N0}" HeaderText="Valor Cupón" SortExpression="ValorCupon">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
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
            <td></td>
        </tr>
        <tr>
            <td colspan="3">
                &nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:SqlDataSource ID="SdsRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarRegional" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>
                <asp:HiddenField ID="hfItem" runat="server" />
            </td>
            <td colspan="3">
                <asp:SqlDataSource ID="SdsCuponPagoActivoXNroInternodeTransaccion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCuponPagoActivoXNroInternodeTransaccion]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtCuponPago" Name="NroInternodeTransaccion" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfValorCuponEs" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>
                <asp:HiddenField ID="hfIdCentroFormacion" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfValorCupon" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>
                <asp:HiddenField ID="hfIdCuponPago" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
