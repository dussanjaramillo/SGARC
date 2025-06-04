<%@ Page Title="Cargar" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="Cargar.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.GerentePublico.Cargar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="5"><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-bidi-font-family:
&quot;Times New Roman&quot;;mso-ansi-language:ES;mso-fareast-language:ES;mso-bidi-language:
AR-SA"><h2>Cargar Gerente Público</h2></span></td>
        </tr>
        <tr>
            <td colspan="4">Seleccione el Archivo</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:FileUpload ID="FuCargarArchivo" runat="server" Width="481px" ToolTip="Solo Tipos .xlsx, xls o pdf"  />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:Button ID="btnCargarArchivo" runat="server" OnClick="btnCargarArchivo_Click" Text="Cargar Archivo" Width="482px" />
                <Ajax:ConfirmButtonExtender ID="btnCargarArchivo_ConfirmButtonExtender" runat="server" BehaviorID="btnCargarArchivo_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnCargarArchivo" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SdsGerentePublico" class="grvGrilla" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderWidth="1px" Caption="Archivos Cargados" CellPadding="3" DataKeyNames="IdControlGerentePublico" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" BorderStyle="None" GridLines="Vertical">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdControlGerentePublico" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdControlGerentePublico" />
                        <asp:BoundField DataField="NombreArchivo" HeaderText="NombreArchivo" SortExpression="NombreArchivo" />
                        <asp:BoundField DataField="UsuarioCrea" HeaderText="UsuarioCrea" SortExpression="UsuarioCrea" />
                        <asp:BoundField DataField="FechaUsuarioCrea" HeaderText="Creado el" SortExpression="FechaUsuarioCrea" />
                        <asp:BoundField DataField="UsuarioModifica" HeaderText="UsuarioModifica" SortExpression="UsuarioModifica" />
                        <asp:BoundField DataField="FechaUsuarioModifica" HeaderText="Modificado el" SortExpression="FechaUsuarioModifica" />
                        <asp:BoundField DataField="EsActivo" HeaderText="EsActivo" ReadOnly="True" SortExpression="EsActivo">
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" ForeColor="White" Font-Bold="True" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
            </td>
            <td>
                <asp:CheckBox ID="chbEsActivo" runat="server" Checked="True" Font-Bold="True" ForeColor="Maroon" Text="Activo" TextAlign="Left" ToolTip="Es Activo?" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="481px" />
                <asp:Button ID="btnActualizar" runat="server" OnClick="btnActualizar_Click" Text="Actualizar" Width="170px" Enabled="False" />
                <Ajax:ConfirmButtonExtender ID="btnActualizar_ConfirmButtonExtender" runat="server" BehaviorID="btnActualizar_ConfirmButtonExtender" ConfirmText="Está Seguro?" TargetControlID="btnActualizar" />
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
            <td>
                <asp:HiddenField ID="hfExiste" runat="server" />
            </td>
            <td>
                <asp:SqlDataSource ID="SdsGerentePublico" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_ControlGerentePublicoBuscar]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:HiddenField ID="hfId" runat="server" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
