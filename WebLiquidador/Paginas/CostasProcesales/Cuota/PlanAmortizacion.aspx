<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCpp.Master" AutoEventWireup="true" CodeBehind="PlanAmortizacion.aspx.cs" Inherits="WebLiquidador.Paginas.CostasProcesales.Cuota.PlanAmortizacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
    .auto-style10 {
        width: 61%;
    }
        .auto-style11 {
            width: 70%;
        }
        .auto-style12 {
            width: 72%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style1">
        <tr>
            <td><h2>Plan de Amortización - Facilidad de pago: 
                <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                    </h2></td>
        </tr>
        </table>
<table class="auto-style10">
        <tr>
            <td>Identificación<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtIdentificacion" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
            </td>
            <td>Deudor</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtIdentificacion" runat="server" Width="170px" MaxLength="10"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtIdentificacion_TextBoxWatermarkExtender" runat="server" BehaviorID="txtIdentificacion_TextBoxWatermarkExtender" TargetControlID="txtIdentificacion" WatermarkText="Identificacion" />
                <Ajax:FilteredTextBoxExtender ID="txtIdentificacion_FilteredTextBoxExtender" runat="server" BehaviorID="txtIdentificacion_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=",." TargetControlID="txtIdentificacion" />
            </td>
            <td colspan="2"><asp:TextBox ID="txtNombre" runat="server" Width="260px" MaxLength="200" Enabled="False" Font-Bold="True" ForeColor="Maroon" ReadOnly="True" ></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtNombre_TextBoxWatermarkExtender" runat="server" BehaviorID="txtNombre_TextBoxWatermarkExtender" TargetControlID="txtNombre" WatermarkText="Nombre y Apellidos" />
            </td>
            <td>
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td>&nbsp;</td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        </table>
    <table class="auto-style12">
        <tr>
            <td>
                <asp:GridView ID="grvObligaciones" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" AutoGenerateColumns="False" OnSelectedIndexChanged="grvObligaciones_SelectedIndexChanged" Width="1256px" AllowPaging="True" AllowSorting="True" DataSourceID="SdsObligacionXDeudor" PageSize="5" OnDataBound="grvObligaciones_DataBound">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdObligacion" HeaderText="IdO" SortExpression="IdObligacion" />
                        <asp:BoundField DataField="NombreTipoObligacion" HeaderText="Obligacion" SortExpression="NombreTipoObligacion" />
                        <asp:BoundField DataField="NumeroProceso" HeaderText="NumeroProceso" SortExpression="NumeroProceso" />
                        <asp:BoundField DataField="FechaEjecutoria" DataFormatString="{0:d}" HeaderText="Ejecutoria" SortExpression="FechaEjecutoria" />
                        <asp:BoundField DataField="ValorPrimeraInstancia" DataFormatString="{0:N0}" HeaderText="PInstancia" SortExpression="ValorPrimeraInstancia" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorSegundaInstancia" DataFormatString="{0:N0}" HeaderText="SInstancia" SortExpression="ValorSegundaInstancia" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorSedeCasacion" HeaderText="SCasacion" SortExpression="ValorSedeCasacion" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorCostas" DataFormatString="{0:N0}" HeaderText="Valor" SortExpression="ValorCostas">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SaldoCostas" DataFormatString="{0:N0}" HeaderText="Saldo" SortExpression="SaldoCostas">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaSaldoCostas" DataFormatString="{0:d}" HeaderText="Fecha" SortExpression="FechaSaldoCostas" />
                        <asp:BoundField DataField="NombreJuzgado" HeaderText="Juzgado" SortExpression="NombreJuzgado" />
                        <asp:BoundField DataField="NombreAbogado" HeaderText="Abogado" SortExpression="NombreAbogado" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="EsActivo" SortExpression="EsActivo" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#5C6E3E" Font-Bold="True" ForeColor="White" />
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
    <table class="auto-style11">
        <tr>
            <td>Saldo Capital - Obligación</td>
            <td>Plazo en Meses</td>
            <td>Tasa Nominal Anual</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td><asp:TextBox ID="txtSaldoCapital" runat="server" Width="170px" MaxLength="10" Enabled="False" Font-Bold="True" ForeColor="Maroon" ></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtSaldoCapital_FilteredTextBoxExtender" runat="server" BehaviorID="txtValorCapital_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtSaldoCapital" />
            </td>
            <td>
                <asp:DropDownList ID="ddlMesesPlazo" runat="server" DataSourceID="SdsMesesPlazos" DataTextField="Mes" DataValueField="IdMesesPlazo" Width="170px" Enabled="False">
                </asp:DropDownList>
            </td>
            <td><asp:TextBox ID="txtTasa" runat="server" Width="170px" MaxLength="5" Enabled="False" Font-Bold="True" ForeColor="Maroon" ></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtTasa_FilteredTextBoxExtender" runat="server" BehaviorID="txtTasa_FilteredTextBoxExtender" FilterType="Custom, Numbers" TargetControlID="txtTasa" ValidChars=".," />
            </td>
            <td>
                <asp:Button ID="btnCalcular" runat="server" OnClick="btnCalcular_Click" Text="Calcular" Width="170px" Enabled="False" />
            </td>
            <td>
                <asp:Button ID="btnImprimir" runat="server" OnClick="btnImprimir_Click" Text="Imprimir" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnImprimir_ConfirmButtonExtender" runat="server" ConfirmText="Está Seguro?" TargetControlID="btnImprimir" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:GridView ID="grvPlan" runat="server" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" AutoGenerateColumns="False" Caption="Plan de Amortización">
                    <AlternatingRowStyle BackColor="PaleGoldenrod" Font-Bold="False" />
                    <Columns>
                        <asp:BoundField DataField="Mes" HeaderText="Mes">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Abono a Capital" DataFormatString="{0:N0}" HeaderText="Abono a Capital">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Valor Interes" DataFormatString="{0:N0}" HeaderText="Valor Interes">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Valor Cuota" DataFormatString="{0:N0}" HeaderText="Valor Cuota">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Nuevo Saldo" DataFormatString="{0:N0}" HeaderText="Nuevo Saldo">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
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
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        </table>
    <table class="auto-style11">
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
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfIdRegional" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsMesesPlazos" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CostasProcesales].[Usp_BuscarMesesPlazo]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsObligacionXDeudor" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CostasProcesales].[Usp_BuscarObligacionXDeudor]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfIdDeudor" Name="IdDeudor" PropertyName="Value" Type="Int32" />
                        <asp:ControlParameter ControlID="txtIdentificacion" Name="Identificacion" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfIdObligacion" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfIdDeudor" runat="server" Visible="False" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
