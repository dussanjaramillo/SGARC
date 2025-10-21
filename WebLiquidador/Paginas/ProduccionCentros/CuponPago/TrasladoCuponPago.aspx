<%@ Page Title="Translado de Cupón de Pago" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="TrasladoCuponPago.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.CuponPago.TrasladoCuponPago" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style type="text/css">
        .auto-style11 {
            width: 102px;
        }
        .auto-style15 {
            height: 16px;
        }
        .auto-style17 {
            height: 14px;
            width: 102px;
        }
        .auto-style18 {
            height: 14px;
        }
        .auto-style22 {
            height: 16px;
            width: 102px;
        }
        .auto-style23 {
            height: 304px;
        }
        .auto-style24 {
            width: 174px;
        }
        .auto-style25 {
            height: 16px;
            width: 174px;
        }
        .auto-style26 {
            height: 14px;
            width: 174px;
        }
        .auto-style27 {
            height: 40px;
            width: 174px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style23">
        <tr>
            <td colspan="6">
                <h2>Traslado de Cupón de Pago</h2>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #FFFF99">
                <h1>Origen</h1>
            </td>
            <td>
                &nbsp;</td>
            <td colspan="2" style="background-color: #CCFFCC">
                <h1>Destino</h1>
            </td>
        </tr>
        <tr>
            <td class="auto-style24">Cupón de Pago<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCuponPago" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnBuscar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style11"></td>
            <td class="auto-style11"></td>
            <td class="auto-style11"></td>
            <td>Regional<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlRegional0" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnTrasladoCuponPago"></asp:RequiredFieldValidator>
            </td>
            <td>Centro Formación<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlCentroFormacion0" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnTrasladoCuponPago"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style24">
                <asp:TextBox ID="txtCuponPago" runat="server" MaxLength="10" Width="170px"></asp:TextBox>
                <ajax:filteredtextboxextender ID="txtCuponPago_FilteredTextBoxExtender" runat="server" BehaviorID="txtCuponPago_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=".," TargetControlID="txtCuponPago" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td class="auto-style9">&nbsp;</td>
            <td>
                <asp:DropDownList ID="ddlRegional0" runat="server" Width="170px" ToolTip="Regional del Usuario" DataSourceID="SdsRegional0" DataTextField="NombreRegional" DataValueField="IdRegional" OnDataBound="ddlRegional0_DataBound" AutoPostBack="True" OnSelectedIndexChanged="ddlRegional0_SelectedIndexChanged" BackColor="#CCFFCC" Enabled="False">
                </asp:DropDownList>
            </td>
            <td>
                <asp:DropDownList ID="ddlCentroFormacion0" runat="server" Width="340px" AutoPostBack="True" BackColor="#CCFFCC" Enabled="False">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="auto-style25">Tipo Ingreso</td>
            <td class="auto-style15">Regional</td>
            <td class="auto-style15">Código Centro</td>
            <td class="auto-style15"></td>
            <td class="auto-style15">
                Tipo Ingreso<asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnTrasladoCuponPago" ControlToValidate="ddlTipoIngreso" SetFocusOnError="True" InitialValue="-1"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style15"></td>
        </tr>
        <tr>
            <td class="auto-style26">
                <asp:TextBox ID="txtNombreTipoIngreso" runat="server" BackColor="#FFFF66" Enabled="False" Width="170px" Font-Bold="True" ForeColor="Black"></asp:TextBox>
            </td>
            <td class="auto-style17">
                <asp:TextBox ID="txtRegional" runat="server" BackColor="#FFFF66" ReadOnly="True" Width="170px" Enabled="False" Font-Bold="True" ForeColor="Black"></asp:TextBox>
            </td>
            <td class="auto-style17">
                <asp:TextBox ID="txtCodigoCentroFormacion" runat="server" BackColor="#FFFF66" ReadOnly="True" Width="170px" Enabled="False" Font-Bold="True" ForeColor="Black"></asp:TextBox>
            </td>
            <td class="auto-style17">
                </td>
            <td class="auto-style18">
                <asp:DropDownList ID="ddlTipoIngreso" runat="server" DataSourceID="SdsTipoIngreso" DataTextField="NombreTipoIngreso" DataValueField="IdTipoIngreso" OnDataBound="ddlTipoIngreso_DataBound" ValidationGroup="btnCargarArchivo" Width="161px" BackColor="#CCFFCC" Enabled="False">
                </asp:DropDownList>
                </td>
            <td class="auto-style18">
                <asp:Button ID="btnTrasladoCuponPago" runat="server" OnClick="btnTrasladoCuponPago_Click" Text="Trasladar Cupón Pago" Visible="False" ValidationGroup="btnTrasladoCuponPago" Width="325px" />
                <ajax:confirmbuttonextender ID="btnTrasladoCuponPago_ConfirmButtonExtender" runat="server" BehaviorID="btnTrasladoCuponPago_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnTrasladoCuponPago" />
            </td>
        </tr>
        <tr>
            <td class="auto-style25">
                Nombre Centro de Formación</td>
            <td class="auto-style22">
                &nbsp;</td>
            <td class="auto-style22">
                Prefactura</td>
            <td class="auto-style22">
                &nbsp;</td>
            <td class="auto-style15">
                &nbsp;</td>
            <td class="auto-style15">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15" colspan="2">
                <asp:TextBox ID="txtNombreCentroFormacion" runat="server" BackColor="#FFFF66" Enabled="False" Width="340px" Font-Bold="True" ForeColor="Black"></asp:TextBox>
            </td>
            <td class="auto-style22">
                <asp:TextBox ID="txtPrefactura" runat="server" BackColor="#FFFF66" Enabled="False" Width="170px" Font-Bold="True" ForeColor="Black"></asp:TextBox>
                </td>
            <td class="auto-style22">
                &nbsp;</td>
            <td class="auto-style15">
                &nbsp;</td>
            <td class="auto-style15">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style25">
                Numero Cupón Pago</td>
            <td class="auto-style22">
                Valor Cupón</td>
            <td class="auto-style22">
                Fecha Pago</td>
            <td class="auto-style22">
                </td>
            <td class="auto-style15">
                </td>
            <td class="auto-style15">
                </td>
        </tr>
        <tr>
            <td class="auto-style27">
                <asp:TextBox ID="txtNroInternodeTransaccion" runat="server" BackColor="#FFFF66" Enabled="False" Width="170px" Font-Bold="True" ForeColor="Black"></asp:TextBox>
                </td>
            <td class="auto-style8">
                <asp:TextBox ID="txtValorPago" runat="server" BackColor="#FFFF66" Enabled="False" Width="170px" Font-Bold="True" ForeColor="Black"></asp:TextBox>
                </td>
            <td class="auto-style8">
                <asp:TextBox ID="txtFechaPago" runat="server" BackColor="#FFFF66" Enabled="False" Width="170px" Font-Bold="True" ForeColor="Black"></asp:TextBox>
                </td>
            <td class="auto-style8">
                </td>
            <td class="auto-style8">
            </td>
            <td class="auto-style8">
            </td>
        </tr>
        </table>
    <table class="auto-style8">
        <tr>
            <td>
                Identificación</td>
            <td>
                Primer Nombre</td>
            <td>
                Primer Apellido</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtIdentificacion" runat="server" BackColor="#FFFF66" Enabled="False" Width="170px" Font-Bold="True" ForeColor="Black"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtPrimerNombre" runat="server" BackColor="#FFFF66" Enabled="False" Width="170px" Font-Bold="True" ForeColor="Black"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtPrimerApellido" runat="server" BackColor="#FFFF66" Enabled="False" Width="170px" Font-Bold="True" ForeColor="Black"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hfIdCuponPago" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsRegional0" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarRegional" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsTipoIngreso" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarTipoIngreso]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfIdCentroFormacion" runat="server" />
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfAsignado" runat="server" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        </table>
</asp:Content>
