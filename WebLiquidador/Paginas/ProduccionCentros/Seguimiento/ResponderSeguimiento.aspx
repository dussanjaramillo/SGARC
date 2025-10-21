<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ResponderSeguimiento.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Seguimiento.ResponderSeguimiento" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
        width: 98%;
    }
        .auto-style12 {
            width: 314px;
            height: 160px;
        }
        .auto-style16 {
            width: 1258px;
        }
        .auto-style18 {
        }
        .auto-style19 {
            text-align: justify;
        }
        .auto-style20 {
            color: #FFFFFF;
        }
    .auto-style21 {
        color: #FFFFFF;
        font-size: large;
    }
        .auto-style22 {
            color: #990000;
        }
        .auto-style23 {
            height: 21px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
    <tr>
        <td><h2>Respuesta al Seguimento:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2></td>
    </tr>
    <tr>
        <td style="background-color: #FFFF99" class="auto-style19"><strong>Estimado Usuario: Desde la Dirección Administrativa y Financiera se está realizando seguimiento de los recursos del Proyecto de Producción de Centros, con los objetivos de conocer las circunstancias que afectan los proyectos productivos y de ejecutar estrategias que permitan mejorar el cumplimiento de la meta de ingresos de cada Centro de Formación. Se solicita se diligencie en su TOTALIDAD la información de las casillas a continuación:</strong> </td>
    </tr>
    </table>
    <table class="auto-style16">
    <tr>
        <td class="auto-style20" colspan="6" style="background-color: #506272"><strong>Su Centro Actualmente Presenta Para:</strong></td>
    </tr>
    <tr>
        <td class="auto-style18">Año Mes:
        </td>
        <td class="auto-style18">Meta:
        </td>
        <td class="auto-style18">Ingresos:
        </td>
        <td class="auto-style18">%Cumplimiento Meta:
        </td>
        <td class="auto-style18">Proyeccion Mes:
        </td>
        <td class="auto-style18">Porcentaje Cumplimiento Mes:
        </td>
    </tr>
    <tr>
        <td class="auto-style18">
            <asp:Label ID="lblAñoMes" runat="server" Font-Bold="True" ForeColor="Maroon" CssClass="auto-style22"></asp:Label>
        </td>
        <td class="auto-style18">
            <asp:Label ID="lblMeta" runat="server" Font-Bold="True" ForeColor="Maroon"></asp:Label>
        </td>
        <td class="auto-style18">
            <asp:Label ID="lblIngresos" runat="server" Font-Bold="True" ForeColor="Maroon"></asp:Label>
        </td>
        <td class="auto-style18">
            <asp:Label ID="lblCumplimientoMeta" runat="server" Font-Bold="True" ForeColor="Maroon"></asp:Label>
        </td>
        <td class="auto-style18">
            <asp:Label ID="lblProyeccionMes" runat="server" Font-Bold="True" ForeColor="Maroon"></asp:Label>
        </td>
        <td class="auto-style18">
            <asp:Label ID="lblPorcentajeCumplimientoMes" runat="server" Font-Bold="True" ForeColor="Maroon"></asp:Label>
        </td>
    </tr>
    </table>
    <table class="auto-style16">
    <tr>
        <td class="auto-style21" colspan="4" style="background-color: #546E96"><strong>Por Favor Responda:</strong></td>
    </tr>
    <tr>
        <td class="auto-style23">
            <asp:Label ID="lblPregunta1" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            <strong>?</strong></td>
        <td class="auto-style23">
            <asp:Label ID="lblPregunta2" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            <strong>?</strong></td>
        <td class="auto-style23">
            <asp:Label ID="lblPregunta3" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            <strong>?</strong></td>
        <td class="auto-style23">
            <asp:Label ID="lblPregunta4" runat="server" Font-Bold="True" ForeColor="#0033CC"></asp:Label>
            <strong>?</strong></td>
    </tr>
    <tr>
        <td class="auto-style18"><strong>Respuesta:</strong><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtRespuesta1" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
        </td>
        <td class="auto-style18">
            <strong>Respuesta:<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtRespuesta2" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </strong></td>
        <td class="auto-style18">
            <strong>Respuesta:<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtRespuesta3" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </strong></td>
        <td class="auto-style18">
            <strong>Respuesta:<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtRespuesta4" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar"></asp:RequiredFieldValidator>
            </strong></td>
    </tr>
    <tr>
        <td class="auto-style12">
            <asp:TextBox ID="txtRespuesta1" runat="server" Height="250px" MaxLength="2000" TextMode="MultiLine" Width="227px" ValidationGroup="btnGuardar"></asp:TextBox>
        </td>
        <td class="auto-style12">
            <asp:TextBox ID="txtRespuesta2" runat="server" Height="250px" MaxLength="500" TextMode="MultiLine" Width="240px" ValidationGroup="btnGuardar"></asp:TextBox>
        </td>
        <td class="auto-style12">
            <asp:TextBox ID="txtRespuesta3" runat="server" Height="250px" MaxLength="500" TextMode="MultiLine" Width="251px" ValidationGroup="btnGuardar"></asp:TextBox>
        </td>
        <td class="auto-style12">
            <asp:TextBox ID="txtRespuesta4" runat="server" MaxLength="18" Width="170px" ValidationGroup="btnGuardar" ToolTip="Solo Números"></asp:TextBox>
            <Ajax:FilteredTextBoxExtender ID="txtRespuesta4_FilteredTextBoxExtender" runat="server" BehaviorID="txtRespuesta4_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtRespuesta4" />
        </td>
    </tr>
    <tr>
        <td class="auto-style18">
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" Width="170px" OnClick="btnGuardar_Click" ValidationGroup="btnGuardar" />
            <Ajax:BalloonPopupExtender ID="btnGuardar_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel1" BalloonSize="Medium" BehaviorID="btnGuardar_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="btnGuardar">
            </Ajax:BalloonPopupExtender>
            <Ajax:ConfirmButtonExtender ID="btnGuardar_ConfirmButtonExtender" runat="server" BehaviorID="btnGuardar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnGuardar" />
        </td>
        <td class="auto-style18">
            <asp:Button ID="btnContinuar" runat="server" BackColor="#FFFF99" Enabled="False" Font-Bold="True" OnClick="btnContinuar_Click1" Text="Continuar" Width="170px" />
        </td>


        <td class="auto-style18">&nbsp;</td>
        <td class="auto-style18">&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style18" colspan="4">
            <asp:Panel ID="Panel1" runat="server">
                Señor Usuario:&nbsp; Cuando termine de responder, haga Clic en el Botón Guardar y luego en Continuar para seguir Normalmente. Gracias.</asp:Panel>
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
            <asp:HiddenField ID="hfIdCumplimientoMetaSeguimiento" runat="server" />
        </td>
        <td>
            <asp:HiddenField ID="hfIngresos" runat="server" />
        </td>
        <td>
            <asp:HiddenField ID="hfMeta" runat="server" />
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
</table>
</asp:Content>
