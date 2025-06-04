<%@ Page Title="Página Principal" Language="C#" MasterPageFile="~/SiteCpp.Master" AutoEventWireup="true" CodeBehind="DefaultCp.aspx.cs" Inherits="WebLiquidador.DefaultCp" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .auto-style8 {
            width: 100%;
        }

        .auto-style9 {
            width: 175px;
        }

        .auto-style10 {
            width: 254px;
        }

        .auto-style11 {
            text-align: center;
            width: 98%;
        }

        .auto-style29 {
            height: 37px;
        }

        .auto-style30 {
            text-align: center;
        }
        </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Página Principal</h2>
    <table class="auto-style8">
        <tr>
            <td class="auto-style9">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagenes/LogoSena1.png" Height="149px" Width="170px" />
            </td>
            <td class="auto-style10">
                <asp:Image ID="Image2" runat="server" ImageUrl="~/Imagenes/logo-minTrabajo.png" />
            </td>
            <td class="auto-style30">
                <h2 class="auto-style11">
                    &nbsp;</h2>
                <h2 class="auto-style11">
                    &nbsp;</h2>
                <h2 class="auto-style11">
                    &nbsp;</h2>
            </td>
        </tr>
    </table>
    <h3><a href="https://www.sena.edu.co/es-co/ciudadano/Paginas/Pagos-en-linea.aspx" title="Pagos en Línea - e-collect - Botón de Pago" target="_blank">Pagos en Línea - e-collect - Botón de Pago</a>
    </h3>
    <p>
        Dirección Administrativa y Financiera
        <br />
        - Grupo de Recaudo y Cartera
        <br />
        <asp:HyperLink ID="HyperLink2" runat="server" Target="_blank" NavigateUrl="https://www.sena.edu.co/es-co/sena/Paginas/estructura-organizacional.aspx">Dirección de Promoción y Relaciones Corporativas</asp:HyperLink>
    </p>
    <asp:Label ID="lblPensamiento" runat="server" Font-Bold="False" ForeColor="#0033CC" Style="text-align: left"></asp:Label>
    <table class="auto-style8">
        <tr>
            <td class="auto-style29">
                &nbsp;</td>
            <td class="auto-style29">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td class="auto-style29">
                <asp:HiddenField ID="hfAñoVigencia" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>

