<%@ Page Title="Estado de Cuenta - Cartera" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EstadoCuenta.aspx.cs" Inherits="WebLiquidador.Paginas.AtencionCiudadano.EstadoCuenta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">


        <script type="text/javascript">
        (function () {
            // Union of Chrome, Firefox, IE, Opera, and Safari console methods
            var methods = ["assert", "cd", "clear", "count", "countReset",
              "debug", "dir", "dirxml", "error", "exception", "group", "groupCollapsed",
              "groupEnd", "info", "log", "markTimeline", "profile", "profileEnd",
              "select", "table", "time", "timeEnd", "timeStamp", "timeline",
              "timelineEnd", "trace", "warn"];
            var length = methods.length;
            var console = (window.console = window.console || {});
            var method;
            var noop = function () { };
            while (length--) {
                method = methods[length];
                // define undefined methods as noops to prevent errors
                if (!console[method])
                    console[method] = noop;
            }
        })();
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td class="auto-style9" colspan="7"><h2>Estado de Cuenta Histórico - Cartera Regional</h2></td>
        </tr>
        <tr>
            <td class="auto-style10">Identificación</td>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style12">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:TextBox ID="txtIdentificacion" runat="server" Width="170px"></asp:TextBox>
                <Ajax:FilteredTextBoxExtender ID="txtIdentificacion_FilteredTextBoxExtender" runat="server" FilterType="Numbers" TargetControlID="txtIdentificacion" />
            </td>
            <td class="auto-style8">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td class="auto-style12">
                <asp:Button ID="btn_Limpiar" runat="server" Text="Limpiar" Width="170px" OnClick="btn_Limpiar_Click" />
            </td>
            <td>
                <asp:Button ID="btnReporte" runat="server" Text="Reporte" Width="170px" OnClick="btnReporte_Click" Visible="False" />
            </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtIdentificacion" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style8">
                &nbsp;</td>
            <td class="auto-style12">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <table class="auto-style6">
        <tr>
            <td>
                <asp:GridView ID="grvAportantes" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsAportante" AllowPaging="True" Caption="Nombres del Aportante" class="grvGrilla" CaptionAlign="Left" PageSize="5" OnDataBound="grvAportantes_DataBound" Width="1085px" AllowSorting="True">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="Regional" HeaderText="Regional" SortExpression="Regional" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="NombreAportante" HeaderText="Nombre Aportante" SortExpression="NombreAportante" />
                        <asp:BoundField DataField="Telefono" HeaderText="Telefono" SortExpression="Telefono" />
                        <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion" />
                        <asp:BoundField DataField="CedulaRepresentante" HeaderText="Cedula" SortExpression="CedulaRepresentante" />
                        <asp:BoundField DataField="Representante" HeaderText="Representante" SortExpression="Representante" />
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
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grvResoluciones" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" Caption="Resoluciones" class="grvGrilla" CellPadding="3" DataSourceID="SdsResoluciones" AllowPaging="True" PageSize="5" Width="1085px" AllowSorting="True">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="CodigoRegional" HeaderText="Regional" SortExpression="CodigoRegional" />
                        <asp:BoundField DataField="Resolucion" HeaderText="Resolucion" SortExpression="Resolucion" />
                        <asp:BoundField DataField="FECHA" HeaderText="Fecha" SortExpression="FECHA" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Concepto" HeaderText="Concepto" SortExpression="Concepto" />
                        <asp:BoundField DataField="Estado" HeaderText="Estado" SortExpression="Estado" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Saldo" HeaderText="Saldo" SortExpression="Saldo" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Ejecutoria" HeaderText="Ejecutoria" SortExpression="Ejecutoria" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" SortExpression="Observaciones" />
                        <asp:BoundField DataField="Fiscalizador" HeaderText="Fiscalizador" SortExpression="Fiscalizador" />
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
            <td>
                <asp:GridView ID="GrvPagosResoluciones" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" Caption="Pagos a Resoluciones" CaptionAlign="Left" class="grvGrilla" CellPadding="3" DataSourceID="SdsPagosResolucion" PageSize="5" Width="1084px" AllowSorting="True">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="CodigoRegional" HeaderText="Regional" SortExpression="CodigoRegional" />
                        <asp:BoundField DataField="Resolucion" HeaderText="Resolucion" SortExpression="Resolucion" />
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" SortExpression="Fecha" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Concepto" HeaderText="Concepto" SortExpression="Concepto" />
                        <asp:BoundField DataField="Periodo" HeaderText="Periodo" SortExpression="Periodo" />
                        <asp:BoundField DataField="Recibo" HeaderText="Recibo" SortExpression="Recibo" />
                        <asp:BoundField DataField="FechaRecibo" HeaderText="Fecha Recibo" SortExpression="FechaRecibo" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#FFCC00" Font-Bold="True" ForeColor="Black" />
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
            <td>
                <asp:GridView ID="GrvLiquidaciones" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" Caption="Liquidaciones" class="grvGrilla" CellPadding="3" DataSourceID="SdsLiquidaciones" AllowPaging="True" PageSize="5" Width="1082px" AllowSorting="True">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="CodigoRegional" HeaderText="Regional" SortExpression="CodigoRegional" />
                        <asp:BoundField DataField="Liquidacion" HeaderText="Liquidacion" SortExpression="Liquidacion" />
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" SortExpression="Fecha" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Concepto" HeaderText="Concepto" SortExpression="Concepto" />
                        <asp:BoundField DataField="Estado" HeaderText="Estado" SortExpression="Estado" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Saldo" HeaderText="Saldo" SortExpression="Saldo" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Ejecutoria" HeaderText="Ejecutoria" SortExpression="Ejecutoria" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" SortExpression="Observaciones" />
                        <asp:BoundField DataField="Fiscalizador" HeaderText="Fiscalizador" SortExpression="Fiscalizador" />
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
            <td>
                <asp:GridView ID="GrvPagosLiquidaciones" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" Caption="Pagos a Liquidaciones" CaptionAlign="Left" class="grvGrilla" CellPadding="3" DataSourceID="SdsPagosLiquidaciones" PageSize="5" Width="1078px" AllowSorting="True">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="CodigoRegional" HeaderText="Regional" SortExpression="CodigoRegional" />
                        <asp:BoundField DataField="Liquidacion" HeaderText="Liquidacion" SortExpression="Liquidacion" />
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" SortExpression="Fecha" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Concepto" HeaderText="Concepto" SortExpression="Concepto" />
                        <asp:BoundField DataField="Periodo" HeaderText="Periodo" SortExpression="Periodo" />
                        <asp:BoundField DataField="Recibo" HeaderText="Recibo" SortExpression="Recibo" />
                        <asp:BoundField DataField="FechaRecibo" HeaderText="Fecha Recibo" SortExpression="FechaRecibo" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Valor" HeaderText="Valor" SortExpression="Valor" DataFormatString="{0:N0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#FFCC00" Font-Bold="True" ForeColor="Black" />
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
            <td>&nbsp;</td>
        </tr>
    </table>
    <table class="auto-style6">
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsPagosResolucion" runat="server" ConnectionString="<%$ ConnectionStrings:AportesDConnectionString %>" SelectCommand="SELECT REGIONAL CODIGOREGIONAL
                        ,IDRESLIQ RESOLUCION, FECHA_LIQRES FECHA, FUENTE CONCEPTO, PERIODO PERIODO, RECIBO RECIBO, FECHA_RECIBO FECHARECIBO,VALOR VALOR
	                    FROM APORTES.APOV_PAGRESS
	                    WHERE LRN_TYPE='R' AND ARE_IDAPORTANTE= :ARE_IDAPORTANTE ORDER BY REGIONAL, IDRESLIQ, FUENTE, FECHA_RECIBO desc"                 
                    SelectCommandType="Text" 
                    ProviderName="<%$ ConnectionStrings:AportesDConnectionString.ProviderName %>">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtIdentificacion" Name="ARE_IDAPORTANTE" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>
                <asp:SqlDataSource ID="SdsAportante" runat="server" ConnectionString="<%$ ConnectionStrings:AportesDConnectionString %>" SelectCommand="SELECT APOV_APORTAS.REGIONAL||'-'||APOT_REGIONS.NOMBRE REGIONAL
			    ,IDAPORTANTE IDENTIFICACION, MNO_DPO_IDDEPARTAMENTO||MNO_IDMUNICIPIO CODIGOMUNICIPIO, APOV_APORTAS.NOMBRE NOMBREAPORTANTE, NROEMPLEADOS NROEMPLEADOS, TELEFONO1 TELEFONO		  ,APOV_APORTAS.DIRECCION DIRECCION
			    ,E_MAIL CORREO, NOMREPLEGAL REPRESENTANTE, CEDREPLEGAL CEDULAREPRESENTANTE
                FROM APORTES.APOV_APORTAS, APORTES.APOT_REGIONS
		        WHERE APOV_APORTAS.REGIONAL = APOT_REGIONS.IDREGIONAL AND IDAPORTANTE= :IDAPORTANTE
		        ORDER BY APOV_APORTAS.REGIONAL"
                SelectCommandType="Text" 
                ProviderName="<%$ ConnectionStrings:AportesDConnectionString.ProviderName %>">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtIdentificacion" Name="IDAPORTANTE" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsResoluciones" runat="server" ConnectionString="<%$ ConnectionStrings:AportesDConnectionString %>" SelectCommand="SELECT APORTES.APOV_LIQRESS.REGIONAL AS CODIGOREGIONAL
	                    , APORTES.APOV_LIQRESS.IDRESLIQ AS RESOLUCION, APORTES.APOV_LIQRESS.FECHA, APORTES.APOV_LIQRESS.FUENTE AS CONCEPTO, APORTES.APOV_LIQRESS.ESTADO AS ESTADO
	                    , APORTES.APOV_LIQRESS.VALOR AS VALOR, APORTES.APOV_LIQRESS.SALDOAPORTE AS SALDO, APORTES.APOV_LIQRESS.OBSERVACIONES AS OBSERVACIONES
	                    , APORTES.APOV_LIQRESS.FECHAEJEC AS EJECUTORIA, APORTES.APOV_PROMOTS.NOMBRES||' '||APORTES.APOV_PROMOTS.APELLIDOS AS FISCALIZADOR
                        FROM  APORTES.APOV_LIQRESS LEFT OUTER JOIN
                        APORTES.APOV_PROMOTS ON APORTES.APOV_LIQRESS.IDPROMOTOR = APORTES.APOV_PROMOTS.IDPROMOTOR AND 
                        APORTES.APOV_LIQRESS.REGIONAL = APORTES.APOV_PROMOTS.REGIONAL
                        WHERE (APORTES.APOV_LIQRESS.LRN_TYPE = 'R') AND (ARE_IDAPORTANTE = :IDAPORTANTE)
                        ORDER BY CODIGOREGIONAL, RESOLUCION, CONCEPTO" 
                SelectCommandType="Text" 
                ProviderName="<%$ ConnectionStrings:AportesDConnectionString.ProviderName %>">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtIdentificacion" Name="IDAPORTANTE" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:HiddenField ID="hfRegistros" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsLiquidaciones" runat="server" ConnectionString="<%$ ConnectionStrings:AportesDConnectionString %>" SelectCommand="SELECT APORTES.APOV_LIQRESS.REGIONAL AS CODIGOREGIONAL
	                , APORTES.APOV_LIQRESS.IDRESLIQ AS LIQUIDACION, APORTES.APOV_LIQRESS.FECHA, APORTES.APOV_LIQRESS.FUENTE AS CONCEPTO, APORTES.APOV_LIQRESS.ESTADO AS ESTADO
	                , APORTES.APOV_LIQRESS.VALOR AS VALOR, APORTES.APOV_LIQRESS.SALDOAPORTE AS SALDO, APORTES.APOV_LIQRESS.OBSERVACIONES AS OBSERVACIONES
	                , APORTES.APOV_LIQRESS.FECHAEJEC AS EJECUTORIA, APORTES.APOV_PROMOTS.NOMBRES||' '||APORTES.APOV_PROMOTS.APELLIDOS AS FISCALIZADOR
                    FROM  APORTES.APOV_LIQRESS LEFT OUTER JOIN
                    APORTES.APOV_PROMOTS ON APORTES.APOV_LIQRESS.IDPROMOTOR = APORTES.APOV_PROMOTS.IDPROMOTOR AND 
                    APORTES.APOV_LIQRESS.REGIONAL = APORTES.APOV_PROMOTS.REGIONAL
                    WHERE (APORTES.APOV_LIQRESS.LRN_TYPE = 'L') AND (ARE_IDAPORTANTE= :ARE_IDAPORTANTE)
                    ORDER BY CODIGOREGIONAL, LIQUIDACION, CONCEPTO"
                     SelectCommandType="Text"
                     ProviderName="<%$ ConnectionStrings:AportesDConnectionString.ProviderName %>">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtIdentificacion" Name="ARE_IDAPORTANTE" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>&nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                
                 <asp:SqlDataSource ID="SdsPagosLiquidaciones" runat="server" ConnectionString="<%$ ConnectionStrings:AportesDConnectionString %>" SelectCommand="SELECT REGIONAL CODIGOREGIONAL
                        ,IDRESLIQ LIQUIDACION, FECHA_LIQRES FECHA, FUENTE CONCEPTO, PERIODO PERIODO, RECIBO RECIBO, FECHA_RECIBO FECHARECIBO, VALOR VALOR
	                    FROM APORTES.APOV_PAGRESS WHERE LRN_TYPE='L' AND ARE_IDAPORTANTE= :ARE_IDAPORTANTE ORDER BY REGIONAL,IDRESLIQ,FUENTE, FECHA_RECIBO desc" 
                    SelectCommandType="Text" 
                    ProviderName="<%$ ConnectionStrings:AportesDConnectionString.ProviderName %>">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtIdentificacion" Name="ARE_IDAPORTANTE" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
