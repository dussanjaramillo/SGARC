<%@ Page Title="Informe Cumplimiento Meta - Generar" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="GeneraSeguimiento.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Seguimiento.GeneraSeguimiento" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            width: 35%;
        }
    p.MsoNormal
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:8.0pt;
	margin-left:0cm;
	line-height:107%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td><h2>Informe Cumplimiento Meta - Generar</h2></td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>Vigencia-Mes</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="ddlAñoMes" runat="server" DataSourceID="SdsAñoMes" DataTextField="AñoMes" DataValueField="AñoMes" Width="170px" AutoPostBack="True" OnSelectedIndexChanged="ddlAñoMesCuponPago_SelectedIndexChanged" OnDataBound="ddlAñoMesCuponPago_DataBound">
                </asp:DropDownList>
            </td>
            <td>
                <asp:Button ID="btnGenerar" runat="server" Text="Generar" ValidationGroup="btnGenerar" Width="170px" OnClick="btnGenerar_Click" Enabled="False" />
                <Ajax:BalloonPopupExtender ID="btnGenerar_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel1" BehaviorID="btnGenerar_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="btnGenerar">
                </Ajax:BalloonPopupExtender>
                <Ajax:ConfirmButtonExtender ID="btnGenerar_ConfirmButtonExtender" runat="server" BehaviorID="btnGenerar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnGenerar" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <p class="MsoNormal" style="height: 35px">
                    <span lang="es-419" style="font-size:9.5pt;line-height:107%;
font-family:&quot;Segoe UI&quot;,sans-serif;color:black">Es Sistema efectuara las siguientes preguntas a los Centros de Formación que no hayan cumplido con la meta en el Mes seleccionado. Y no lo dejara continuar, hasta que el usuario conteste las preguntas. </span><span lang="es-419"><o:p></o:p></span>
                </p>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SqlPreguntaSeguimiento" GridLines="Vertical" AutoGenerateColumns="False">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="Presunta1" HeaderText="Presunta 1" SortExpression="Presunta1" />
                        <asp:BoundField DataField="Presunta2" HeaderText="Presunta 2" SortExpression="Presunta2" />
                        <asp:BoundField DataField="Presunta3" HeaderText="Presunta 3" SortExpression="Presunta3" />
                        <asp:BoundField DataField="Presunta4" HeaderText="Presunta 4" SortExpression="Presunta4" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlPreguntaSeguimiento" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[CentroFormacion].[Usp_BuscarPresuntaSeguimientoInCumplimientoMeta]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Panel ID="Panel1" runat="server">
                    Recuerde esta Opción solo debe ejecutarse cuando haya cargado los todos los pagos del mes</asp:Panel>
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsAñoMes" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarAñoMesCuponPago]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfExiste" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
