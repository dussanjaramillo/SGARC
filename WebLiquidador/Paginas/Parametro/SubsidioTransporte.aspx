<%@ Page Title="Subsidio Transporte" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubsidioTransporte.aspx.cs" Inherits="WebLiquidador.Paginas.Parametro.SubsidioTransporte" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="5"><h2>Subsidio Transporte - 
                <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                    </h2></td>
        </tr>
        <tr>
            <td>Vigencia Desde</td>
            <td>Vigencia Hasta</td>
            <td>Subsidio Transporte</td>
            <td>Norma</td>
            <td class="auto-style9">&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtDesde" runat="server" MaxLength="10" Width="170px"></asp:TextBox>
                <Ajax:CalendarExtender ID="txtDesde_CalendarExtender" runat="server" BehaviorID="txtDesde_CalendarExtender" Format="dd/MM/yyyy" TargetControlID="txtDesde" />
            </td>
            <td>
                <asp:TextBox ID="txtHasta" runat="server" MaxLength="10" Width="170px"></asp:TextBox>
                <Ajax:CalendarExtender ID="txtHasta_CalendarExtender" runat="server" BehaviorID="txtHasta_CalendarExtender" Format="dd/MM/yyyy" TargetControlID="txtHasta" />
            </td>
            <td>
                <asp:TextBox ID="txtValor" runat="server" MaxLength="7" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtValor_FilteredTextBoxExtender" runat="server" BehaviorID="txtValor_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtValor" />
            </td>
            <td>
                <asp:TextBox ID="txtNorma" runat="server" Width="170px"></asp:TextBox>
            </td>
            <td class="auto-style9">
                <asp:CheckBox ID="chbEsActivo" runat="server" Checked="True" Font-Bold="True" ForeColor="Maroon" Text="Activo" TextAlign="Left" ToolTip="Es Activo?" />
            </td>
        </tr>
        <tr>
            <td>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDesde" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtHasta" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtValor" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtNorma" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style9">&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
            </td>
            <td>&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="5">
                <asp:GridView ID="grvSubsidioTransporte" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataKeyNames="IdSubsidioTransporte" DataSourceID="SdsSubsidioTransporte" ForeColor="Black" OnSelectedIndexChanged="grvSubsidioTransporte_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdSubsidioTransporte" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdSubsidioTransporte" />
                        <asp:BoundField DataField="Desde" HeaderText="Desde" SortExpression="Desde" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Hasta" HeaderText="Hasta" SortExpression="Hasta" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Valor" HeaderText="Subsidio Transporte" SortExpression="Valor" DataFormatString="{0:N0}" />
                        <asp:BoundField DataField="Norma" HeaderText="Norma" SortExpression="Norma" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
                    </Columns>
                    <FooterStyle BackColor="Tan" />
                    <HeaderStyle BackColor="Tan" Font-Bold="True" />
                    <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                    <SortedAscendingCellStyle BackColor="#FAFAE7" />
                    <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                    <SortedDescendingCellStyle BackColor="#E1DB9C" />
                    <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                </asp:GridView>
                <asp:GridView ID="grvSubsidioTransporte0" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataKeyNames="IdSubsidioTransporte" DataSourceID="SdsSubsidioTransporte" ForeColor="Black" Visible="False">
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    <Columns>
                        <asp:BoundField DataField="Desde" HeaderText="Desde" SortExpression="Desde" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Hasta" HeaderText="Hasta" SortExpression="Hasta" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" />
                        <asp:BoundField DataField="Norma" HeaderText="Norma" SortExpression="Norma" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
                    </Columns>
                    <FooterStyle BackColor="Tan" />
                    <HeaderStyle BackColor="Tan" Font-Bold="True" />
                    <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                    <SortedAscendingCellStyle BackColor="#FAFAE7" />
                    <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                    <SortedDescendingCellStyle BackColor="#E1DB9C" />
                    <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                </asp:GridView>
                </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsSubsidioTransporte" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" InsertCommand="Usp_SubsidioTransporteInsert" InsertCommandType="StoredProcedure" SelectCommand="Usp_BuscarSubsidioTransporte_" SelectCommandType="StoredProcedure" UpdateCommand="Usp_SubsidioTransporteUpdate" UpdateCommandType="StoredProcedure">
                    <InsertParameters>
                        <asp:Parameter DbType="Date" Name="Desde" />
                        <asp:Parameter DbType="Date" Name="Hasta" />
                        <asp:Parameter Name="Valor" Type="Int32" />
                        <asp:Parameter Name="Norma" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="IdSubsidioTransporte" Type="Int32" />
                        <asp:Parameter DbType="Date" Name="Desde" />
                        <asp:Parameter DbType="Date" Name="Hasta" />
                        <asp:Parameter Name="Valor" Type="Int32" />
                        <asp:Parameter Name="Norma" Type="String" />
                        <asp:Parameter Name="EsActivo" Type="Boolean" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
            <td class="auto-style8">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfErrorValidacion" runat="server" Visible="False" />
            </td>
            <td>
                <asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
            </td>
            <td>
                <asp:HiddenField ID="hfIdSubsidioTransporte" runat="server" Visible="False" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
