<%@ Page Title="Actualizar Meses Exentos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AP_Meses_Exentos.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.AP_Meses_Exentos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            width: 40%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td><h2>Actualizar Meses Exentos</h2></td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnActualizar" runat="server" OnClick="btnActualizar_Click" Text="Actualizar" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnActualizar_ConfirmButtonExtender" runat="server" ConfirmText="Está Seguro?" TargetControlID="btnActualizar" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grvMesesExentos" runat="server" AutoGenerateColumns="False" DataSourceID="SqlMesesExentos_Oracle" Visible="False">
                    <Columns>
                        <asp:BoundField DataField="NIT" HeaderText="NIT" SortExpression="NIT" />
                        <asp:BoundField DataField="VIGENCIA" HeaderText="VIGENCIA" SortExpression="VIGENCIA" />
                        <asp:BoundField DataField="MESES" HeaderText="MESES" SortExpression="MESES" />
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SqlMesesExentos_Oracle" runat="server" ConnectionString="<%$ ConnectionStrings:AportesDConnectionString %>" ProviderName="<%$ ConnectionStrings:AportesDConnectionString.ProviderName %>" SelectCommand="SELECT &quot;NIT&quot;, &quot;VIGENCIA&quot;, &quot;MESES&quot; FROM &quot;AP_MESES_EXENTOS&quot;"></asp:SqlDataSource>
            </td>
        </tr>
        </table>
</asp:Content>
