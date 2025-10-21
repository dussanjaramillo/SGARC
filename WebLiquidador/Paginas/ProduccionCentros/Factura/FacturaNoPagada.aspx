<%@ Page Title="Prefactura No Pagada" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="FacturaNoPagada.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Factura.FacturaNoPagada" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="3">
                <h2>Prefactura No Pagada</h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style9">Fecha Inicial 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFechaInicial" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
            </td>
            <td>Fecha Final<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFechaFinal" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
            </td>
            <td>Fecha Respuesta<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtFechaRespuesta" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnContinuar"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style9">
                <asp:TextBox ID="txtFechaInicial" runat="server" MaxLength="10" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtFechaInicial_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaInicial_TextBoxWatermarkExtender" TargetControlID="txtFechaInicial" WatermarkText="Fecha Inicial" />
                <Ajax:CalendarExtender ID="txtFechaInicial_CalendarExtender" runat="server" BehaviorID="txtFechaInicial_CalendarExtender" Format="yyyy-MM-dd" TargetControlID="txtFechaInicial" />
            </td>
            <td>
                <asp:TextBox ID="txtFechaFinal" runat="server" MaxLength="10" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtFechaFinal_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaFinal_TextBoxWatermarkExtender" TargetControlID="txtFechaFinal" WatermarkText="Fecha Final" />
                <Ajax:CalendarExtender ID="txtFechaFinal_CalendarExtender" runat="server" BehaviorID="txtFechaFinal_CalendarExtender" Format="yyyy-MM-dd" TargetControlID="txtFechaFinal" />
            </td>
            <td>
                <asp:TextBox ID="txtFechaRespuesta" runat="server" MaxLength="10" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtFechaRespuesta_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaRespuesta_TextBoxWatermarkExtender" TargetControlID="txtFechaRespuesta" WatermarkText="Fecha Respuesta" />
                <Ajax:CalendarExtender ID="txtFechaRespuesta_CalendarExtender" runat="server" BehaviorID="txtFechaRespuesta_CalendarExtender" Format="yyyy-MM-dd" TargetControlID="txtFechaRespuesta" />
            </td>
        </tr>
        <tr>
            <td class="auto-style9">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" Width="170px" ValidationGroup="btnBuscar" />
            </td>
            <td>
            <asp:Button ID="btn_Limpiar" runat="server" Text="Limpiar" Width="170px" OnClick="btn_Limpiar_Click" ToolTip="Limpia el Formulario" />
            </td>
            <td>
				<asp:Button ID="btnContinuar" runat="server" Enabled="False" Text="Continuar" ValidationGroup="btnContinuar" Width="170px" OnClick="btnContinuar_Click" />
			    <Ajax:ConfirmButtonExtender ID="btnContinuar_ConfirmButtonExtender" runat="server" BehaviorID="btnContinuar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnContinuar" />
			</td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td class="auto-style9">
				<asp:GridView ID="grvCentroFormacion" runat="server" CellPadding="3" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IdCentroFormacion" OnPageIndexChanging="grvCentroFormacion_PageIndexChanging" BackColor="White" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="IdCentroFormacion" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdCentroFormacion" />
                        <asp:BoundField DataField="CodigoSubdirector" HeaderText="Codigo" SortExpression="CodigoSubdirector" />
                        <asp:BoundField DataField="NombreSubdirector" HeaderText="Subdirector" SortExpression="NombreSubdirector" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Centro Formacion" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:CheckBoxField>
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
			    <asp:GridView ID="grvControlSeguimientoFactura" runat="server" AutoGenerateColumns="False" CellPadding="3" BackColor="White" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" PageSize="15">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="NumeroFactura" HeaderText="Prefactura" SortExpression="NumeroFactura" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificación" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre y/o Tercero" SortExpression="Nombre" />
                        <asp:BoundField DataField="Valor" DataFormatString="{0:N0}" HeaderText="Valor Documento" ReadOnly="True" SortExpression="Valor">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaCrea" DataFormatString="{0:d}" HeaderText="Fecha Crea" SortExpression="FechaCrea" />
                        <asp:BoundField DataField="Usuario" HeaderText="Usuario" SortExpression="Usuario" />
                        <asp:BoundField DataField="Pagada" HeaderText="Pagada" SortExpression="Pagada">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
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
			</td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td class="auto-style9">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>&nbsp;</td>
            <td>
			    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarControlSeguimientoCentroFormacion]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtFechaInicial" DbType="Date" Name="FechaInicial" PropertyName="Text" />
                        <asp:ControlParameter ControlID="txtFechaFinal" DbType="Date" Name="FechaFinal" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
			    </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
