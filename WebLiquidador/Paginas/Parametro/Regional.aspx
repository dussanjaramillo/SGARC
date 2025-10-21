<%@ Page Title="Regional" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Regional.aspx.cs" Inherits="WebLiquidador.Paginas.Parametro.Regional" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style6 {
            width: 42%;
        }
        .auto-style7 {
            width: 242px;
        }
        .auto-style8 {
        }
        .auto-style9 {
            width: 171px;
        }
        .auto-style10 {
            width: 180px;
        }
        .auto-style11 {
            width: 183px;
        }
        .auto-style12 {
            width: 144px;
        }
        .auto-style15 {
            width: 144px;
            height: 21px;
        }
        .auto-style16 {
            width: 171px;
            height: 21px;
        }
        .auto-style17 {
            width: 180px;
            height: 21px;
        }
        .auto-style18 {
            width: 183px;
            height: 21px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style6">
        <tr>
            <td colspan="4"><h2>Regional -&nbsp; 
                <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                    &nbsp;</h2></td>
        </tr>
        <tr>
            <td class="auto-style15">Código<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCodigoRegional" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar" EnableTheming="True"></asp:RequiredFieldValidator>
                </td>
            <td class="auto-style16">Nombre<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNombreRegional" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar" EnableTheming="True"></asp:RequiredFieldValidator>
                </td>
            <td class="auto-style17">Dirección<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDireccion" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar" EnableTheming="True"></asp:RequiredFieldValidator>
                </td>
            <td class="auto-style18">Teléfonos<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtTelefonos" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar" EnableTheming="True"></asp:RequiredFieldValidator>
                </td>
        </tr>
        <tr>
            <td class="auto-style12">
                <asp:TextBox ID="txtCodigoRegional" runat="server" MaxLength="2" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtCodigoRegional_TextBoxWatermarkExtender" runat="server" BehaviorID="txtCodigoRegional_TextBoxWatermarkExtender" TargetControlID="txtCodigoRegional" WatermarkText="Código" />
            </td>
            <td class="auto-style9">
                <asp:TextBox ID="txtNombreRegional" runat="server" MaxLength="25" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtNombreRegional_TextBoxWatermarkExtender" runat="server" BehaviorID="txtNombreRegional_TextBoxWatermarkExtender" TargetControlID="txtNombreRegional" WatermarkText="Nombre" />
            </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtDireccion" runat="server" MaxLength="50" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtDireccion_TextBoxWatermarkExtender" runat="server" BehaviorID="txtDireccion_TextBoxWatermarkExtender" TargetControlID="txtDireccion" WatermarkText="Dirección" />
            </td>
            <td class="auto-style11">
                <asp:TextBox ID="txtTelefonos" runat="server" MaxLength="25" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtTelefonos_TextBoxWatermarkExtender" runat="server" BehaviorID="txtTelefonos_TextBoxWatermarkExtender" TargetControlID="txtTelefonos" WatermarkText="Teléfonos" />
            </td>
        </tr>
        <tr>
            <td class="auto-style12">Departamento<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlDepartamento" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar" EnableTheming="True" InitialValue="-1"></asp:RequiredFieldValidator>
                </td>
            <td class="auto-style9">Municipio<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlMunicipio" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar" EnableTheming="True" InitialValue="-1"></asp:RequiredFieldValidator>
                </td>
            <td class="auto-style10">Director<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtDirector" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar" EnableTheming="True"></asp:RequiredFieldValidator>
                </td>
            <td class="auto-style11">Correo<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtCorreoDirector" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnGuardar" EnableTheming="True"></asp:RequiredFieldValidator>
                </td>
        </tr>
        <tr>
            <td class="auto-style12">
                <asp:DropDownList ID="ddlDepartamento" runat="server" AutoPostBack="True" DataSourceID="SdsDepartamento" DataTextField="NombreDepartamento" DataValueField="IdDepartamento" OnDataBound="ddlDepartamento_DataBound" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged" Width="170px">
                </asp:DropDownList>
            </td>
            <td class="auto-style9">
                <asp:DropDownList ID="ddlMunicipio" runat="server" Width="170px">
                </asp:DropDownList>
            </td>
            <td class="auto-style10">
                <asp:TextBox ID="txtDirector" runat="server" MaxLength="100" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtDirector_TextBoxWatermarkExtender" runat="server" BehaviorID="txtDirector_TextBoxWatermarkExtender" TargetControlID="txtDirector" WatermarkText="Nombre del Director" />
            </td>
            <td class="auto-style11">
                <asp:TextBox ID="txtCorreoDirector" runat="server" MaxLength="20" Width="170px"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtCorreoDirector_TextBoxWatermarkExtender" runat="server" BehaviorID="txtCorreoDirector_TextBoxWatermarkExtender" TargetControlID="txtCorreoDirector" WatermarkText="Codigo Correo Director" />
            </td>
        </tr>
        <tr>
            <td class="auto-style12">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" Width="170px" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="btnGuardar" runat="server" OnClick="btnGuardar_Click" Text="Guardar" ValidationGroup="btnGuardar" Width="170px" />
            </td>
            <td class="auto-style10">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td class="auto-style11">
                <asp:CheckBox ID="chbEsActivo" runat="server" Checked="True" Font-Bold="True" ForeColor="Maroon" Text="Activo" TextAlign="Left" ToolTip="Es Activo?" />
            </td>
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td class="auto-style8">
                <asp:GridView ID="grvRegional" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnSelectedIndexChanged="grvRegional_SelectedIndexChanged" PageSize="15" Width="1031px" OnPageIndexChanging="grvRegional_PageIndexChanging">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdRegional" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdRegional" />
                        <asp:BoundField DataField="CodigoRegional" HeaderText="Codigo" SortExpression="CodigoRegional" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Nombre" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="Director" HeaderText="Director" SortExpression="Director" />
                        <asp:BoundField DataField="CorreoDirector" HeaderText="Correo" SortExpression="CorreoDirector" />
                        <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion" />
                        <asp:BoundField DataField="Telefonos" HeaderText="Telefonos" SortExpression="Telefonos" />
                        <asp:CheckBoxField DataField="EsActivo" HeaderText="Activo" SortExpression="EsActivo" />
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
        </tr>
        </table>
    <table class="auto-style6">
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsDepartamento" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarDepartamento" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfErrorValidacion" runat="server" Visible="False" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsBuscarEntidadPublica" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarEntidadPublica1" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SqlBuscarRegional_2" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="Usp_BuscarRegional_2" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfRegional" runat="server" Visible="False" />
            </td>
            <td>
                <asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
