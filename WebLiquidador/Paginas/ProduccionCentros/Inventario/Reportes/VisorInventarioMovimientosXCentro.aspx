<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisorInventarioMovimientosXCentro.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Inventario.Reportes.VisorInventarioMovimientosXCentro" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
        </asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="1000px" Height="1000px">
        </rsweb:ReportViewer>
    
    </div>
                <asp:SqlDataSource ID="SdsInventarioMovimientos" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarInventarioMovimientos]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                        <asp:SessionParameter Name="FechaInicial" SessionField="_FechaInicial" Type="DateTime"  />
                        <asp:SessionParameter Name="FechaFinal" SessionField="_FechaFinal" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
    
    </form>
</body>
</html>
