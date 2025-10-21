<%@ Page Title="Unidad Productiva" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="UnidadProductiva.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.UnidadProductiva" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="8"><h2>Unidad Productiva 
                <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                    </h2></td>
        </tr>
        <tr>
            <td class="auto-style9">Regional</td>
            <td>Centro Formación</td>
            <td>Unidad Productiva</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style11">
                            <asp:DropDownList ID="ddlRegional" runat="server" Width="170px" ToolTip="Regional del Usuario" DataSourceID="SdsRegional" DataTextField="NombreRegional" DataValueField="IdRegional" OnDataBound="ddlRegional_DataBound" AutoPostBack="True" OnSelectedIndexChanged="ddlRegional_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
            <td>
                            <asp:DropDownList ID="ddlCentroFormacion" runat="server" Width="340px" OnSelectedIndexChanged="ddlCentroFormacion_SelectedIndexChanged" AutoPostBack="True" DataSourceID="SdsBuscarCentroXRegional" DataTextField="NombreCentroFormacion" DataValueField="IdCentroFormacion" OnDataBound="ddlCentroFormacion_DataBound">
                            </asp:DropDownList>
                        </td>
            <td>
                <asp:TextBox ID="txtNombreUnidadProductiva" runat="server" MaxLength="100" Width="170px" ValidationGroup="btnGuardar"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chbEsActivo" runat="server" Checked="True" Font-Bold="True" ForeColor="Maroon" Text="Activo" TextAlign="Left" ToolTip="Es Activo?" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style13">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlRegional" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
                        </td>
            <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlCentroFormacion" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
                        </td>
            <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNombreUnidadProductiva" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
                        </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" Enabled="False" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnExportar_ConfirmButtonExtender" runat="server" BehaviorID="btnExportar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnExportar" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:GridView ID="grvUnidadProductiva" runat="server" DataSourceID="SqlUnidadProductiva" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdUnidadProductiva" GridLines="Vertical" AllowPaging="True" AllowSorting="True" OnSelectedIndexChanged="grvUnidadProductiva_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="IdUnidadProductiva" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdUnidadProductiva" />
                        <asp:BoundField DataField="NombreUnidadProductiva" HeaderText="UnidadProductiva" SortExpression="NombreUnidadProductiva" />
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
                <asp:GridView ID="grvUnidadProductiva0" runat="server" DataSourceID="SdsUnidadProductiva" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" OnSelectedIndexChanged="grvUnidadProductiva_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
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
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                            <asp:SqlDataSource ID="SdsRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarRegional" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                            </td>
            <td>
                <asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
            </td>
            <td>
                            <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                            </asp:ScriptManager>
                            </td>
            <td>
                <asp:SqlDataSource ID="SdsBuscarCentroXRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCentroXRegional]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlRegional" Name="IdRegional" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SqlUnidadProductiva" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_UnidadProductivaBuscar]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                            <asp:HiddenField ID="hfIdUnidadProductiva" runat="server" />
                            </td>
            <td>
                            <asp:HiddenField ID="hfIdCentroFormacion" runat="server" />
                            </td>
            <td>
                            <asp:SqlDataSource ID="SdsUnidadProductiva" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_UnidadProductivaBuscarUnicos]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
