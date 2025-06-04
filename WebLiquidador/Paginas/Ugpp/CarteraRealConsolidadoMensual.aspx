<%@ Page Title="Ugpp - Cartera Real Consolidado Mensual" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CarteraRealConsolidadoMensual.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.CarteraRealConsolidadoMensual" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">
        .auto-style6 {
            width: 699px;
        }

        .auto-style8 {
            width: 245px;
        }

        .auto-style9 {
            width: 166px;
        }

        .auto-style10 {
        }

        .auto-style11 {
            width: 219px;
        }

        .auto-style12 {
            height: 23px;
        }

        .auto-style13 {
            width: 165px;
            height: 21px;
        }

        .auto-style14 {
            width: 166px;
            height: 21px;
        }

        .auto-style15 {
            height: 21px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="3">
                <h2>Consolidado Mensual - Cartera Real</h2>
            </td>
        </tr>
        <tr>
            <td rowspan="7" class="auto-style11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Image ID="Image1" runat="server" Height="91px" ImageUrl="~/Imagenes/Logo_Ugpp.png" />
            </td>
            <td class="auto-style10">Periodo<br />
            </td>
            <td class="auto-style9">Mes de Entrega<br />
            </td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:TextBox ID="txtPeriodo" runat="server" BackColor="#FFFF99" Enabled="False" Font-Bold="True" Width="170px"></asp:TextBox>
            </td>
            <td class="auto-style9">
                <asp:DropDownList ID="ddlMesEntrega" runat="server" Width="170px" OnDataBound="ddlMesEntrega_DataBound">
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
            <td class="auto-style13"></td>
            <td class="auto-style14">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlMesEntrega" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" SetFocusOnError="True" ValidationGroup="btnConsolidadoMensual"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style8" colspan="2" style="background-color: #E48F43">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:Button ID="btnConsolidadoMensual" runat="server" OnClick="btnConsolidadoMensual_Click" Text="Consolidado" Width="170px" ValidationGroup="btnConsolidadoMensual" />
                <Ajax:ConfirmButtonExtender ID="btnConsolidadoMensual_ConfirmButtonExtender" runat="server" BehaviorID="btnConsolidadoMensual_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnConsolidadoMensual" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnFichaControl" runat="server" OnClick="btnFichaControl_Click" Text="Ficha de Control" ValidationGroup="btnConsolidadoMensual" Width="170px" />
                <Ajax:ConfirmButtonExtender ID="btnFichaControl_ConfirmButtonExtender" runat="server" BehaviorID="btnFichaControl_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnFichaControl" />
            </td>
        </tr>
        <tr>
            <td class="auto-style10" colspan="2">
                Debe entregarse a mas tardar el ultimo día hábil de cada mes del año (12 reportes), asignando en la estructura del nombre del archivo el mes de entrega.</td>
        </tr>
        <tr>
            <td class="auto-style12" colspan="2">
                <h3>
                    <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" NavigateUrl="~/Paginas/Normas/Presentacion Resolucion 2082_16_Estandares I_II_III_IV_marzo_2017.pdf">Presentacion Resolucion 2082</asp:HyperLink>
                </h3>
            </td>
        </tr>
        <tr>
            <td class="auto-style11">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td class="auto-style10">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
        </tr>
    </table>
</asp:Content>
