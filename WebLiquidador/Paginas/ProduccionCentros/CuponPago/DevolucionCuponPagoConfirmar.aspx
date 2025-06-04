<%@ Page Title="Confirmar Devolucion Cupón de Pago" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="DevolucionCuponPagoConfirmar.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.DevolucionCuponPagoConfirmar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">
        .auto-style8 {
            height: 26px;
        }
        .auto-style9 {
            width: 171px;
        }
        </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td>
                <h2>Confirmar Devolución Cupón de Pago</h2>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grvDevolucionCuponPago" runat="server" DataSourceID="SdsDevolucionCuponPago" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnSelectedIndexChanged="grvDevolucionCuponPago_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Centro Formacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="PrimerNombre" HeaderText="PrimerNombre" SortExpression="PrimerNombre" />
                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="NroInterno" SortExpression="NroInternodeTransaccion" />
                        <asp:BoundField DataField="ValorDevolucion" HeaderText="Valor Devolucion" SortExpression="ValorDevolucion"  DataFormatString="{0:c0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NombreMotivoDevolucion" HeaderText="Motivo Devolucion" SortExpression="NombreMotivoDevolucion" />
                        <asp:BoundField DataField="Saldo" HeaderText="Saldo" SortExpression="Saldo" DataFormatString="{0:c0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Pagado" HeaderText="Pagado" SortExpression="Pagado" ReadOnly="True" >
                        <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaPago" HeaderText="FechaPago" SortExpression="FechaPago" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Autorizó" HeaderText="Autorizó" SortExpression="Autorizó" />
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
        </table>
    <table class="auto-style8">
        <tr>
            <td class="auto-style9">
                Fecha de Pago</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style9">
                <asp:TextBox ID="txtFechaPago" runat="server" Enabled="False" MaxLength="10" ValidationGroup="btnConfirmar" Width="170px"></asp:TextBox>
                <Ajax:CalendarExtender ID="txtFechaPago_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaPago" />
            </td>
            <td>
                <asp:Button ID="btnConfirmar" runat="server" Enabled="False" OnClick="btnConfirmar_Click" Text="Confirmar" ValidationGroup="btnConfirmar" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnConfirmar_ConfirmButtonExtender" runat="server" BehaviorID="btnConfirmar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnConfirmar" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style9">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFechaPago" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnConfirmar"></asp:RequiredFieldValidator>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td class="auto-style9">
                <asp:HiddenField ID="hfIdDevolucionCuponPago" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsDevolucionCuponPago" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarDevolucionCuponPago]" SelectCommandType="StoredProcedure">
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfPagado" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
