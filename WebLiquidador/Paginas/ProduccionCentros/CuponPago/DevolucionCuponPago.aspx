<%@ Page Title="Devolucion Cupón de Pago" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="DevolucionCuponPago.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.DevolucionCuponPago" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">
        .auto-style8 {
            height: 26px;
        }
        .auto-style9 {
            height: 29px;
        }
        </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="3">
                <h2>Autorizar Devolucion de Cupón de Pago</h2>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #CCCCFF">
                <h1>Origen</h1>
            </td>
        </tr>
        <tr>
            <td>Cupón de Pago<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCuponPago" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnBuscar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style9">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtCuponPago" runat="server" MaxLength="8" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtCuponPago_FilteredTextBoxExtender" runat="server" BehaviorID="txtCuponPago_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtCuponPago" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar0" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                Valor Total Devolución<br />
                <asp:TextBox ID="txtValorTotalDevolucion" runat="server" Enabled="False" ForeColor="Maroon" Width="170px" Font-Bold="True"></asp:TextBox>
            </td>
            <td class="auto-style9">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:GridView ID="grvDevoluciones" runat="server" DataSourceID="SdsDevolucionCuponPagoDetalle" AutoGenerateColumns="False" BackColor="White" class="grvGrilla" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" Caption="Detalle Devolución">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="ValorDevolucion" HeaderText="ValorDevolucion" SortExpression="ValorDevolucion" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" SortExpression="FechaCrea" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="FechaModifica" HeaderText="FechaAprobado" SortExpression="FechaModifica" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Observacion" HeaderText="Observacion" SortExpression="Observacion" />
                        <asp:BoundField DataField="NombreMotivoDevolucion" HeaderText="Motivo Devolucion" SortExpression="NombreMotivoDevolucion" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
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
                <asp:GridView ID="grvPagosDisponibles" runat="server" DataSourceID="SdsCuponPagoActivoXNroInternodeTransaccion" AllowSorting="True" class="grvGrilla" Caption="Pago Disponible" AutoGenerateColumns="False" DataKeyNames="IdCuponPago" OnSelectedIndexChanged="grvPagosDisponibles_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdCuponPago" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdCuponPago" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Código" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Nombre" SortExpression="NombreCentroFormacion" />
<%--                        <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="NroInterno" SortExpression="NroInternodeTransaccion" />--%>
                        <asp:BoundField DataField="ValorPago" HeaderText="ValorPago" SortExpression="ValorPago" DataFormatString="{0:N0}">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
<%--                        <asp:BoundField DataField="FechaPago" DataFormatString="{0:d}" HeaderText="FechaPago" SortExpression="FechaPago" />--%>
                    </Columns>
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
                Valor a Devolver<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtValorCuponDevolver" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnDevolverCuponPago" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style9">
                Motivo Devolución<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlMotivoDevolucion" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnDevolverCuponPago" InitialValue="-1" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td>
                Observaciones<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtObservacion" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnDevolverCuponPago"></asp:RequiredFieldValidator>
                </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtValorCuponDevolver" runat="server" Width="170px" MaxLength="10" Enabled="False" ValidationGroup="btnDevolverCuponPago"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtValorCuponDevolver_TextBoxWatermarkExtender" runat="server" BehaviorID="txtValorCuponDevolver_TextBoxWatermarkExtender" TargetControlID="txtValorCuponDevolver" WatermarkText="Valor a Devolver" />
                <Ajax:FilteredTextBoxExtender ID="txtValorCuponDevolver_FilteredTextBoxExtender" runat="server" BehaviorID="txtValorCupon_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtValorCuponDevolver" />
                </td>
            <td class="auto-style9">
                <asp:DropDownList ID="ddlMotivoDevolucion" runat="server" DataSourceID="SdsMotivoDevolucion" DataTextField="NombreMotivoDevolucion" DataValueField="IdMotivoDevolucion" Enabled="False" OnDataBound="ddlMotivoDevolucion_DataBound" Width="170px" ValidationGroup="btnDevolverCuponPago">
                </asp:DropDownList>
            </td>
            <td>
                <asp:TextBox ID="txtObservacion" runat="server" Width="340px" Enabled="False" ValidationGroup="btnDevolverCuponPago"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtObservacion_TextBoxWatermarkExtender" runat="server" BehaviorID="txtObservacion_TextBoxWatermarkExtender" TargetControlID="txtObservacion" WatermarkText="Hasta 300 Caractéres" />
                </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Button ID="btnDevolverCuponPago" runat="server" OnClick="btnDevolverCuponPago_Click" Text="Autorizar" Width="170px" ValidationGroup="btnDevolverCuponPago" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnDevolverCuponPago_ConfirmButtonExtender" runat="server" BehaviorID="btnDevolverCuponPago_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnDevolverCuponPago" />
                </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsCuponPagoActivoXNroInternodeTransaccion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCuponPagoActivoXNroInternodeTransaccion]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtCuponPago" Name="NroInternodeTransaccion" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfIdCuponPago" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsMotivoDevolucion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarMotivoDevolucion]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                </td>
            <td>
                <asp:HiddenField ID="hfItem" runat="server" />
                </td>
            <td colspan="3">
                <asp:HiddenField ID="hfValorCupon" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfValorCuponEs" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsDevolucionCuponPagoDetalle" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarDevolucionCuponPagoDetalle]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtCuponPago" Name="NroInternodeTransaccion" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfIdCentroFormacion" runat="server" />
            </td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
