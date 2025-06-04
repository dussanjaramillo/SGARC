<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CarteraSirec.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.CarteraSirec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            width: 33%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="2"><h2>Actualizar Cartera desde Sirec (Pila)</h2></td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnActualizar" runat="server" OnClick="btnActualizar_Click" Text="Actualizar" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnActualizar_ConfirmButtonExtender" runat="server" ConfirmText="Está Seguro?" TargetControlID="btnActualizar" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="HiddenField1" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
