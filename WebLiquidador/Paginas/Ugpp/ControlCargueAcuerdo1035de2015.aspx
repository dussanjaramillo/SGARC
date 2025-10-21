<%@ Page Title="Control Cargue Acuerdo 1035 de 2015" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ControlCargueAcuerdo1035de2015.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.ControlCargueAcuerdo1035de2015" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="8">
                <h2>Control Cargue Acuerdo 1035 de 2015</h2>
            </td>
        </tr>
        <tr>
            <td colspan="8">
                <asp:GridView ID="grvControlCargueAcuerdo1035de2015" runat="server" DataSourceID="SdsControlCargueAcuerdo1035de2015" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IdControlCargueAcuerdo1035de2015">
                    <Columns>
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
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsControlCargueAcuerdo1035de2015" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[Ugpp].[Usp_BuscarControlCargueAcuerdo1035de2015]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
