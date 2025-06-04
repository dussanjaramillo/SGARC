<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisorEstadoCuenta.aspx.cs" Inherits="WebLiquidador.Paginas.AtencionCiudadano.VisorEstadoCuenta" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="icon" type="image/ico" href="/Imagenes/favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
        </asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="1000px" Width="1507px">
        </rsweb:ReportViewer>
        <asp:SqlDataSource ID="SdsBuscarLiquidacionesEstadoCuenta" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarLiquidacionesEstadoCuenta" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="Identificacion" SessionField="_Identificacion" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SdsBuscarLiquidacionesPEstadoCuenta" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarLiquidacionesPEstadoCuenta" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="" Name="Identificacion" SessionField="_Identificacion" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SdsBuscarAportanteEstadoCuenta" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarAportanteEstadoCuenta" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="Identificacion" SessionField="_Identificacion" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SdsBuscarResolucionesEstadoCuenta" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarResolucionesEstadoCuenta" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="Identificacion" SessionField="_Identificacion" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SdsBuscarResolucionesPEstadoCuenta" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarResolucionesPEstadoCuenta" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="" Name="Identificacion" SessionField="_Identificacion" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <br />
                <asp:SqlDataSource ID="SdsDatosGenerales" runat="server" ConnectionString="<%$ ConnectionStrings:PlanillaConnectionString %>" ProviderName="<%$ ConnectionStrings:PlanillaConnectionString.ProviderName %>" SelectCommand="Usp_BuscarDatosGenerales" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="Identificacion" SessionField="_Identificacion" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SdsDatosGenerales1" runat="server" ConnectionString="<%$ ConnectionStrings:PlanillaConnectionString %>" ProviderName="<%$ ConnectionStrings:PlanillaConnectionString.ProviderName %>" SelectCommand="Usp_BuscarDatosGenerales1" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="Identificacion" SessionField="_Identificacion" Type="String" />                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SdsDatosGenerales2" runat="server" ConnectionString="<%$ ConnectionStrings:PlanillaConnectionString %>" ProviderName="<%$ ConnectionStrings:PlanillaConnectionString.ProviderName %>" SelectCommand="Usp_BuscarDatosGenerales2" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="Identificacion" SessionField="_Identificacion" Type="String" />                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SdsDatosGenerales3" runat="server" ConnectionString="<%$ ConnectionStrings:PlanillaConnectionString %>" ProviderName="<%$ ConnectionStrings:PlanillaConnectionString.ProviderName %>" SelectCommand="Usp_BuscarDatosGenerales3" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="Identificacion" SessionField="_Identificacion" Type="String" />                    </SelectParameters>
                </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
