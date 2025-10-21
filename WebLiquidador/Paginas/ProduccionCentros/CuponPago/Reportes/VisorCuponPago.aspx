<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisorCuponPago.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.VisorCuponPago" %>

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
    </form>
</body>
</html>
