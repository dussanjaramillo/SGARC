<%@ Page Title="Basicas" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="Basicas.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Basicas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
    .auto-style6 {
        width: 49%;
    }
    .auto-style8 {
        width: 36px;
    }
    .auto-style9 {
        width: 280px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>
            <br />
        </td>
        <td>
            <Ajax:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="4" Height="95%" Width="1104px">
                <Ajax:TabPanel runat="server" HeaderText="TabPanel1" ID="TabPanel1">
                <HeaderTemplate>Cargo</HeaderTemplate><ContentTemplate><asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdCargo" DataSourceID="SqlDataSource2" GridLines="Vertical" AllowSorting="True"><AlternatingRowStyle BackColor="#DCDCDC" /><Columns><asp:BoundField DataField="IdCargo" HeaderText="IdCargo" InsertVisible="False" ReadOnly="True" SortExpression="IdCargo" /><asp:BoundField DataField="NombreCargo" HeaderText="NombreCargo" SortExpression="NombreCargo" /></Columns><FooterStyle BackColor="#CCCCCC" ForeColor="Black" /><HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" /><PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" /><RowStyle BackColor="#EEEEEE" ForeColor="Black" /><SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" /><SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" /><SortedDescendingCellStyle BackColor="#CAC9C9" /><SortedDescendingHeaderStyle BackColor="#000065" /></asp:GridView></ContentTemplate></Ajax:TabPanel>
                <Ajax:TabPanel runat="server" HeaderText="TabPanel2" ID="TabPanel2">
                    <HeaderTemplate>Regional</HeaderTemplate><ContentTemplate><asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdRegional" DataSourceID="SqlDataSource1" GridLines="Vertical" AllowSorting="True" PageSize="15"><AlternatingRowStyle BackColor="Gainsboro" /><Columns><asp:BoundField DataField="IdRegional" HeaderText="IdRegional" InsertVisible="False" ReadOnly="True" SortExpression="IdRegional" /><asp:BoundField DataField="NombreRegional" HeaderText="NombreRegional" SortExpression="NombreRegional" /></Columns><FooterStyle BackColor="#CCCCCC" ForeColor="Black" /><HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" /><PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" /><RowStyle BackColor="#EEEEEE" ForeColor="Black" /><SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" /><SortedAscendingCellStyle BackColor="#F1F1F1" /><SortedAscendingHeaderStyle BackColor="#0000A9" /><SortedDescendingCellStyle BackColor="#CAC9C9" /><SortedDescendingHeaderStyle BackColor="#000065" /></asp:GridView></ContentTemplate>
                </Ajax:TabPanel>
                <ajaxToolkit:TabPanel ID="TabPanel3" runat="server" HeaderText="TabPanel3">
                    <HeaderTemplate>
                        Departamento
                    </HeaderTemplate>
                    <ContentTemplate>
                        <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="IdDepartamento" DataSourceID="SqlDataSource3" GridLines="Vertical" AllowSorting="True" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" PageSize="15">
                            <AlternatingRowStyle BackColor="Gainsboro" />
                            <Columns>
                                <asp:BoundField DataField="IdDepartamento" HeaderText="IdDepartamento" InsertVisible="False" ReadOnly="True" SortExpression="IdDepartamento" />
                                <asp:BoundField DataField="NombreDepartamento" HeaderText="NombreDepartamento" SortExpression="NombreDepartamento" />
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
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
                <ajaxToolkit:TabPanel ID="TabPanel4" runat="server" HeaderText="TabPanel4">
                    <HeaderTemplate>
                        Municipio
                    </HeaderTemplate>
                    <ContentTemplate>
                        <asp:GridView ID="GridView4" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource4" DataKeyNames="IdMunicipio">
                            <AlternatingRowStyle BackColor="Gainsboro" />
                            <Columns>
                                <asp:BoundField DataField="IdMunicipio" HeaderText="IdMunicipio" SortExpression="IdMunicipio" InsertVisible="False" ReadOnly="True" />
                                <asp:BoundField DataField="CodigoDepartamento" HeaderText="CodigoDepartamento" SortExpression="CodigoDepartamento" />
                                <asp:BoundField DataField="NombreDepartamento" HeaderText="NombreDepartamento" SortExpression="NombreDepartamento" />
                                <asp:BoundField DataField="CodigoMunicipio" HeaderText="CodigoMunicipio" SortExpression="CodigoMunicipio" />
                                <asp:BoundField DataField="NombreMunicipio" HeaderText="NombreMunicipio" SortExpression="NombreMunicipio" />
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
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
                <ajaxToolkit:TabPanel ID="TabPanel5" runat="server" HeaderText="TabPanel5">
                    <HeaderTemplate>
                        Unidad Productiva
                    </HeaderTemplate>
                    <ContentTemplate>
                        <asp:GridView ID="GridView5" runat="server" DataSourceID="SqlDataSource5" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdUnidadProductiva" GridLines="Vertical">
                            <AlternatingRowStyle BackColor="Gainsboro" />
                            <Columns>
                                <asp:BoundField DataField="NombreRegional" HeaderText="NombreRegional" SortExpression="NombreRegional" />
                                <asp:BoundField DataField="NombreCentroFormacion" HeaderText="NombreCentroFormacion" SortExpression="NombreCentroFormacion" />
                                <asp:BoundField DataField="IdUnidadProductiva" HeaderText="IdUnidadProductiva" InsertVisible="False" ReadOnly="True" SortExpression="IdUnidadProductiva" />
                                <asp:BoundField DataField="NombreUnidadProductiva" HeaderText="NombreUnidadProductiva" SortExpression="NombreUnidadProductiva" />
                                <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
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
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
            </Ajax:TabContainer>
        </td>
        <td>&nbsp;</td>
    </tr>
    </table>
<table class="auto-style6">
    <tr>
        <td>

                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[Divipola].[Usp_MunicipiosTodos]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </td>
        <td>

                        <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_UnidadProductivaBuscar]" SelectCommandType="StoredProcedure" ID="SqlDataSource5"></asp:SqlDataSource>

        </td>
        <td class="auto-style8">

                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarCargo" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </td>
        <td>

                        <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarRegional" SelectCommandType="StoredProcedure" ID="SqlDataSource1"></asp:SqlDataSource>

        </td>
        <td class="auto-style9">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>

        </td>
        <td>

                        <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarDepartamento" SelectCommandType="StoredProcedure" ID="SqlDataSource3"></asp:SqlDataSource>

                    </td>
    </tr>
</table>
</asp:Content>
