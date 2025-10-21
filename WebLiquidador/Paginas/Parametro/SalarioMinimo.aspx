<%@ Page Title="Salario Mínimo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SalarioMinimo.aspx.cs" Inherits="WebLiquidador.Paginas.Parametro.SalarioMinimo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="5"><h2>Salario Mínimo - 
                <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                    </h2></td>
        </tr>
        <tr>
            <td>Vigencia Desde</td>
            <td>Vigencia Hasta</td>
            <td>Salario Mínimo</td>
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
                <asp:GridView ID="grvSalarioMinimo" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataKeyNames="IdSalarioMinimo" DataSourceID="SdsSalarioMinimo" ForeColor="Black" OnSelectedIndexChanged="grvSalarioMinimo_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdSalarioMinimo" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdSalarioMinimo" />
                        <asp:BoundField DataField="Desde" HeaderText="Desde" SortExpression="Desde" />
                        <asp:BoundField DataField="Hasta" HeaderText="Hasta" SortExpression="Hasta" />
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
                <asp:GridView ID="grvSalarioMinimo0" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataKeyNames="IdSalarioMinimo" DataSourceID="SdsSalarioMinimo" ForeColor="Black" OnSelectedIndexChanged="grvSalarioMinimo_SelectedIndexChanged" Visible="False">
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
                <asp:SqlDataSource ID="SdsSalarioMinimo" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" InsertCommand="Usp_SalarioMinimoInsert" InsertCommandType="StoredProcedure" SelectCommand="Usp_BuscarSalarioMinimo_" SelectCommandType="StoredProcedure" UpdateCommand="Usp_SalarioMinimoUpdate" UpdateCommandType="StoredProcedure">
                    <InsertParameters>
                        <asp:Parameter DbType="Date" Name="Desde" />
                        <asp:Parameter DbType="Date" Name="Hasta" />
                        <asp:Parameter Name="Valor" Type="Int32" />
                        <asp:Parameter Name="Norma" Type="String" />
                        <asp:Parameter Name="EsActivo" Type="Boolean" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="IdSalarioMinimo" Type="Int32" />
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
                <asp:HiddenField ID="hfIdSalarioMinimo" runat="server" Visible="False" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
