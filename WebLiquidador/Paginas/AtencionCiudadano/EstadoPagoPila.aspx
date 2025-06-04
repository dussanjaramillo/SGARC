<%@ Page Title="Aportante Reportado a la Ugpp" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EstadoPagoPila.aspx.cs" Inherits="WebLiquidador.Paginas.AtencionCiudadano.EstadoPagoPila" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style9">
        <tr>
            <td><h2>Estado de pago Pila</h2></td>
        </tr>
        </table>
    <table class="auto-style9">
        <tr>
            <td>Identificación<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtIdentificacion" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
            </td>
            <td colspan="2">&nbsp;</td>
            <td>&nbsp;</td>
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
            <td>
                &nbsp;</td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="Id" DataSourceID="SdsAportante" ForeColor="Black" GridLines="Vertical">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" ReadOnly="True" SortExpression="Identificacion" />
                        <asp:BoundField DataField="TipoIdentificacion" HeaderText="Tipo" SortExpression="TipoIdentificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" ReadOnly="True" SortExpression="Nombre" />
                        <asp:BoundField DataField="Direccion" HeaderText="Direccion" ReadOnly="True" SortExpression="Direccion" />
                        <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" SortExpression="Email" />
                        <asp:BoundField DataField="Cedula" HeaderText="Cedula" ReadOnly="True" SortExpression="Cedula" />
                        <asp:BoundField DataField="RepresentanteLegal" HeaderText="RepresentanteLegal" ReadOnly="True" SortExpression="RepresentanteLegal" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="Gray" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>
                <asp:SqlDataSource ID="SdsAportante" runat="server" ConnectionString="<%$ ConnectionStrings:PlanillaConnectionString %>" SelectCommand="Usp_BuscarAportanteXIdentificacion" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtIdentificacion" Name="Identificacion" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grvLosPagos" runat="server" DataSourceID="SdsPagos" AutoGenerateColumns="False" class="grvGrilla" BackColor="LightGoldenrodYellow" BorderColor="Black" BorderWidth="1px" CellPadding="2" ForeColor="Black" OnRowDataBound="grvLosPagos_RowDataBound" OnDataBound="grvLosPagos_DataBound">
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    <Columns>
                        <asp:BoundField DataField="Vigencia" HeaderText="Vige" SortExpression="Vigencia" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Ene" HeaderText="Ene" SortExpression="Ene" />
                        <asp:BoundField DataField="FechaEne" HeaderText="Fecha" SortExpression="FechaEne" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Feb" HeaderText="Feb" SortExpression="Feb" />
                        <asp:BoundField DataField="FechaFeb" HeaderText="Fecha" SortExpression="FechaFeb" />
                        <asp:BoundField DataField="Mar" HeaderText="Mar" SortExpression="Mar" />
                        <asp:BoundField DataField="FechaMar" HeaderText="Fecha" SortExpression="FechaMar" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Abr" HeaderText="Abr" SortExpression="Abr" />
                        <asp:BoundField DataField="FechaAbr" HeaderText="Fecha" SortExpression="FechaAbr" >
                        </asp:BoundField>
                        <asp:BoundField DataField="May" HeaderText="May" SortExpression="May" />
                        <asp:BoundField DataField="FechaMay" HeaderText="Fecha" SortExpression="FechaMay" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Jun" HeaderText="Jun" SortExpression="Jun" />
                        <asp:BoundField DataField="FechaJun" HeaderText="Fecha" SortExpression="FechaJun" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Jul" HeaderText="Jul" SortExpression="Jul" />
                        <asp:BoundField DataField="FechaJul" HeaderText="Fecha" SortExpression="FechaJul" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Ago" HeaderText="Ago" SortExpression="Ago" />
                        <asp:BoundField DataField="FechaAgo" HeaderText="Fecha" SortExpression="FechaAgo" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Sep" HeaderText="Sep" SortExpression="Sep" />
                        <asp:BoundField DataField="FechaSep" HeaderText="Fecha" SortExpression="FechaSep" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Oct" HeaderText="Oct" SortExpression="Oct" />
                        <asp:BoundField DataField="FechaOct" HeaderText="Fecha" SortExpression="FechaOct" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Nov" HeaderText="Nov" SortExpression="Nov" />
                        <asp:BoundField DataField="FechaNov" HeaderText="Fecha" SortExpression="FechaNov" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Dic" HeaderText="Dic" SortExpression="Dic" />
                        <asp:BoundField DataField="FechaDic" HeaderText="Fecha" SortExpression="FechaDic" />
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
