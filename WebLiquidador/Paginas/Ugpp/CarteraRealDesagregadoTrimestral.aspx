<%@ Page Title="Ugpp - Desagregado Trimestral - Cartera Real" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CarteraRealDesagregadoTrimestral.aspx.cs" Inherits="WebLiquidador.Paginas.Ugpp.CarteraRealDesagregadoTrimestral" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">
        .auto-style6 {
            width: 567px;
        }

        .auto-style7 {
            width: 9px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td>
                <h2>Desagregado Trimestral - Cartera Real</h2>
            </td>
        </tr>
    </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style7" rowspan="6">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Imagenes/Logo_Ugpp.png" Height="96px" Style="text-align: center" />
            </td>
            <td class="auto-style7">Periodo</td>
            <td class="auto-style28">Mes de Entrega</td>

            <td class="auto-style28"></td>
            <td class="auto-style28"></td>
        </tr>
        <tr>
            <td class="auto-style7">
                <asp:TextBox ID="txtPeriodo" runat="server" BackColor="#FFFF99" Enabled="False" Font-Bold="True" Width="170px"></asp:TextBox>
            </td>
            <td class="auto-style9">
                <asp:DropDownList ID="ddlMesEntrega" runat="server" Width="170px" OnDataBound="ddlMesEntrega_DataBound">
                    <asp:ListItem>01 - Enero</asp:ListItem>
                    <asp:ListItem>04 - Abril</asp:ListItem>
                    <asp:ListItem>07 - Julio</asp:ListItem>
                    <asp:ListItem>10 - Octubre</asp:ListItem>
                </asp:DropDownList>
            </td>

            <td class="auto-style9"></td>
            <td class="auto-style9"></td>
        </tr>
        <tr>
            <td class="auto-style7">&nbsp;</td>
            <td class="auto-style9">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlMesEntrega" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" SetFocusOnError="True" ValidationGroup="btnDesagregadoTrimestral"></asp:RequiredFieldValidator>
            </td>

            <td class="auto-style9">&nbsp;</td>
            <td class="auto-style9">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style7">
                <asp:Button ID="btnDesagregadoTrimestral" runat="server" OnClick="btnDesagregadoTrimestral_Click" Text="Detalles" Width="170px" ValidationGroup="btnDesagregadoTrimestral" />
                <Ajax:ConfirmButtonExtender ID="btnDesagregadoTrimestral_ConfirmButtonExtender" runat="server" BehaviorID="btnDesagregadoTrimestral_ConfirmButtonExtender" ConfirmText="Usted está Seguro?" TargetControlID="btnDesagregadoTrimestral" />
            </td>
            <td class="auto-style8">
                <asp:Button ID="btnFichaControl" runat="server" OnClick="btnFichaControl_Click" Text="Ficha de Control" ValidationGroup="btnDesagregadoTrimestral" Width="170px" />
            </td>
            <td class="auto-style8"></td>
            <td class="auto-style8"></td>
        </tr>
        <tr>
            <td class="auto-style10" colspan="4">Debe entregarse a mas tardar el ultimo día hábil de los meses de Enero, Abril, Julio y Octubre de cada año (4 reportes), asignando en la estructura del nombre del archivo el mes de entrega y no el mes de corte</td>
        </tr>
        <tr>
            <td class="auto-style10" colspan="2">
                <h3>
                    <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" NavigateUrl="~/Paginas/Normas/Presentacion Resolucion 2082_16_Estandares I_II_III_IV_marzo_2017.pdf">Presentacion Resolucion 2082</asp:HyperLink>
                </h3>
            </td>
            <td class="auto-style10">&nbsp;</td>
            <td class="auto-style10">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style7">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td class="auto-style22" colspan="2">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
