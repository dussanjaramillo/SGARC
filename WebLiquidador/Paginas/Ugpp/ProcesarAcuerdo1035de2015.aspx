<%@ Page Title="Procesar Acuerdo 1035 de 2015" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProcesarAcuerdo1035de2015.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.ProcesarAcuerdo1035de2015" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="4"><h2>Procesar Acuerdo 1035 de 2015 - Fecha Cartera Sirec:
                <asp:DropDownList ID="ddlPeriodo_CarteraRealUgpp" runat="server" DataSourceID="SdsPeriodo_CarteraRealUgpp" DataTextField="Periodo" DataValueField="Periodo" Width="170px" AutoPostBack="True" BackColor="#FFFF99" Font-Bold="True">
                </asp:DropDownList>
                </h2></td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:GridView ID="grvControlCargueAcuerdo1035de2015" runat="server" DataSourceID="SdsControlCargueAcuerdo1035de2015" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IdControlCargueAcuerdo1035de2015" OnSelectedIndexChanged="grvControlCargueAcuerdo1035de2015_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdControlCargueAcuerdo1035de2015" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdControlCargueAcuerdo1035de2015" />
                        <asp:BoundField DataField="NombreArchivo" HeaderText="NombreArchivo" SortExpression="NombreArchivo" />
                        <asp:BoundField DataField="NumeroRegistros" HeaderText="Registros" SortExpression="NumeroRegistros" />
                        <asp:BoundField DataField="Nombre" HeaderText="NombreUsuario" SortExpression="Nombre" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#FF9536" Font-Bold="True" ForeColor="Black" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
                <Ajax:BalloonPopupExtender ID="grvControlCargueAcuerdo1035de2015_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel1" BehaviorID="grvControlCargueAcuerdo1035de2015_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="grvControlCargueAcuerdo1035de2015">
                </Ajax:BalloonPopupExtender>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnProcesar" runat="server" Enabled="False" OnClick="btnProcesar_Click" Text="Procesar" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnProcesar_ConfirmButtonExtender" runat="server" BehaviorID="btnProcesar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnProcesar" />
                <asp:Button ID="btnExportar" runat="server" Enabled="False" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Panel ID="Panel1" runat="server">
                    <strong>Seleccione el Archivo a ser Procesado</strong></asp:Panel>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
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
                <asp:SqlDataSource ID="SdsControlCargueAcuerdo1035de2015" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[Ugpp].[Usp_BuscarControlCargueAcuerdo1035de2015]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfFechaArchivo" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
