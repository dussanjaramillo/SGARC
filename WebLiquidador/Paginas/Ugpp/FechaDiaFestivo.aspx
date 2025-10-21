<%@ Page Title="Fecha Día Festivo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FechaDiaFestivo.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.FechaDiaFestivo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="2">
                <h2>Fecha Dia Festivo</h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td>Fecha Día Festivo<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar" ControlToValidate="txtFechaDiaFestivo" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td>
                <asp:TextBox ID="txtFechaDiaFestivo" runat="server" Width="170px" MaxLength="10" ValidationGroup="btnGuardar"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td>
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" Width="170px" Visible="False" />
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" Width="170px" ValidationGroup="btnGuardar" />
                <Ajax:ConfirmButtonExtender ID="btnGuardar_ConfirmButtonExtender" runat="server" BehaviorID="btnGuardar_ConfirmButtonExtender" ConfirmText="Esta Seguro?" TargetControlID="btnGuardar" />
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td class="auto-style11">
                <asp:GridView ID="gvrFechaDiaFestivo" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="IdFechaDiaFestivo" DataSourceID="SdsFechaDiaFestivo" PageSize="15" AllowSorting="True" OnSelectedIndexChanged="gvrFechaDiaFestivo_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdFechaDiaFestivo" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdFechaDiaFestivo" />
                        <asp:BoundField DataField="FechaDiaFestivo" DataFormatString="{0:d}" HeaderText="Fecha Dia Festivo" SortExpression="FechaDiaFestivo" />
                        <asp:CheckBoxField DataField="Estado" HeaderText="Estado" SortExpression="Estado" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#FF9536" Font-Bold="True" ForeColor="Black" />
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
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style15">
                <asp:SqlDataSource ID="SdsFechaDiaFestivo" runat="server" ConnectionString="<%$ ConnectionStrings:PlanillaConnectionString %>" ProviderName="<%$ ConnectionStrings:PlanillaConnectionString.ProviderName %>" SelectCommand="Usp_BuscaFechaDiaFestivo" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                            <asp:HiddenField ID="HfTransaccion" runat="server" Visible="False" />
                            </td>
            <td class="auto-style9">
                            <asp:HiddenField ID="hfIdFechaDiaFestivo" runat="server" Visible="False" />
                            </td>
            <td class="auto-style9">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
        </tr>
    </table>
</asp:Content>
