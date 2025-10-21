<%@ Page Title="Página Principal" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebLiquidador._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .auto-style8 {
            height: 83px;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Página Principal</h2>
    <h2>
        <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagenes/LogoSena.png" Height="149px" Width="170px" />
        <asp:Image ID="Image2" runat="server" ImageUrl="~/Imagenes/logo-minTrabajo.png" />
    </h2>
    <h3><a href="https://www.mintrabajo.gov.co/" Target="_blank" title="Ministerio de Trabajo - MinTrabajo">Ministerio de Trabajo - MinTrabajo</a>
    </h3>
    <h3><a href="https://www.sena.edu.co/Paginas/Inicio.aspx" Target="_blank" title="Servicio Nacional de Aprendizaje - SENA">Servicio Nacional de Aprendizaje</a>
    </h3>
    <h3><a href="https://www.sena.edu.co/es-co/ciudadano/Paginas/Pagos-en-linea.aspx" title="Pagos en Línea - e-collect - Botón de Pago" target="_blank" >Pagos en Línea - e-collect - Botón de Pago</a>
    </h3>
    <p class="auto-style8">
        <strong>Dirección Administrativa y Financiera
        <br />
            - Grupo de Recaudo y Cartera
        <br />
            - Cobro Coactivo
        <br />
            Dirección de Relaciones Corporativas
        </strong>
    </p>
    <br />
    <asp:Label ID="lblPensamiento" runat="server" Font-Bold="False" ForeColor="#0033CC" Style="text-align: left"></asp:Label>
</asp:Content>
