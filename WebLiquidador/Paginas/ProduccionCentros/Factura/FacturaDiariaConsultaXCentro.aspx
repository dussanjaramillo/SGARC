<%@ Page Title="Consulta los Productos de la Prefactura" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="FacturaDiariaConsultaXCentro.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Factura.FacturaDiariaConsultaXCentro" %>

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
                <h2>Consulta los Productos de la Prefactura Diaria:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
            </td>
        </tr>
    </table>
    <table class="auto-style8">
        <tr>
            <td>Regional<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlRegional" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
            </td>
            <td>Centro de Formación<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlCentroFormacion" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="ddlRegional" runat="server" Width="170px" ToolTip="Regional del Usuario" DataSourceID="SdsRegional" DataTextField="NombreRegional" DataValueField="IdRegional" OnDataBound="ddlRegional_DataBound" AutoPostBack="True" OnSelectedIndexChanged="ddlRegional_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td>
                <asp:DropDownList ID="ddlCentroFormacion" runat="server" Width="340px" OnSelectedIndexChanged="ddlCentroFormacion_SelectedIndexChanged" AutoPostBack="True">
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:GridView ID="grvProductosFacturaDiaria" runat="server" DataSourceID="SdsProductosFacturaDiaria" AllowPaging="True" class="grvGrilla" AllowSorting="True" AutoGenerateColumns="False" Caption="Productos Grabados en el Documento Diario" OnDataBound="grvProductosFacturaDiaria_DataBound" PageSize="15">
                    <Columns>
                        <asp:BoundField DataField="CodigoProducto" HeaderText="Codigo" SortExpression="CodigoProducto" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre"></asp:BoundField>
                        <asp:BoundField DataField="Cantidad" HeaderText="Cnt" SortExpression="Cantidad">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Precio" HeaderText="Precio" SortExpression="Precio" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" DataFormatString="{0:N0}" ReadOnly="True">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
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
                <asp:SqlDataSource ID="SdsProductosFacturaDiaria" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaDiariaDetalleXCentroFormacion]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlCentroFormacion" Name="IdCentroFormacion" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarRegional" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
