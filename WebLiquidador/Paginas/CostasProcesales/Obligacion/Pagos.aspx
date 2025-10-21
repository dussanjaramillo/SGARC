<%@ Page Title="Pagos Obligación" Language="C#" MasterPageFile="~/SiteCpp.Master" AutoEventWireup="true" CodeBehind="Pagos.aspx.cs" Inherits="WebLiquidador.Paginas.CostasProcesales.Obligacion.Pagos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
    .auto-style10 {
        width: 55%;
    }
        .auto-style12 {
            width: 67%;
        }
        .auto-style18 {
            width: 898px;
        }
        .auto-style19 {
            width: 42px;
        }
        .auto-style20 {
            width: 68%;
        }
        .auto-style21 {
            height: 21px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style1">
        <tr>
            <td><h2>Pagos Obligacion: 
                <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                    </h2></td>
        </tr>
        </table>
<table class="auto-style10">
        <tr>
            <td>Identificación<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtIdentificacion" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
            </td>
            <td>Deudor</td>
            <td class="auto-style19">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtIdentificacion" runat="server" Width="170px" MaxLength="10"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtIdentificacion_TextBoxWatermarkExtender" runat="server" BehaviorID="txtIdentificacion_TextBoxWatermarkExtender" TargetControlID="txtIdentificacion" WatermarkText="Identificacion" />
                <Ajax:FilteredTextBoxExtender ID="txtIdentificacion_FilteredTextBoxExtender" runat="server" BehaviorID="txtIdentificacion_FilteredTextBoxExtender" FilterType="Numbers" InvalidChars=",." TargetControlID="txtIdentificacion" />
            </td>
            <td colspan="2"><asp:TextBox ID="txtNombre" runat="server" Width="321px" MaxLength="200" Enabled="False" Font-Bold="True" ForeColor="Maroon" ReadOnly="True" Height="16px" ></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtNombre_TextBoxWatermarkExtender" runat="server" BehaviorID="txtNombre_TextBoxWatermarkExtender" TargetControlID="txtNombre" WatermarkText="Nombre y Apellidos" />
            </td>
            <td>
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" ValidationGroup="btnBuscar" />
            </td>
            <td>
                <asp:Button ID="btnImprimir" runat="server" OnClick="btnImprimir_Click" Text="Imprimir" Enabled="False" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" />
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        </table>
    <br />
    <table class="auto-style12">
        <tr>
            <td class="auto-style18" style="background-color: #6E8A34">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style18">
                <asp:GridView ID="grvPagosXIdentificacion" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsPagosXIdentificacion" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnDataBound="grvPagosXIdentificacion_DataBound">
                    <AlternatingRowStyle BackColor="Gainsboro" />
                    <Columns>
                        <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="ValorTotalPago" DataFormatString="{0:N0}" HeaderText="ValorTotal" SortExpression="ValorTotalPago">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FechaPago" DataFormatString="{0:d}" HeaderText="FechaPago" SortExpression="FechaPago" />
                        <asp:BoundField DataField="NumeroCuponPago" HeaderText="CuponPago" SortExpression="NumeroCuponPago" />
                        <asp:BoundField DataField="ValorACapital" DataFormatString="{0:N0}" HeaderText="ValorACapital" SortExpression="ValorACapital">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ValorIntereses" DataFormatString="{0:N0}" HeaderText="ValorIntereses" SortExpression="ValorIntereses">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NumeroProceso" HeaderText="NumeroProceso" SortExpression="NumeroProceso" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#5C6E3E" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td class="auto-style18" style="background-color: #6E8A34">
                &nbsp;</td>
        </tr>
        </table>
    <table class="auto-style20">
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:SqlDataSource ID="SdsPagosXIdentificacion" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CostasProcesales].[Usp_BuscarPagosObligacion]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtIdentificacion" Name="Identificacion" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfIdDeudor" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hfErrorValidacion" runat="server" Visible="False" />
            </td>
            <td>
                <asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style21">
                </td>
            <td class="auto-style21">
                </td>
            <td class="auto-style21">
                </td>
        </tr>
    </table>
</asp:Content>
