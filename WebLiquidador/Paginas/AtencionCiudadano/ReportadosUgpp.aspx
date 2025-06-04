<%@ Page Title="Aportante Reportado a la Ugpp" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportadosUgpp.aspx.cs" Inherits="WebLiquidador.Paginas.AtencionCiudadano.ReportadosUgpp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style9">
        <tr>
            <td><h1>Aportante Reportado a la Ugpp <span style="font-family: &quot;Helvetica Neue&quot;, &quot;Lucida Grande&quot;, &quot;Segoe UI&quot;, Arial, Helvetica, Verdana, sans-serif; font-size: 12.8px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;" class="auto-style8"><strong>Para los Meses de Enero, Abril, Julio y Octubre de cada año</strong></span></h1></td>
        </tr>
        </table>
    <table class="auto-style9">
        <tr>
            <td>Identificación<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtIdentificacion" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
            </td>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtIdentificacion" runat="server" Width="170px"></asp:TextBox>
                <ajax:filteredtextboxextender ID="txtIdentificacion_FilteredTextBoxExtender" runat="server" FilterType="Numbers" TargetControlID="txtIdentificacion" />
            </td>
            <td>
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td>
                <asp:Button ID="btn_Limpiar" runat="server" Text="Limpiar" Width="170px" OnClick="btn_Limpiar_Click" />
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:GridView ID="grvAportantes" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsReportadoUgpp" AllowPaging="True" Caption="Aportante Reportado" class="grvGrilla" CaptionAlign="Left" PageSize="8" OnDataBound="grvAportantes_DataBound" Width="1249px">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="NumeroIdentificacion" HeaderText="Identificacion" SortExpression="NumeroIdentificacion" />
                        <asp:BoundField DataField="TipoIdentificacion" HeaderText="Tipo" SortExpression="TipoIdentificacion" />
                        <asp:BoundField DataField="RazonSocial" HeaderText="RazonSocial" SortExpression="RazonSocial" />
                        <asp:BoundField DataField="ValorCartera" HeaderText="ValorCartera" SortExpression="ValorCartera" DataFormatString="{0:N0}" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="UltimoPeriodoConPagoRegistrado" HeaderText="UltimoPeriodoConPago" SortExpression="UltimoPeriodoConPagoRegistrado" />
                        <asp:BoundField DataField="UltimaFechaPago" HeaderText="UltimaFechaPago" SortExpression="UltimaFechaPago" />
                        <asp:BoundField DataField="FechaProceso" HeaderText="FechaProceso" SortExpression="FechaProceso" />
                        <asp:BoundField DataField="NombreTipoCartera" HeaderText="TipoCartera" SortExpression="NombreTipoCartera" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#999999" Font-Bold="True" ForeColor="Black" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
                <asp:GridView ID="grvLosPagos" runat="server" DataSourceID="SdsPagos" AutoGenerateColumns="False" class="grvGrilla" BackColor="LightGoldenrodYellow" BorderColor="Black" BorderWidth="1px" CellPadding="2" ForeColor="Black" OnRowDataBound="grvLosPagos_RowDataBound" OnDataBound="grvLosPagos_DataBound">
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    <Columns>
                        <asp:BoundField DataField="Vigencia" HeaderText="Vigencia" SortExpression="Vigencia" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Ene" HeaderText="Ene" SortExpression="Ene" />
                        <asp:BoundField DataField="FechaEne" HeaderText="FechaEne" SortExpression="FechaEne" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Feb" HeaderText="Feb" SortExpression="Feb" />
                        <asp:BoundField DataField="FechaFeb" HeaderText="FechaFeb" SortExpression="FechaFeb" />
                        <asp:BoundField DataField="Mar" HeaderText="Mar" SortExpression="Mar" />
                        <asp:BoundField DataField="FechaMar" HeaderText="FechaMar" SortExpression="FechaMar" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Abr" HeaderText="Abr" SortExpression="Abr" />
                        <asp:BoundField DataField="FechaAbr" HeaderText="FechaAbr" SortExpression="FechaAbr" >
                        </asp:BoundField>
                        <asp:BoundField DataField="May" HeaderText="May" SortExpression="May" />
                        <asp:BoundField DataField="FechaMay" HeaderText="FechaMay" SortExpression="FechaMay" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Jun" HeaderText="Jun" SortExpression="Jun" />
                        <asp:BoundField DataField="FechaJun" HeaderText="FechaJun" SortExpression="FechaJun" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Jul" HeaderText="Jul" SortExpression="Jul" />
                        <asp:BoundField DataField="FechaJul" HeaderText="FechaJul" SortExpression="FechaJul" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Ago" HeaderText="Ago" SortExpression="Ago" />
                        <asp:BoundField DataField="FechaAgo" HeaderText="FechaAgo" SortExpression="FechaAgo" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Sep" HeaderText="Sep" SortExpression="Sep" />
                        <asp:BoundField DataField="FechaSep" HeaderText="FechaSep" SortExpression="FechaSep" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Oct" HeaderText="Oct" SortExpression="Oct" />
                        <asp:BoundField DataField="FechaOct" HeaderText="FechaOct" SortExpression="FechaOct" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Nov" HeaderText="Nov" SortExpression="Nov" />
                        <asp:BoundField DataField="FechaNov" HeaderText="FechaNov" SortExpression="FechaNov" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Dic" HeaderText="Dic" SortExpression="Dic" />
                        <asp:BoundField DataField="FechaDic" HeaderText="FechaDic" SortExpression="FechaDic" />
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
                <table class="auto-style10">
                    <tr>
                        <td class="auto-style8"><strong>Valor Presuntivo</strong></td>
                        <td>
                            <strong>
                            <asp:Label ID="lbValorPresuntivo" runat="server"></asp:Label>
                            </strong>
                        </td>
                        <td><strong>Intereses</strong></td>
                        <td>
                            <strong>
                            <asp:Label ID="lbIntereses" runat="server"></asp:Label>
                            </strong>
                        </td>
                        <td><strong>Total</strong></td>
                        <td>
                            <strong>
                            <asp:Label ID="lbTotal" runat="server"></asp:Label>
                            </strong>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style8" colspan="6"><strong>
                            <asp:Label ID="lblSinPagos" runat="server" CssClass="auto-style9" Visible="False"></asp:Label>
                            </strong></td>
                    </tr>
                </table>
                <asp:GridView ID="grvPeriodoDesactivados" runat="server" Caption="Periodo Desactivados" AutoGenerateColumns="False" class="grvGrilla" DataSourceID="SdsPeriodoDesactivado" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="Razon_PU_Desac" HeaderText="Razon Social" SortExpression="Razon_PU_Desac" />
                        <asp:BoundField DataField="Fecha_PU_Desac" HeaderText="Fecha Desactivación" SortExpression="Fecha_PU_Desac" />
                        <asp:BoundField DataField="FechIni_PU_Desac" HeaderText="Fecha Inicio" SortExpression="FechIni_PU_Desac" />
                        <asp:BoundField DataField="Motivo_PU_Desac" HeaderText="Motivo" SortExpression="Motivo_PU_Desac" />
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
                <asp:GridView ID="grvPeriodoExentos" runat="server" class="grvGrilla" Caption="Periodos Exentos" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" Width="229px">
                    <AlternatingRowStyle BackColor="White" />
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
                <br />
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsPagos" runat="server" ConnectionString="<%$ ConnectionStrings:PlanillaConnectionString %>" SelectCommand="Usp_BuscarPagosAportante" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtIdentificacion" Name="Identificacion" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsReportadoUgpp" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="ugpp.Usp_BuscarReportadosUgpp" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtIdentificacion" Name="NumeroIdentificacion" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsPeriodoDesactivado" runat="server" ConnectionString="<%$ ConnectionStrings:PlanillaConnectionString %>" SelectCommand="PU_SP_Consulta_Desactivacion" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtIdentificacion" Name="NumID" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfVigenciaMesMax" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfVigenciaMesMin" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hfUltimoPeriodo" runat="server" />
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
