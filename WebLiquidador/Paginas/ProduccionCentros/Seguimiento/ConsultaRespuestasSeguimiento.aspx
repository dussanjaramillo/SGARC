<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ConsultaRespuestasSeguimiento.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Seguimiento.ConsultaRespuestasSeguimiento" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style11">
    <tr>
        <td><h2 class="auto-style1">Consulta Respuestas: 
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label></h2>
        </td>
    </tr>
    </table>
    <table class="auto-style8">
    <tr>
        <td class="auto-style10">
                <asp:DropDownList ID="ddlCumplimientoMetaSeguimientoAñoMes" runat="server" DataSourceID="SdsCumplimientoMetaSeguimientoAñoMes" Width="170px" DataTextField="AñoMes" DataValueField="AñoMes">
                </asp:DropDownList>
            </td>
        <td>
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" Width="170px" ValidationGroup="btnBuscar" />
            </td>
        <td>
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" />
            </td>
        <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
    </tr>
    </table>
<table class="auto-style8">
    <tr>
        <td>
            <asp:GridView ID="grvRespuestaCentro" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsRespuestasCumplimientoMetaSeguimiento" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" OnSelectedIndexChanged="grvRespuestaCentro_SelectedIndexChanged" OnPageIndexChanging="grvRespuestaCentro_PageIndexChanging">
                <AlternatingRowStyle BackColor="#DCDCDC" />
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" />
                    <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                    <asp:BoundField DataField="AñoMes" HeaderText="AñoMes" SortExpression="AñoMes" />
                    <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Centro" SortExpression="CodigoCentroFormacion" />
                    <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Nombre" SortExpression="NombreCentroFormacion" />
                    <asp:BoundField DataField="Meta" HeaderText="Meta" SortExpression="Meta" DataFormatString="{0:N2}" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Ingresos" HeaderText="Ingresos" SortExpression="Ingresos" DataFormatString="{0:N2}" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CumplimientoMeta" HeaderText="%Meta" SortExpression="CumplimientoMeta" DataFormatString="{0:N2}" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ProyeccionMes" HeaderText="P. Mes" SortExpression="ProyeccionMes" DataFormatString="{0:N2}" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="PorcentajeCumplimientoMes" HeaderText="%C.Mes" SortExpression="PorcentajeCumplimientoMes" DataFormatString="{0:N2}" >
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
            </asp:GridView>
            <asp:GridView ID="grvRespuestas" runat="server" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsRespuestasCumplimientoMetaSeguimientoXId" AutoGenerateColumns="False"  CssClass="grvGrilla"  Caption="Respuestas">
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <Columns>
                    <asp:BoundField DataField="Respuesta1" HeaderText="Respuesta1" SortExpression="Respuesta1" />
                    <asp:BoundField DataField="Respuesta2" HeaderText="Respuesta2" SortExpression="Respuesta2" />
                    <asp:BoundField DataField="Respuesta3" HeaderText="Respuesta3" SortExpression="Respuesta3" />
                    <asp:BoundField DataField="Respuesta4" HeaderText="Respuesta4" SortExpression="Respuesta4" DataFormatString="{0:N0}">
                    <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="FechaRespuesta" DataFormatString="{0:d}" HeaderText="FechaRespuesta" SortExpression="FechaRespuesta" />
                </Columns>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <SortedAscendingCellStyle BackColor="#F4F4FD" />
                <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                <SortedDescendingCellStyle BackColor="#D8D8F0" />
                <SortedDescendingHeaderStyle BackColor="#3E3277" />
            </asp:GridView>
            <asp:GridView ID="grvRespuestaCentro0" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SdsRespuestasCumplimientoMetaSeguimiento" AutoGenerateColumns="False" Visible="False" DataKeyNames="Id">
                <AlternatingRowStyle BackColor="#DCDCDC" />
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" InsertVisible="False" ReadOnly="True" />
                    <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                    <asp:BoundField DataField="AñoMes" HeaderText="AñoMes" SortExpression="AñoMes" />
                    <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />
                    <asp:BoundField DataField="NombreCentroFormacion" HeaderText="CentroFormacion" SortExpression="NombreCentroFormacion" />
                    <asp:BoundField DataField="Meta" HeaderText="Meta" SortExpression="Meta" />
                    <asp:BoundField DataField="Ingresos" HeaderText="Ingresos" SortExpression="Ingresos" />
                    <asp:BoundField DataField="CumplimientoMeta" HeaderText="CumplimientoMeta" SortExpression="CumplimientoMeta" />
                    <asp:BoundField DataField="ProyeccionMes" HeaderText="ProyeccionMes" SortExpression="ProyeccionMes" />
                    <asp:BoundField DataField="PorcentajeCumplimientoMes" HeaderText="PorcentajeCumplimientoMes" SortExpression="PorcentajeCumplimientoMes" />
                    <asp:BoundField DataField="Respuesta1" HeaderText="Respuesta1" SortExpression="Respuesta1" />
                    <asp:BoundField DataField="Respuesta2" HeaderText="Respuesta2" SortExpression="Respuesta2" />
                    <asp:BoundField DataField="Respuesta3" HeaderText="Respuesta3" SortExpression="Respuesta3" />
                    <asp:BoundField DataField="Respuesta4" HeaderText="Respuesta4" SortExpression="Respuesta4" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                    <asp:BoundField DataField="FechaRespuesta" HeaderText="FechaRespuesta" SortExpression="FechaRespuesta" DataFormatString="{0:d}" />
                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
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
    </table>
    <table class="auto-style8">
    <tr>
        <td>
            <asp:SqlDataSource ID="SdsRespuestasCumplimientoMetaSeguimiento" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarRespuestasCumplimientoMetaSeguimiento]" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlCumplimientoMetaSeguimientoAñoMes" Name="AñoMes" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
        <td>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
        </td>
        <td>
            <asp:HiddenField ID="hdId" runat="server" />
        </td>
        <td>
            <asp:SqlDataSource ID="SdsRespuestasCumplimientoMetaSeguimientoXId" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarRespuestasCumplimientoMetaSeguimientoXId]" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdId" Name="Id" PropertyName="Value" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>
            <asp:SqlDataSource ID="SdsCumplimientoMetaSeguimientoAñoMes" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarCumplimientoMetaSeguimientoAñoMes]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </td>
        <td>
            &nbsp;</td>
        <td>
            &nbsp;</td>
        <td>
            &nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
</table>
</asp:Content>
