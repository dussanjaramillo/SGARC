<%@ Page Title="Obligación" Language="C#" MasterPageFile="~/SiteCpp.Master" AutoEventWireup="true" CodeBehind="Obligacion.aspx.cs" Inherits="WebLiquidador.Paginas.CostasProcesales.Obligacion.Obligacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style1">
        <tr>
            <td><h2>Obligacion: 
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
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" />
            </td>
            <td>
                <asp:Button ID="btnAgregar" runat="server" OnClick="btnAgregar_Click" Text="Agregar" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnAgregar_ConfirmButtonExtender" runat="server" BehaviorID="btnAgregar_ConfirmButtonExtender" ConfirmText="Esta Seguro?" TargetControlID="btnAgregar" />
            </td>
            <td>
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" Enabled="False" ValidationGroup="btnGuardar" />
                <Ajax:ConfirmButtonExtender ID="btnGuardar_ConfirmButtonExtender" runat="server" BehaviorID="btnGuardar_ConfirmButtonExtender" ConfirmText="Esta Seguro?" TargetControlID="btnGuardar" />
            </td>
            <td>
                <asp:Button ID="btnImprimir" runat="server" OnClick="btnImprimir_Click" Text="Imprimir" Enabled="False" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" />
            </td>
        </tr>
        </table>
    <table class="auto-style12">
        <tr>
            <td class="auto-style18">
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
            <td colspan="7" style="background-color: #6E8A34">
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="7" style="background-color: #5C6E3E">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                Obligación<br />
                <asp:DropDownList ID="ddlTipoObligacion" runat="server" DataSourceID="SdsTipoObligacion" DataTextField="NombreTipoObligacion" DataValueField="IdTipoObligacion" Enabled="False" OnDataBound="ddlTipoObligacion_DataBound" ValidationGroup="btnGuardar" Width="170px">
                </asp:DropDownList>
            </td>
            <td>Fecha Ejecutoria<br />
                <asp:TextBox ID="txtFechaEjecutoria" runat="server" Enabled="False" MaxLength="10" ValidationGroup="btnGuardar"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtFechaEjecutoria_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaEjecutoria_TextBoxWatermarkExtender" TargetControlID="txtFechaEjecutoria" WatermarkText="Fecha Ejecutoria" />
                <Ajax:CalendarExtender ID="txtFechaEjecutoria_CalendarExtender" runat="server" BehaviorID="txtFechaEjecutoria_CalendarExtender" Format="dd-MM-yyyy" TargetControlID="txtFechaEjecutoria" />
            </td>
            <td>Número Proceso<br />
                <asp:TextBox ID="txtNumeroProceso" runat="server" Enabled="False" MaxLength="23" ValidationGroup="btnGuardar"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtNumeroProceso_TextBoxWatermarkExtender" runat="server" BehaviorID="txtNumeroProceso_TextBoxWatermarkExtender" TargetControlID="txtNumeroProceso" WatermarkText="Número Proceso" />
                <Ajax:FilteredTextBoxExtender ID="txtNumeroProceso_FilteredTextBoxExtender" runat="server" BehaviorID="txtNumeroProceso_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtNumeroProceso" />
            </td>
            <td>Primera Instancia<asp:TextBox ID="txtPrimeraInstancia" runat="server" Enabled="False" MaxLength="10" ValidationGroup="btnGuardar"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtPrimeraInstancia_TextBoxWatermarkExtender" runat="server" BehaviorID="txtPrimeraInstancia_TextBoxWatermarkExtender" TargetControlID="txtPrimeraInstancia" WatermarkText="Valor Primera Instancia" />
            </td>
            <td>Segunda Instancia<asp:TextBox ID="txtSegundaInstancia" runat="server" Enabled="False" MaxLength="10" ValidationGroup="btnGuardar"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtSegundaInstancia_FilteredTextBoxExtender" runat="server" BehaviorID="txtSegundaInstancia_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtSegundaInstancia" />
                <Ajax:TextBoxWatermarkExtender ID="txtSegundaInstancia_TextBoxWatermarkExtender" runat="server" BehaviorID="txtSegundaInstancia_TextBoxWatermarkExtender" TargetControlID="txtSegundaInstancia" WatermarkText="Valor Segunda Instancia" />
            </td>
            <td>Sede Casación<asp:TextBox ID="txtSedeCasacion" runat="server" Enabled="False" MaxLength="10" ValidationGroup="btnGuardar"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtSedeCasacion_TextBoxWatermarkExtender" runat="server" BehaviorID="txtSedeCasacion_TextBoxWatermarkExtender" TargetControlID="txtSedeCasacion" WatermarkText="Valor Sede Casación" />
            </td>
            <td>Valor Costas<asp:TextBox ID="txtValorCostas" runat="server" Enabled="False" MaxLength="10" Font-Bold="True" ForeColor="Maroon"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtValorCostas_TextBoxWatermarkExtender" runat="server" BehaviorID="txtValorCostas_TextBoxWatermarkExtender" TargetControlID="txtValorCostas" WatermarkText="Valor Costas" />
            </td>
        </tr>
        <tr>
            <td class="auto-style15">Saldo Costas<asp:TextBox ID="txtSaldoCostas" runat="server" Enabled="False" MaxLength="10" ForeColor="Maroon"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtSaldoCostas_FilteredTextBoxExtender" runat="server" BehaviorID="txtSaldoCostas_FilteredTextBoxExtender" FilterType="Numbers" TargetControlID="txtSaldoCostas" />
                <Ajax:TextBoxWatermarkExtender ID="txtSaldoCostas_TextBoxWatermarkExtender" runat="server" BehaviorID="txtSaldoCapital_TextBoxWatermarkExtender" TargetControlID="txtSaldoCostas" WatermarkText="Saldo Costas" />
            </td>
            <td class="auto-style15">
                Fecha Saldo<asp:TextBox ID="txtFechaSaldo" runat="server" Enabled="False" MaxLength="10" ForeColor="Maroon"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtFechaSaldo_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaSaldo_TextBoxWatermarkExtender" TargetControlID="txtFechaSaldo" WatermarkText="Fecha Saldo" />
                <Ajax:CalendarExtender ID="txtFechaSaldo_CalendarExtender" runat="server" BehaviorID="txtFechaSaldo_CalendarExtender" Format="dd-MM-yyyy" TargetControlID="txtFechaSaldo" />
            </td>
            <td class="auto-style15">
                Regional<br />
                <asp:DropDownList ID="ddlRegional" runat="server" Width="170px" ToolTip="Regional del Usuario" DataSourceID="SdsRegional" DataTextField="NombreRegional" DataValueField="IdRegional" OnDataBound="ddlRegional_DataBound" AutoPostBack="True" Enabled="False">
                </asp:DropDownList>
            </td>
            <td class="auto-style15">
                Abogado<asp:DropDownList ID="ddlAbogado" runat="server" Width="170px" DataSourceID="SdsAbogadoXRegional" Enabled="False" OnDataBound="ddlAbogado_DataBound" DataTextField="Nombre" DataValueField="IdAbogado">
                </asp:DropDownList>
            </td>
            <td class="auto-style15">
                <asp:CheckBox ID="chbEsActivo" runat="server" Checked="True" Font-Bold="True" ForeColor="Maroon" Text="Activo" ToolTip="Es Activo?" />
                <br />
            </td>
            <td class="auto-style15">
                &nbsp;</td>
            <td class="auto-style15">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">Departamento<br />
                <asp:DropDownList ID="ddlDepartamento" runat="server" AutoPostBack="True" DataSourceID="SdsDepartamento" DataTextField="NombreDepartamento" DataValueField="IdDepartamento" OnDataBound="ddlDepartamento_DataBound" Width="170px" Enabled="False">
                </asp:DropDownList>
            </td>
            <td class="auto-style15">
                Municipio<br />
                <asp:DropDownList ID="ddlMunicipio" runat="server" Width="170px" AutoPostBack="True" DataSourceID="SdsMunicipoXDepartamento" DataTextField="NombreMunicipio" DataValueField="IdMunicipio" Enabled="False" OnDataBound="ddlMunicipio_DataBound">
                </asp:DropDownList>
            </td>
            <td class="auto-style15" colspan="2">
                Juzgado<br />
                <asp:DropDownList ID="ddlJuzgado" runat="server" Width="252px" DataSourceID="SdsJuzgadosXMunicipio" DataTextField="Nombre" DataValueField="IdJuzgado" Enabled="False" OnDataBound="ddlJuzgado_DataBound">
                </asp:DropDownList>
            </td>
            <td class="auto-style15">
                &nbsp;</td>
            <td class="auto-style15">
                &nbsp;</td>
            <td class="auto-style15">
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="7" style="background-color: #6E8A34">
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="7">
                <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="SdsPagosXIdObligacion" class="grvGrilla" ForeColor="Black" GridLines="Vertical" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" Caption="Pagos Recibidos" CaptionAlign="Left" PageSize="5">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="ValorTotalPago" HeaderText="ValorTotalPago" SortExpression="ValorTotalPago">
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaPago" DataFormatString="{0:d}" HeaderText="FechaPago" SortExpression="FechaPago" />
                        <asp:BoundField DataField="NumeroCuponPago" HeaderText="CuponPago" SortExpression="NumeroCuponPago" />
                        <asp:BoundField DataField="SaldoAnterior" DataFormatString="{0:N0}" HeaderText="Saldo Anterior" SortExpression="SaldoAnterior">
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaSaldoAnterior" DataFormatString="{0:d}" HeaderText="FechaSaldoAnterior" SortExpression="FechaSaldoAnterior">
                        </asp:BoundField>
                        <asp:BoundField DataField="NuevoSaldo" DataFormatString="{0:N0}" HeaderText="NuevoSaldo" SortExpression="NuevoSaldo">
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorACapital" DataFormatString="{0:N0}" HeaderText="ValorACapital" SortExpression="ValorACapital" />
                        <asp:BoundField DataField="ValorIntereses" DataFormatString="{0:N0}" HeaderText="ValorIntereses" SortExpression="ValorIntereses" />
                        <asp:BoundField DataField="NumeroDias" DataFormatString="{0:N0}" HeaderText="NumeroDias" SortExpression="NumeroDias" />
                        <asp:BoundField DataField="TasaInteres" HeaderText="TasaInteres" SortExpression="TasaInteres" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="Aplicado?" SortExpression="EsActivo" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:CheckBoxField>
                    </Columns>
                    <FooterStyle BackColor="#CCCC99" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#F7F7DE" />
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#FBFBF2" />
                    <SortedAscendingHeaderStyle BackColor="#848384" />
                    <SortedDescendingCellStyle BackColor="#EAEAD3" />
                    <SortedDescendingHeaderStyle BackColor="#575357" />
                </asp:GridView>
            </td>
        </tr>
        </table>
    <table class="auto-style11">
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfIdRegional" runat="server" />
            </td>
            <td>
                &nbsp;</td>
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
                <asp:SqlDataSource ID="SdsTipoObligacion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CostasProcesales].[Usp_BuscarTipoObligacion]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hfErrorValidacion" runat="server" Visible="False" />
            </td>
            <td>
                <asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
            </td>
            <td>
                &nbsp;</td>
            <td>
                <asp:HiddenField ID="hfIdDeudor" runat="server" Visible="False" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarRegional" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsJuzgadosXMunicipio" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_JuzgadoPorMunicipio" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlMunicipio" Name="IdMunicipio" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsAbogadoXRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CostasProcesales].[Usp_AbogadoPorRegional]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlRegional" Name="IdRegional" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
            <td>
                <asp:SqlDataSource ID="SdsMunicipoXDepartamento" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_MunicipiosPorDepartamento" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlDepartamento" Name="IdDepartamento" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsDepartamento" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarDepartamento" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsPagosXIdObligacion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CostasProcesales].[Usp_BuscarPagosObligacionXId]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfIdObligacion" Name="IdObligacion" PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
