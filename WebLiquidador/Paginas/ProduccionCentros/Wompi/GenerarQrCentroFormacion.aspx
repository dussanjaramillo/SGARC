<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="GenerarQrCentroFormacion.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Wompi.GenerarQrCentroFormacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style2">
        <tr>
            <td colspan="3"><h2>Generación de Qr Wompi para los Centros de Formación</h2></td>
        </tr>
        <tr>
            <td>Regional</td>
            <td>Centro Formación</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                            <asp:DropDownList ID="ddlRegional" runat="server" Width="170px" ToolTip="Regional del Usuario" DataSourceID="SdsRegional" DataTextField="NombreRegional" DataValueField="IdRegional" OnDataBound="ddlRegional_DataBound" AutoPostBack="True">
                            </asp:DropDownList>
            </td>
            <td>
                            <asp:DropDownList ID="ddlCentroFormacion" runat="server" Width="340px" AutoPostBack="True" DataSourceID="SdsCentroXRegional" DataTextField="NombreCentroFormacion" DataValueField="IdCentroFormacion" OnDataBound="ddlCentroFormacion_DataBound" OnSelectedIndexChanged="ddlCentroFormacion_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        <tr>
            <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlRegional" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnBuscar" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
            <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlCentroFormacion" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" InitialValue="-1" ValidationGroup="btnBuscar" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </td>
            <td>
                <asp:Button ID="btnGenerarQr" runat="server" Text="Generar Qr" Width="170px" OnClick="btnGenerarQr_Click" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnGenerarQr_ConfirmButtonExtender" runat="server" BehaviorID="btnUnirCupones_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnGenerarQr" />
            </td>
        </tr>
    </table>
    <table class="auto-style1">
        <tr>
            <td class="auto-style3">&nbsp;</td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
        </tr>
        <tr>
            <td>
                Link Wompi Pagos Rápidos<br />
                <asp:TextBox ID="txtLinkWompiPagosRapidos" runat="server" Enabled="False" MaxLength="100" Width="269px"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>
                <asp:Image ID="ImagenQrWompi" runat="server" Height="200px" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        </table>
    <table class="auto-style1">
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                            <asp:SqlDataSource ID="SdsRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarRegional" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsCentroXRegional" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[dbo].[Usp_BuscarCentroFormacionXRegional]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlRegional" Name="IdRegional" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfIdCentroFormacion" runat="server" />
            </td>
            <td>
                <asp:HiddenField ID="hfCodigoCentroFormacion" runat="server" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
