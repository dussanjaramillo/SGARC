<%@ Page Title="Anular Prefactura" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="AnularFactura.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Factura.AnularFactura" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td><h2>Anular Prefactura:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2></td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grvFacturaXCentro" runat="server" AutoGenerateColumns="False" DataSourceID="SdsFacturasXCentro" OnDataBound="grvFacturaXCentro_DataBound" class="grvGrilla" Caption="Prefacturas Disponibles" AllowPaging="True" PageSize="15" AllowSorting="True" OnSelectedIndexChanged="grvFacturaXCentro_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Docum" SortExpression="NumeroFactura" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" ReadOnly="True" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" ReadOnly="True" SortExpression="Nombre" />
                        <asp:BoundField DataField="TipoCliente" HeaderText="Tipo Cliente" SortExpression="TipoCliente" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" ReadOnly="True" SortExpression="Valor" DataFormatString="{0:c0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" SortExpression="FechaCrea" />

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
    <table class="auto-style8">
        <tr>
            <td class="auto-style10">
                Motivo de Anulación<br />
                <asp:DropDownList ID="ddlMotivoAnulacion" runat="server" DataSourceID="SdsMotivoAnulacion" Width="170px" DataTextField="NombreMotivoAnulacionFactura" DataValueField="IdMotivoAnulacionFactura" OnDataBound="ddlMotivoAnulacion_DataBound" ValidationGroup="btnAnular">
                </asp:DropDownList>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlMotivoAnulacion" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnAnular"></asp:RequiredFieldValidator>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style12">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>
                <asp:Button ID="btnAnular" runat="server" Font-Bold="True" OnClick="btnAnular_Click" Text="Anular" Visible="False" Width="170px" ValidationGroup="btnAnular" />
                <Ajax:ConfirmButtonExtender ID="btnAnular_ConfirmButtonExtender" runat="server" BehaviorID="btnAnular_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnAnular" />
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td class="auto-style9">
                <asp:HiddenField ID="hfNumeroFactura" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsMotivoAnulacion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarMotivoAnulacionFactura]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style9">
                <asp:SqlDataSource ID="SdsFacturasXCentro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaNoAsociadaXCentro]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
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
