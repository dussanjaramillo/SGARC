<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="PresupuestoXRegional.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Presupuesto.PresupuestoXRegional" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            width: 100%;
        }

        .auto-style9 {
            width: 50px;
        }

        .auto-style12 {
        width: 148px;
    }
        .auto-style13 {
            width: 164px;
        }
        .auto-style14 {
            width: 147px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="5">
                <h2>Presupuesto Por Regional</h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style9">
                Vigencia</td>
            <td class="auto-style12">
                &nbsp;</td>
            <td class="auto-style13">
                &nbsp;</td>
            <td class="auto-style14">
                &nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style9">
                <asp:DropDownList ID="ddlVigencia" runat="server" DataSourceID="SdsVigencia" Width="170px" DataTextField="Vigencia" DataValueField="Vigencia">
                </asp:DropDownList>
            </td>
            <td class="auto-style12">
                <asp:Button ID="btnInicial" runat="server" Text="Inicial" Width="170px" OnClick="btnInicial_Click" />
            </td>
            <td class="auto-style13">
                <asp:Button ID="btnActual" runat="server" Text="Actual" Width="170px" OnClick="btnActual_Click" />
            </td>
            <td class="auto-style14">
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" Enabled="False" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
    </table>
    <table class="auto-style8">
        <tr>
            <td colspan="3">
                <asp:GridView ID="grvPresupuestoXRegional" runat="server" DataSourceID="SdsPresupuestoXRegional" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Nombre" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="CodigoRubro" HeaderText="Rubro" SortExpression="CodigoRubro" />
                        <asp:BoundField DataField="NombreRubro" HeaderText="Nombre" SortExpression="NombreRubro" />
                        <asp:BoundField DataField="FechaPresupuesto" DataFormatString="{0:d}" HeaderText="Fecha" SortExpression="FechaPresupuesto" />
                        <asp:BoundField DataField="ApropiacionInicial" DataFormatString="{0:c0}" HeaderText="Apropiacion Inicial" SortExpression="ApropiacionInicial">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ApropiacionAdicionada" DataFormatString="{0:c0}" HeaderText="Apropiacion Adicionada" SortExpression="ApropiacionAdicionada">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ApropiacionReducida" DataFormatString="{0:c0}" HeaderText="Apropiacion Reducida" SortExpression="ApropiacionReducida">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Meta" DataFormatString="{0:c0}" HeaderText="Meta" SortExpression="Meta">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#CCCCCC" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#465767" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:GridView ID="grvPresupuestoXRegional0" runat="server" DataSourceID="SdsPresupuestoXRegional" AutoGenerateColumns="False" Visible="False">
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Nombre" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="CodigoRubro" HeaderText="Rubro" SortExpression="CodigoRubro" />
                        <asp:BoundField DataField="NombreRubro" HeaderText="Nombre" SortExpression="NombreRubro" />
                        <asp:BoundField DataField="FechaPresupuesto" DataFormatString="{0:d}" HeaderText="Fecha" SortExpression="FechaPresupuesto" />
                        <asp:BoundField DataField="ApropiacionInicial" DataFormatString="{0:c0}" HeaderText="Apropiacion Inicial" SortExpression="ApropiacionInicial">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ApropiacionAdicionada" DataFormatString="{0:c0}" HeaderText="Apropiacion Adicionada" SortExpression="ApropiacionAdicionada">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ApropiacionReducida" DataFormatString="{0:c0}" HeaderText="Apropiacion Reducida" SortExpression="ApropiacionReducida">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Meta" DataFormatString="{0:c0}" HeaderText="Meta" SortExpression="Meta">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#CCCCCC" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#465767" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td class="auto-style9">
                <asp:SqlDataSource ID="SdsPresupuestoXRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarPresupuestoXRegional]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdRegional" SessionField="_IdRegional" Type="Int32" />
                        <asp:ControlParameter ControlID="hfLote" Name="Lote" PropertyName="Value" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlVigencia" Name="Vigencia" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfLote" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsVigencia" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarVigencia]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
