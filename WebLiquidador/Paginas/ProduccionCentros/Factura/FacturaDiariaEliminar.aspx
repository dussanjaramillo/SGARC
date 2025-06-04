<%@ Page Title="Eliminar los Productos de la Prefactura Diaria" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="FacturaDiariaEliminar.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Factura.FacturaDiariaEliminar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">
        .auto-style8 {
            height: 26px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td>
                <h2>Eliminar los Productos de la Prefactura Diaria:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
            </td>
        </tr>
    </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:GridView ID="grvProductosFacturaDiaria" runat="server" DataSourceID="SdsProductosFacturaDiaria" AllowPaging="True" class="grvGrilla" AllowSorting="True" AutoGenerateColumns="False" Caption="Productos de la Prefactura Diaria" OnDataBound="grvProductosFacturaDiaria_DataBound" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="CodigoProducto" HeaderText="CodigoProducto" SortExpression="CodigoProducto" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" SortExpression="Cantidad" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Precio" HeaderText="Precio" SortExpression="Precio" DataFormatString="{0:N0}" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" DataFormatString="{0:N0}" ReadOnly="True" />
                        <asp:BoundField DataField="NombreUnidadMedida" HeaderText="Medida" SortExpression="NombreUnidadMedida" />
                        <asp:BoundField DataField="Usuario" HeaderText="Usuario" SortExpression="Usuario" />
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
            <td>
                <asp:Button ID="btnBorrar" runat="server" Text="Eliminar" ValidationGroup="btnBorrar" Width="170px" OnClick="btnBorrar_Click" />
                <Ajax:ConfirmButtonExtender ID="btnBorrar_ConfirmButtonExtender" runat="server" BehaviorID="btnBorrar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnBorrar" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
    </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsProductosFacturaDiaria" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaDiariaDetalle_]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                        <asp:SessionParameter Name="IdUsuario" SessionField="_IdUsuario" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
