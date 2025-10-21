<%@ Page Title="Unir Cupones de Pago Masivo" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="UnirCuponMasivo.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.UnirCuponMasivo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">
        .auto-style8 {
            width: 18%;
        }
        .auto-style9 {
            width: 153px;
            height: 40px;
        }
        .auto-style10 {
            margin-left: 0px;
        }
        .auto-style11 {
            width: 365px;
        }
        .auto-style12 {
            width: 1019px;
        }
        .auto-style13 {
            width: 488px;
        }
        .auto-style14 {
            width: 316px;
        }
        .auto-style15 {
            width: 56%;
        }
        .auto-style16 {
            width: 59%;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style16">
        <tr>
            <td><h2>Unir Cupones de Pago Masivo - Carné y Fotocopias</h2></td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grvValorCupones" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsUnirCuponesMasivos" GridLines="Vertical" AutoGenerateColumns="False" OnRowDataBound="grvValorCupones_RowDataBound" AllowSorting="True">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" ReadOnly="True" SortExpression="Cantidad" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorPago" HeaderText="ValorPago" ReadOnly="True" SortExpression="ValorPago" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Mes" HeaderText="Mes" ReadOnly="True" SortExpression="Mes" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Año" HeaderText="Año" ReadOnly="True" SortExpression="Año" >
                        </asp:BoundField>
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
        </table>
    <table class="auto-style11">
        <tr>
            <td>
                Documento Equivalente<asp:TextBox ID="txtDocumentoEquivalente" runat="server" MaxLength="6" Width="170px" ValidationGroup="btnBuscar"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtDocumentoEquivalente_FilteredTextBoxExtender" runat="server" BehaviorID="txtDocumentoEquivalente_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtDocumentoEquivalente" />
            </td>
            <td>
                Valor Documento Equivalente<asp:TextBox ID="txtValorDocumento" runat="server" Enabled="False" Width="170px"></asp:TextBox>
            </td>
        </tr>
        </table>
    <table class="auto-style12">
        <tr>
            <td class="auto-style8">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDocumentoEquivalente" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnBuscar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style1">
                <asp:Panel ID="Panel1" runat="server" Font-Bold="True" ForeColor="Maroon" ToolTip="El Valor del Documento debe ser Igual a la Suma de Los Cupones" Visible="False" CssClass="auto-style10">
                    El Valor del Documento debe ser Igual a la Suma de Los Cupones</asp:Panel>
            </td>
        </tr>
        </table>
    <table class="auto-style13">
        <tr>
            <td class="auto-style4">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td class="auto-style2">
                <asp:Button ID="btnEjecutarUnirCupones" runat="server" OnClick="btnEjecutarUnirCupones_Click" Text="Ejecutar Unir Cupones" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnEjecutarUnirCupones_ConfirmButtonExtender" runat="server" BehaviorID="btnEjecutarUnirCupones_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnEjecutarUnirCupones" />
            </td>
        </tr>
        </table>
    <table class="auto-style15">
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsUnirCuponesMasivos" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_BuscarValorUnirCuponesPagoMasivo]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfNumeroFactura" runat="server" />
            </td>
            <td class="auto-style14">
                <asp:HiddenField ID="hfValorCupones" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hfMes" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfAño" runat="server" />
            </td>
            <td>
                &nbsp;</td>
            <td class="auto-style14">
                &nbsp;</td>
        </tr>
        </table>
</asp:Content>
