<%@ Page Title="Imprimir Link Wompi Pagos Rápidos" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ImprimirQr.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Wompi.ImprimirQr" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style1">
        <tr>
            <td><h2>Imprimir Link Wompi Pagos Rápidos: <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label> </h2>
                </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnImprimirQr" runat="server" Enabled="False" OnClick="btnImprimirQr_Click" Text="Imprimir Qr" Width="170px" />
            </td>
        </tr>
        </table>
</asp:Content>
