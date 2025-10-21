<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="DefaultCf.aspx.cs" Inherits="WebLiquidador.DefaultCf" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .auto-style8 {
            width: 100%;
        }

        .auto-style9 {
            width: 175px;
        }

        .auto-style10 {
            width: 254px;
        }

        .auto-style11 {
            text-align: center;
            width: 98%;
        }

        .auto-style12 {
            color: #800000;
        }

        .auto-style28 {
            font-family: Arial, Helvetica, sans-serif;
        }

        .auto-style29 {
            height: 37px;
        }

        .auto-style30 {
            text-align: center;
        }
        </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Página Principal</h2>
    <table class="auto-style8">
        <tr>
            <td class="auto-style9">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagenes/LogoSena1.png" Height="149px" Width="170px" />
            </td>
            <td class="auto-style10">
                <asp:Image ID="Image2" runat="server" ImageUrl="~/Imagenes/logo-minTrabajo.png" />
            </td>
            <td class="auto-style30">
                <h2 class="auto-style11">
                    <asp:Label ID="lblMensajeUsuarios" runat="server" CssClass="auto-style12"></asp:Label>
                </h2>
                <h2 class="auto-style11">
                    <asp:Button ID="btnPagosNoIdentificados" runat="server" Font-Bold="True" ForeColor="#000099" OnClick="btnPagosNoIdentificados_Click" BackColor="#FFFFCC" Width="330px" />
                    <ajax:balloonpopupextender ID="btnPagosNoIdentificados_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel1" BalloonSize="Medium" DisplayOnFocus="True" DisplayOnMouseOver="True" Position="BottomLeft" TargetControlID="btnPagosNoIdentificados">
                    </ajax:balloonpopupextender>
                </h2>
                <h2 class="auto-style11">
                    <asp:HyperLink ID="HyperLink3" runat="server"  BackColor="#FFFF99" NavigateUrl="~/Paginas/ProduccionCentros/Sirec/PagosHoySirec.aspx" ToolTip="Haga Click para Consultar los Pagos en Línea Recibidos Hoy">Pagos de Hoy</asp:HyperLink>
                </h2>
                
                <h2>
                    <asp:HyperLink ID="HyperLink4" runat="server" BackColor="#FFCCCC" NavigateUrl="~/Paginas/ProduccionCentros/Wompi/ConsultaEstadoPagos.aspx" ToolTip="Haga Click para Consultar los Pagos por Wompi">Pagos por Wompi</asp:HyperLink>
                </h2>
                </p>

<%--                <h2 class="auto-style11">
                    <asp:HyperLink ID="HyperLink1" Target="_blank" runat="server" NavigateUrl="~/Imagenes/Circular - 3-2021-000060 - Facturación Electrónica DIAN para Producción de Centros.pdf" ToolTip="Circular - 3-2021-000060 - Facturación Electrónica DIAN">Circular - 3-2021-000060 - Facturación Electrónica DIAN</asp:HyperLink>
                </h2>--%>
            </td>
        </tr>
    </table>
    <h3><a href="https://www.sena.edu.co/es-co/ciudadano/Paginas/Pagos-en-linea.aspx" title="Pagos en Línea - e-collect - Botón de Pago" target="_blank">Pagos en Línea - e-collect - Botón de Pago</a>
    </h3>
    <p>
        Dirección Administrativa y Financiera
        <br />
        - Grupo de Recaudo y Cartera
        <br />
        <asp:HyperLink ID="HyperLink2" runat="server" Target="_blank" NavigateUrl="https://www.sena.edu.co/es-co/comunidades/instructores/Paginas/escuelaInstructores.aspx">Centros de Formación Profesional Integral</asp:HyperLink>
    </p>
    <asp:Label ID="lblPensamiento" runat="server" Font-Bold="False" ForeColor="#0033CC" Style="text-align: left"></asp:Label>
    <asp:GridView ID="grvCuponPagoSinIdentificarCentro" runat="server" AutoGenerateColumns="False" DataSourceID="SdsCuponPagoSinIdentificarCentro" class="grvGrilla" Caption="Cupón de Pago Sin Identificar" PageSize="15" Visible="False">
        <AlternatingRowStyle BackColor="#DCDCDC" />
        <Columns>
            <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
            <asp:BoundField DataField="PrimerNombre" HeaderText="PrimerNombre" SortExpression="PrimerNombre" />
            <asp:BoundField DataField="PrimerApellido" HeaderText="PrimerApellido" SortExpression="PrimerApellido" />
            <asp:BoundField DataField="NumeroFactura" HeaderText="Prefactura" SortExpression="NumeroFactura" />
            <asp:BoundField DataField="ValorTotaldelPago" HeaderText="ValorTotaldelPago" SortExpression="ValorTotaldelPago" />
            <asp:BoundField DataField="FechaEntidadFinanciera" DataFormatString="{0:d}" HeaderText="FechaEntidadFinanciera" SortExpression="FechaEntidadFinanciera" />
            <asp:BoundField DataField="NroInternodeTransaccion" HeaderText="CupónPago" SortExpression="NroInternodeTransaccion" />
            <asp:BoundField DataField="EntidadFinancieraAutorizadora" HeaderText="EntidadFinanciera" SortExpression="EntidadFinancieraAutorizadora" />
            <asp:BoundField DataField="NombreTipoIngreso" HeaderText="NombreTipoIngreso" SortExpression="NombreTipoIngreso" />
        </Columns>
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <HeaderStyle BackColor="#4b6c9e" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#0000A9" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#000065" />
    </asp:GridView>
    <asp:Panel ID="Panel1" runat="server" Font-Bold="True">
        <span class="auto-style28">Haga Clic Aquí, Para Conocer los Cupónes de Pago Aún No Identificados</span>
    </asp:Panel>
    <table class="auto-style8">
        <tr>
            <td class="auto-style29">
                <asp:SqlDataSource ID="SdsCuponPagoSinIdentificarCentro" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_CuponPagoSinIdentificarCentroBuscar]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td class="auto-style29">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td class="auto-style29">
                <asp:HiddenField ID="hfAñoVigencia" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>

