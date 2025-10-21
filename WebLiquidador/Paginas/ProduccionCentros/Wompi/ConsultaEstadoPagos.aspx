<%@ Page Title="Consulta de Pagos por Wompi" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="ConsultaEstadoPagos.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.Wompi.ConsultaEstadoPagos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style8">
        <tr> 
            <td><h2>Consulta de Pagos por Wompi:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
                </h2>
                </td> 
            
        </tr>
        </table>
<table class="auto-style10">
        <tr> 
            <td>
                Fecha Inicial Pago<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFechaInicial" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="txtFechaInicial" runat="server" MaxLength="10" Width="170px" ValidationGroup="btnBuscar"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtFechaInicial_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaInicial_TextBoxWatermarkExtender" TargetControlID="txtFechaInicial" WatermarkText="AAAA-MM-DD" />
                <Ajax:CalendarExtender ID="txtFechaInicial_CalendarExtender" runat="server" BehaviorID="txtFechaInicial_CalendarExtender" Format="yyyy-MM-dd" TargetControlID="txtFechaInicial" />
                </td> 
            
            <td>
                Fecha Final Pago<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFechaFinal" ErrorMessage=": Requerido" Font-Bold="True" ForeColor="Maroon" SetFocusOnError="True" ValidationGroup="btnBuscar"></asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="txtFechaFinal" runat="server" MaxLength="10" Width="170px" ValidationGroup="btnBuscar"></asp:TextBox>
                <Ajax:TextBoxWatermarkExtender ID="txtFechaFinal_TextBoxWatermarkExtender" runat="server" BehaviorID="txtFechaFinal_TextBoxWatermarkExtender" TargetControlID="txtFechaFinal" WatermarkText="AAAA-MM-DD" />
                <Ajax:CalendarExtender ID="txtFechaFinal_CalendarExtender" runat="server" BehaviorID="txtFechaFinal_CalendarExtender" Format="yyyy-MM-dd" TargetControlID="txtFechaFinal" />
                </td> 
            
            <td>
                <br />
                <asp:Button ID="btnBuscar" runat="server" OnClick="btnBuscar_Click" Text="Buscar" Width="170px" ValidationGroup="btnBuscar" />
                </td> 
            
            <td class="auto-style9">
                <br />
            <asp:Button ID="btn_Limpiar" runat="server" Text="Limpiar" Width="170px" OnClick="btn_Limpiar_Click" ToolTip="Limpia el Formulario" />
                </td> 
            
        </tr>
        </table>
<table class="auto-style8">
        <tr>
            <td>
                <asp:GridView ID="grvPagosWompi" runat="server" DataSourceID="SdsConsultaPagosWompi" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" OnDataBound="grvPagosWompi_DataBound" PageSize="15" AllowSorting="True">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:BoundField DataField="Item" HeaderText="Item" ReadOnly="True" SortExpression="Item" />
                        <asp:BoundField DataField="CodigoCentroFormacion" HeaderText="Centro" SortExpression="CodigoCentroFormacion" />
                        <asp:BoundField DataField="NombreCentroFormacion" HeaderText="NombreCentro" SortExpression="NombreCentroFormacion" />
                        <asp:BoundField DataField="Documento" HeaderText="Identificacion" SortExpression="Documento" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="FechaPago" DataFormatString="{0:d}" HeaderText="FechaPago" SortExpression="FechaPago" />
                        <asp:BoundField DataField="Monto" DataFormatString="{0:c0}" HeaderText="ValorPagado" SortExpression="Monto" >
                        <ItemStyle Font-Bold="True" ForeColor="Maroon" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PreFactura" HeaderText="PreFactura" SortExpression="PreFactura" >
                        <ItemStyle Font-Bold="True" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CuponPago" HeaderText="CuponPago" SortExpression="CuponPago" >
                        <ItemStyle Font-Bold="True" ForeColor="Maroon" />
                        </asp:BoundField>
                        <asp:CheckBoxField DataField="Aplicado" HeaderText="Aplicado" SortExpression="Aplicado" />
                        <asp:BoundField DataField="FechaCrea" DataFormatString="{0:d}" HeaderText="FechaCrea" SortExpression="FechaCrea" />
                        <asp:BoundField DataField="NombreTipoIngreso" HeaderText="TipoIngreso" SortExpression="NombreTipoIngreso" />
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
                <asp:SqlDataSource ID="SdsConsultaPagosWompi" runat="server" ConnectionString="<%$ ConnectionStrings:CentroFormacion %>" SelectCommand="[Wompi].[Usp_BuscarPagosCentrosWompi]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtFechaInicial" DbType="Date" Name="FechaInicial" PropertyName="Text" />
                        <asp:ControlParameter ControlID="txtFechaFinal" DbType="Date" Name="FechaFinal" PropertyName="Text" />
                        <asp:SessionParameter Name="IdCentroFormacion" SessionField="_IdCentroFormacion" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                </asp:ScriptManager>
            </td>
        </tr>
        </table>
</asp:Content>
