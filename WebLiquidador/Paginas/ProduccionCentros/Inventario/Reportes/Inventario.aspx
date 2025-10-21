<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="VisorInventarioMovimientosXCentro.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Inventario.Reportes.VisorInventarioMovimientosXCentro" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
    </asp:ScriptManager>

    <asp:SqlDataSource ID="SdsInventarioMovimientos" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarInventarioMovimientos]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
            <asp:ControlParameter ControlID="txtFechaInicial" Name="FechaInicial" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtFechaFinal" Name="FechaFinal" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="830px" Height="586px">
    </rsweb:ReportViewer>

</asp:Content>
