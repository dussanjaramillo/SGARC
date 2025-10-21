<%@ Page Title="Ugpp - Liquidaciones Presuntas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LiquidacionesPresuntas.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.LiquidacionesPresuntas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="4"><h2>Liquidaciones Presuntas</h2></td>
        </tr>
        <tr>
            <td rowspan="5" class="auto-style7">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Image ID="Image1" runat="server" Height="87px" ImageUrl="~/Imagenes/Logo_Ugpp.png" />
            </td>
            <td class="auto-style8">Primera Fecha</td>
            <td class="auto-style8">Segunda Fecha</td>
            <td>Mes de Entrega</td>
        </tr>
        <tr>
            <td class="auto-style8">
            <asp:DropDownList ID="ddlPrimeraFecha" runat="server" DataSourceID="SdsFechaArchivo" DataTextField="NombreTabla" DataValueField="NombreTabla" OnDataBound="ddlPrimeraFecha_DataBound" Width="170px">
            </asp:DropDownList>
            </td>
            <td class="auto-style9">
            <asp:DropDownList ID="ddlSegundaFecha" runat="server" DataSourceID="SdsFechaArchivo" DataTextField="NombreTabla" DataValueField="NombreTabla" OnDataBound="ddlSegundaFecha_DataBound" Width="170px" AutoPostBack="True" OnSelectedIndexChanged="ddlSegundaFecha_SelectedIndexChanged">
            </asp:DropDownList>
            </td>
            <td>
                <asp:DropDownList ID="ddlMesEntrega" runat="server" Width="170px">
                    <asp:ListItem>01 - Enero</asp:ListItem>
                    <asp:ListItem>02 - Febrero</asp:ListItem>
                    <asp:ListItem>03 - Marzo</asp:ListItem>
                    <asp:ListItem>04 - Abril</asp:ListItem>
                    <asp:ListItem>05 - Mayo</asp:ListItem>
                    <asp:ListItem>06 - Junio</asp:ListItem>
                    <asp:ListItem>07 - Julio</asp:ListItem>
                    <asp:ListItem>08 - Agosto</asp:ListItem>
                    <asp:ListItem>09 - Septiembre</asp:ListItem>
                    <asp:ListItem>10 - Octubre</asp:ListItem>
                    <asp:ListItem>11 - Noviembre</asp:ListItem>
                    <asp:ListItem>12 - Diciembre</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #E48F43">
                &nbsp;</td>
            <td class="auto-style9" style="background-color: #E48F43">&nbsp;</td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlMesEntrega" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" SetFocusOnError="True" ValidationGroup="btnDesagregadoTrimestral"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:Button ID="btnLiquidacionesPresuntas" runat="server" OnClick="btnLiquidacionesPresuntas_Click" Text="Detalles" Width="170px" Visible="False" />
                <Ajax:ConfirmButtonExtender ID="btnLiquidacionesPresuntas_ConfirmButtonExtender" runat="server" BehaviorID="btnDesagregadoMensualDetalles_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnLiquidacionesPresuntas" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnFichaControl" runat="server" OnClick="btnFichaControl_Click" Text="Ficha de Control" ValidationGroup="btnDesagregadoTrimestral" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnFichaControl_ConfirmButtonExtender" runat="server" BehaviorID="btnFichaControl_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnFichaControl" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" colspan="3">
                Decreto 3033 de 2013 - Reglamenta los artículos 178 y 179 de la Reforma Tributaria,<br />
                Ley 1607 de 2012 y establece facultades para la UGPP
            </td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style7">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td class="auto-style8">
            <asp:SqlDataSource ID="SdsFechaArchivo" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_Buscar_APOV_LIQRESS" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:LiquidadorConnectionString.ProviderName %>"></asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
