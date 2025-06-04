<%@ Page Title="Cumplimiento de Meta" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="CumplimientoMeta.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Seguimiento.CumplimientoMeta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td>
                <h2 class="auto-style15">Cumplimiento de Meta:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>Vigencia-Mes</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="ddlAñoMesCuponPago" runat="server" DataSourceID="SdsAñoMesCuponPago" DataTextField="AñoMes" DataValueField="AñoMes" Width="170px">
                </asp:DropDownList>
            </td>
            <td>
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" Width="170px" ValidationGroup="btnBuscar" />
            </td>
            <td>
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" Enabled="False" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        </table>
    <table class="auto-style11">
        <tr>
            <td class="auto-style14">
                <strong>Porcentaje Cumplimiento Mes</strong></td>
            <td class="auto-style12">
                <asp:TextBox ID="TextBox1" runat="server" BackColor="Crimson" Enabled="False" Font-Bold="True" ForeColor="White" ReadOnly="True" Width="110px">&gt;= 0% y &lt;= 35%</asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="TextBox2" runat="server" BackColor="Yellow" Enabled="False" Font-Bold="True" ForeColor="Black" ReadOnly="True" Width="110px">&gt; 35% y &lt;= 70%</asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="TextBox3" runat="server" BackColor="LightGreen" Enabled="False" Font-Bold="True" ForeColor="Black" ReadOnly="True" Width="110px">&gt; 70% y &lt;= 100%</asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="TextBox4" runat="server" BackColor="LightBlue" Enabled="False" Font-Bold="True" ForeColor="Black" ReadOnly="True" Width="110px">&gt; 100%</asp:TextBox>
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:GridView ID="grvCumpliminetoMeta" runat="server" DataSourceID="SdsCumplimientoMeta" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" PageSize="15" OnDataBound="grvCumpliminetoMeta_DataBound" class="grvGrilla" Caption="Cumplimiento de Meta" Width="1157px" OnRowDataBound="grvCumpliminetoMeta_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="Meta" HeaderText="Meta" SortExpression="Meta" DataFormatString="{0:N0}">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Ingresos" HeaderText="Ingresos" SortExpression="Ingresos" DataFormatString="{0:N0}">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CumplimientoMeta" HeaderText="CumplimientoMeta" SortExpression="CumplimientoMeta" DataFormatString="{0:N2}">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ProyeccionMes" HeaderText="ProyeccionMes" SortExpression="ProyeccionMes" DataFormatString="{0:N0}">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PorcentajeCumplimientoMes" HeaderText="PorcentajeCumplimientoMes" SortExpression="PorcentajeCumplimientoMes" DataFormatString="{0:N2}">
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
            <td>
                <asp:GridView ID="grvCumpliminetoMeta0" runat="server" DataSourceID="SdsCumplimientoMeta" AutoGenerateColumns="False" Visible="False" class="grvGrilla" Caption="Cumplimiento de Meta" OnRowDataBound="grvCumpliminetoMeta0_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="NombreRegional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="CodigoCentroFormacion" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="NombreCentroFormacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="Meta" HeaderText="Meta" SortExpression="Meta">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Ingresos" HeaderText="Ingresos" SortExpression="Ingresos">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CumplimientoMeta" HeaderText="CumplimientoMeta" SortExpression="CumplimientoMeta">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ProyeccionMes" HeaderText="ProyeccionMes" SortExpression="ProyeccionMes">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PorcentajeCumplimientoMes" HeaderText="PorcentajeCumplimientoMes" SortExpression="PorcentajeCumplimientoMes">
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
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsAñoMesCuponPago" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarAñoMesCuponPago]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsCumplimientoMeta" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCumplimientoMeta]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlAñoMesCuponPago" Name="AñoMesCuponPago" PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
