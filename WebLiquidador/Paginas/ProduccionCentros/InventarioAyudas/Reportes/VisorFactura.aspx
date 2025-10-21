<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisorFactura.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.InventarioAyudas.Reportes.VisorFactura" %>

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
    
        <asp:Button ID="btnOtraFactura" runat="server" BackColor="#006600" Font-Bold="True" ForeColor="White" OnClick="btnOtraFactura_Click" Text="Nuevo Apoyo Emergencia Económica" Width="238px" />
    
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
        </asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="1000px" Height="1000px">
        </rsweb:ReportViewer>
    
    </div>
    
        <asp:HiddenField ID="hfOpcion" runat="server" />
    
            <asp:SqlDataSource ID="SdsBuscarFacturaXNumeroFactura" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarFacturaXNumeroFacturaAyudas]" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="Numerofactura" SessionField="_NumerofacturaAyudas" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
    
    </form>
</body>
</html>
