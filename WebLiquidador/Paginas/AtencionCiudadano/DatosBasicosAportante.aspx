<%@ Page Title="Datos Básicos Aportante" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DatosBasicosAportante.aspx.cs" Inherits="WebLiquidador.Paginas.AtencionCiudadano.DatosBasicosAportante" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">


        <script type="text/javascript">
        (function () {
            // Union of Chrome, Firefox, IE, Opera, and Safari console methods
            var methods = ["assert", "cd", "clear", "count", "countReset",
              "debug", "dir", "dirxml", "error", "exception", "group", "groupCollapsed",
              "groupEnd", "info", "log", "markTimeline", "profile", "profileEnd",
              "select", "table", "time", "timeEnd", "timeStamp", "timeline",
              "timelineEnd", "trace", "warn"];
            var length = methods.length;
            var console = (window.console = window.console || {});
            var method;
            var noop = function () { };
            while (length--) {
                method = methods[length];
                // define undefined methods as noops to prevent errors
                if (!console[method])
                    console[method] = noop;
            }
        })();
    </script>


    <style type="text/css">
        .auto-style6 {
            width: 100%;
        }
        .auto-style7 {
        }
        .auto-style8 {
            height: 21px;
        }
        .auto-style9 {
            height: 21px;
            }
        .auto-style10 {
            width: 166px;
        }
        .auto-style11 {
            height: 21px;
            width: 143px;
        }
        .auto-style13 {
            height: 21px;
            width: 34px;
        }
        .auto-style15 {
        }
        .auto-style16 {
            height: 21px;
            width: 18px;
        }
        .auto-style18 {
            height: 21px;
            width: 221px;
        }
        .auto-style19 {
            width: 221px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="7"><h2>Datos Básicos Aportante y/O Constructor -&nbsp; 
                <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                &nbsp;</h2></td>
        </tr>
        <tr>
            <td class="auto-style9">Identificación</td>
            <td class="auto-style11">Nombre Aportante</td>
            <td class="auto-style13"></td>
            <td class="auto-style16"></td>
            <td class="auto-style8"></td>
            <td class="auto-style8"></td>
            <td class="auto-style8"></td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:TextBox ID="txtIdentificacion" runat="server" Width="170px"></asp:TextBox>
                <ajaxToolkit:FilteredTextBoxExtender ID="txtIdentificacion_FilteredTextBoxExtender" runat="server" FilterType="Numbers" TargetControlID="txtIdentificacion" />
            </td>
            <td class="auto-style10" colspan="3">
                <asp:TextBox ID="txtNombre" runat="server" Width="510px" ToolTip="Nombre del Aportante (en Mayúsculas)" MaxLength="200"></asp:TextBox>
                <ajaxToolkit:TextBoxWatermarkExtender ID="txtNombre_TextBoxWatermarkExtender" runat="server" BehaviorID="txtNombre_TextBoxWatermarkExtender" TargetControlID="txtNombre" WatermarkText="Nombre del Aportante (en Mayúsculas)" />
                <ajaxToolkit:FilteredTextBoxExtender ID="txtNombre_FilteredTextBoxExtender" runat="server" BehaviorID="txtNombre_FilteredTextBoxExtender" FilterType="Custom, Numbers, UppercaseLetters" TargetControlID="txtNombre" ValidChars="ÑñÁÉÍÓÚáéíóú ." />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtIdentificacion" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btn_Buscar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style10" colspan="3">
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" style="background-color: #E48F43" colspan="4">
                </td>
            <td class="auto-style8"></td>
            <td class="auto-style8"></td>
            <td class="auto-style8"></td>
        </tr>
        <tr>
            <td class="auto-style10"><asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td class="auto-style10"><asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" />
            </td>
            <td class="auto-style10"><asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
             </td>
            <td class="auto-style10"><asp:Button ID="btnRegresar" runat="server" OnClick="btnRegresar_Click" Text="Regresar" Width="170px" />
             </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style15" colspan="6">
                <asp:GridView ID="gvrDatosBasicos" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="IdDatosBasicosAportante" DataSourceID="SdsDatosBasicosAportantes" ForeColor="#333333" style="margin-left: 0px" Width="1134px">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdDatosBasicosAportante" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdDatosBasicosAportante" />
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:CheckBoxField DataField="Estado" HeaderText="Estado" SortExpression="Estado" />
                        <asp:BoundField DataField="UsuarioCrea" HeaderText="UsuarioCrea" SortExpression="UsuarioCrea" />
                        <asp:BoundField DataField="FechaCrea" HeaderText="FechaCrea" SortExpression="FechaCrea" />
                        <asp:BoundField DataField="UsuarioModifica" HeaderText="UsuarioModifica" SortExpression="UsuarioModifica" />
                        <asp:BoundField DataField="FechaModifica" HeaderText="FechaModifica" SortExpression="FechaModifica" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#CCCCCC" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#465767" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td class="auto-style7">
                            <asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
            </td>
            <td>
                            <asp:HiddenField ID="hfDatosBasicosAportante" runat="server" Visible="False" />
                            </td>
            <td>
                <asp:SqlDataSource ID="SdsDatosBasicosAportantes" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_DatosBasicosAportantesTodos" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
                            </td>
            <td>
                <asp:HiddenField ID="hfErrorValidacion" runat="server" Visible="False" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        </table>
</asp:Content>
