<%@ Page Title="Acuerdo 1035 de 2015" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cargar_Acuerdo_1035_2015.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.Cargar_Acuerdo_1035_2015" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="3"><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-bidi-font-family:
&quot;Times New Roman&quot;;mso-ansi-language:ES;mso-fareast-language:ES;mso-bidi-language:
AR-SA"><h2>Acuerdo 1035 de 2015</h2></span></td>
        </tr>
        <tr>
            <td colspan="2">Seleccione el Archivo</td>
            <td>Fecha Cartera Sirec</td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:FileUpload ID="FuCargarArchivo" runat="server" accept="text/plain, application/json" Width="481px"  />
            </td>
            <td>
                <asp:DropDownList ID="ddlPeriodo_CarteraRealUgpp" runat="server" DataSourceID="SdsPeriodo_CarteraRealUgpp" DataTextField="Periodo" DataValueField="Periodo" Width="170px" AutoPostBack="True" BackColor="#FFFF99" Font-Bold="True">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnCargarArchivo" runat="server" OnClick="btnCargarArchivo_Click" Text="Cargar Archivo" Width="482px" />
                <Ajax:ConfirmButtonExtender ID="btnCargarArchivo_ConfirmButtonExtender" runat="server" BehaviorID="btnCargarArchivo_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnCargarArchivo" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">Archivo: <asp:Label ID="lblNombreArchivo" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">Registros: <asp:Label ID="lblRegistros" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnEsCorrecto" runat="server" Font-Bold="True" OnClick="btnEsCorrecto_Click" Text="Es Correcto?" Visible="False" Width="482px" />
                <Ajax:ConfirmButtonExtender ID="btnEsCorrecto_ConfirmButtonExtender" runat="server" BehaviorID="btnEsCorrecto_ConfirmButtonExtender" ConfirmText="Procesar el Archivo?" TargetControlID="btnEsCorrecto" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsPeriodo_CarteraRealUgpp" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[Ugpp].[Usp_Buscar_Periodo_CarteraRealUgpp]" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:LiquidadorConnectionString.ProviderName %>"></asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hdfNumeroRegistros" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
