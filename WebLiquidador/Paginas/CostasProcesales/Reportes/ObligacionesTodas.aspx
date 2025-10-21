<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ObligacionesTodas.aspx.cs" Inherits="WebLiquidador.Paginas.CostasProcesales.Reportes.ObligacionesTodas" %>

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
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="1000px" Height="1000px" HyperlinkTarget="_blank">
            <LocalReport EnableExternalImages="True" EnableHyperlinks="True">
            </LocalReport>
        </rsweb:ReportViewer>
    
    </div>
    
            <asp:SqlDataSource ID="SdsBuscarObligacionTodas" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CostasProcesales].[Usp_BuscarObligacionTodas]" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
    
    </form>
</body>
</html>
