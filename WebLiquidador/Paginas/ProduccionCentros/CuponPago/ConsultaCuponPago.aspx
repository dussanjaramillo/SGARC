<%@ Page Title="Cupón de Pago" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ConsultaCuponPago.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.ConsultaCuponPago" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            width: 100%;
        }
        .auto-style9 {
            width: 28%;
        }
        .auto-style10 {
            width: 90%;
        }
        .auto-style11 {
            width: 37%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td><h2>Ingresos Por Cupón de Pago :
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2></td>
        </tr>
        </table>
    <table class="auto-style9">
        <tr>
            <td>Número de Cupón de Pago</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtCuponPago" runat="server" MaxLength="10" Width="170px"></asp:TextBox>
                <ajax:filteredtextboxextender ID="txtCuponPago_FilteredTextBoxExtender" runat="server" BehaviorID="txtCuponPago_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtCuponPago" />
            </td>
            <td>
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCuponPago" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnBuscar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        </table>
<table class="auto-style10">
        <tr>
            <td>
                <asp:GridView ID="grvCuponDePago" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsCuponDePago" AutoGenerateColumns="False" OnDataBound="grvCuponDePago_DataBound" Width="1133px">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="PrimerNombre" HeaderText="PrimerNombre" SortExpression="PrimerNombre" />
                        <asp:BoundField DataField="PrimerApellido" HeaderText="PrimerApellido" SortExpression="PrimerApellido" />
                        <asp:HyperLinkField DataNavigateUrlFields="DocumentoEquivalente" DataNavigateUrlFormatString="~/Paginas/ProduccionCentros/Factura/BuscarFacturaXNumero.aspx?id={0}" DataTextField="DocumentoEquivalente" HeaderText="Prefactura" Text="Prefactura" />
                        <asp:BoundField DataField="ValorTotaldelPago" HeaderText="Valor" SortExpression="ValorTotaldelPago" DataFormatString="{0:N0}" />
                        <asp:BoundField DataField="EntidadFinancieraAutorizadora" HeaderText="EntidadFinanciera" SortExpression="EntidadFinancieraAutorizadora" />
                        <asp:BoundField DataField="FechaEntidadFinanciera" DataFormatString="{0:d}" HeaderText="Fecha" SortExpression="FechaEntidadFinanciera" />
                        <asp:BoundField DataField="Centro" HeaderText="Centro" SortExpression="Centro" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" >
                        <ItemStyle Font-Bold="True" ForeColor="#006600" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NombreOrigenPago" HeaderText="OrigenPago" SortExpression="NombreOrigenPago" />
                        <asp:BoundField DataField="Asignado" HeaderText="Asignado" SortExpression="Asignado" >
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
            </td>
        </tr>
        </table>
    <table class="auto-style11">
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsCuponDePago" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCuponPago]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtCuponPago" Name="NroInternodeTransaccion" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfExiste" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
