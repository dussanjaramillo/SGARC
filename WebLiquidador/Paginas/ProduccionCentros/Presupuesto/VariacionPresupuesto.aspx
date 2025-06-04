<%@ Page Title="Variación de la Meta" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="VariacionPresupuesto.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Presupuesto.VariacionPresupuesto" %>

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
        .auto-style8 {
            width: 100%;
        }

        .auto-style9 {
        }

        .auto-style10 {
            width: 143px;
        }

        .auto-style11 {
            width: 147px;
        }

        .auto-style12 {
            width: 39px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr>
            <td colspan="4">
                <h2>Variación de la Meta :
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
            </td>
        </tr>
        <tr>
            <td class="auto-style11">Vigencia</td>
            <td class="auto-style10">&nbsp;</td>
            <td class="auto-style12">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style11">
                <asp:DropDownList ID="ddlVigencia" runat="server" DataSourceID="SdsVigencia" Width="170px" DataTextField="Vigencia" DataValueField="Vigencia">
                </asp:DropDownList>
                <br />
            </td>
            <td class="auto-style10">
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" Width="170px" ValidationGroup="btnBuscar" />
            </td>
            <td class="auto-style12">
                <asp:Button ID="btnExportar" runat="server" OnClick="btnExportar_Click" Text="Exportar" Width="170px" Enabled="False" />
            </td>
            <td>
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:GridView ID="grvVariacionMeta" runat="server" DataSourceID="SdsVariacionMetaPresupuesto" AutoGenerateColumns="False" OnDataBound="grvVariacionMeta_DataBound" class="grvGrilla" Caption="Variación de la Meta " AllowPaging="True" PageSize="15">
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Nombre" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="Vigencia" HeaderText="Vigencia" SortExpression="Vigencia" />
                        <asp:BoundField DataField="NombreRubro" HeaderText="Rubro" SortExpression="NombreRubro" />
                        <asp:BoundField DataField="MetaAnterior" HeaderText="Meta Anterior" SortExpression="MetaAnterior" DataFormatString="{0:c0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Variacion" HeaderText="Variacion" SortExpression="Variacion" DataFormatString="{0:c0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="MetaVigente" HeaderText="Meta Vigente" SortExpression="MetaVigente" DataFormatString="{0:c0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
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
        <tr>
            <td class="auto-style9" colspan="4">
                <asp:GridView ID="grvVariacionMeta0" runat="server" DataSourceID="SdsVariacionMetaPresupuesto" AutoGenerateColumns="False" Visible="False" class="grvGrilla" Caption="Variación de la Meta ">
                    <Columns>
                        <asp:BoundField DataField="NombreRegional" HeaderText="Regional" SortExpression="NombreRegional" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Codigo" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="Nombre" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="Vigencia" HeaderText="Vigencia" SortExpression="Vigencia" />
                        <asp:BoundField DataField="NombreRubro" HeaderText="Rubro" SortExpression="NombreRubro" />
                        <asp:BoundField DataField="MetaAnterior" HeaderText="Meta Anterior" SortExpression="MetaAnterior" DataFormatString="{0:c0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Variacion" HeaderText="Variacion" SortExpression="Variacion" DataFormatString="{0:c0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="MetaVigente" HeaderText="Meta Vigente" SortExpression="MetaVigente" DataFormatString="{0:c0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <AlternatingRowStyle BackColor="#DCDCDC" />
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
        <tr>
            <td class="auto-style11">
                <asp:SqlDataSource ID="SdsVariacionMetaPresupuesto" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarVariacionMetaPresupuesto]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlVigencia" Name="Vigencia" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="auto-style10">
                <asp:SqlDataSource ID="SdsVigencia" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_BuscarVigencia]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td class="auto-style12">&nbsp;</td>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
        </tr>
    </table>
</asp:Content>
