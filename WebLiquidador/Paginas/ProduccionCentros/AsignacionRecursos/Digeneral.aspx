<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="Digeneral.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.AsignacionRecursos.Digeneral" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
	<style type="text/css">
		.auto-style8 {
			width: 100%;
		}

		.auto-style9 {
			width: 23%;
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
	<table class="auto-style8">
		<tr>
			<td>
				<h2>Asignación de Recursos:
                    <asp:Label ID="lblEstado" runat="server" BackColor="Maroon" ForeColor="White"></asp:Label>
				</h2>
			</td>
		</tr>
		<tr>
			<td>
				<asp:GridView ID="grvAsignacionRecursos" runat="server" DataSourceID="SdsAsignacionRecursos" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="IdAsignacionRecursos" GridLines="Vertical" OnDataBound="grvAsignacionRecursos_DataBound" OnSelectedIndexChanged="grvAsignacionRecursos_SelectedIndexChanged">
					<AlternatingRowStyle BackColor="#DCDCDC" />
					<Columns>
						<asp:CommandField ShowSelectButton="True" />
						<asp:BoundField DataField="IdAsignacionRecursos" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdAsignacionRecursos" />
						<asp:BoundField DataField="NombreCentroFormacion" HeaderText="Centro" SortExpression="NombreCentroFormacion" />
						<asp:BoundField DataField="Radicado" HeaderText="Radicado" SortExpression="Radicado" />
						<asp:BoundField DataField="FechaRadicado" HeaderText="Radicado el" SortExpression="FechaRadicado" DataFormatString="{0:d}"></asp:BoundField>
						<asp:BoundField DataField="ValorSolicitado" HeaderText="Vl Solicitado" SortExpression="ValorSolicitado" DataFormatString="{0:N0}">
							<ItemStyle HorizontalAlign="Right" />
						</asp:BoundField>
						<asp:BoundField DataField="NombreEstadoAsignacionRecursos" HeaderText="Estado" SortExpression="NombreEstadoAsignacionRecursos" />
						<asp:BoundField DataField="Observacion" HeaderText="Observacion" SortExpression="Observacion" />
						<asp:BoundField DataField="NumeroResolucion" HeaderText="Resolucion" SortExpression="NumeroResolucion" />
						<asp:BoundField DataField="FechaResolucion" HeaderText="Fecha" SortExpression="FechaResolucion" DataFormatString="{0:d}" />
						<asp:BoundField DataField="ValorAprobado" HeaderText="Vl Aprobado" SortExpression="ValorAprobado" DataFormatString="{0:N0}">
							<ItemStyle HorizontalAlign="Right" />
						</asp:BoundField>
						<asp:BoundField DataField="FechaCrea" HeaderText="Creado el" SortExpression="FechaCrea" DataFormatString="{0:d}" />
						<asp:BoundField DataField="FechaModifica" HeaderText="Modificado el" SortExpression="FechaModifica" DataFormatString="{0:d}" />
					</Columns>
					<AlternatingRowStyle BackColor="#DCDCDC" />
					<FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
					<HeaderStyle BackColor="#465767" Font-Bold="True" ForeColor="White" />
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
	<table class="auto-style9">
		<tr>
			<td>
				<asp:Button ID="btnAprobar" runat="server" OnClick="btnAprobar_Click" Text="Aprobar" Width="170px" Enabled="False" ValidationGroup="btnAprobar" />
				<Ajax:ConfirmButtonExtender ID="btnAprobar_ConfirmButtonExtender" runat="server" ConfirmOnFormSubmit="True" ConfirmText="Está Seguro" TargetControlID="btnAprobar" />
			</td>
			<td>
				<asp:Button ID="btnEnProceso" runat="server" OnClick="btnEnProceso_Click" Text="En Proceso" Width="170px" Enabled="False" ValidationGroup="btnEnProceso" />
				<Ajax:ConfirmButtonExtender ID="btnEnProceso_ConfirmButtonExtender" runat="server" ConfirmOnFormSubmit="True" ConfirmText="Está Seguro" TargetControlID="btnEnProceso" />
			</td>
			<td>&nbsp;</td>
			<td>
				<asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
			</td>
			<td>
				&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>Observacion</td>
			<td>Número Resolucion</td>
			<td>&nbsp;</td>
			<td>Fecha Resolucion</td>
			<td>Valor Aprobado</td>
			<td>Aprobar</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>
				<asp:TextBox ID="txtObservacion" runat="server" MaxLength="500" Width="170px" Enabled="False" ValidationGroup="btnAprobar"></asp:TextBox>
			</td>
			<td>
				<asp:TextBox ID="txtNumeroResolucion" runat="server" MaxLength="15" Width="170px" Enabled="False" ValidationGroup="btnAprobar"></asp:TextBox>
			</td>
			<td>&nbsp;</td>
			<td>
				<asp:TextBox ID="txtFechaResolucion" runat="server" MaxLength="10" Width="170px" Enabled="False" ValidationGroup="btnAprobar"></asp:TextBox>
			</td>
			<td>
				<asp:TextBox ID="txtValorAprobado" runat="server" MaxLength="10" Width="170px" Enabled="False" ValidationGroup="btnAprobar"></asp:TextBox>
			</td>
			<td>
				<asp:DropDownList ID="ddlAprobar" runat="server" DataSourceID="SdsEstadoAsignacionRecursos" OnDataBound="ddlAprobar_DataBound" Width="170px" DataTextField="NombreEstadoAsignacionRecursos" DataValueField="IdEstadoAsignacionRecursos" Enabled="False" ValidationGroup="btnAprobar">
				</asp:DropDownList>
			</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>
				<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtObservacion" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAprobar"></asp:RequiredFieldValidator>
			</td>
			<td>
				<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNumeroResolucion" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAprobar"></asp:RequiredFieldValidator>
			</td>
			<td>&nbsp;</td>
			<td>
				<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtFechaResolucion" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAprobar"></asp:RequiredFieldValidator>
			</td>
			<td>
				<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtValorAprobado" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAprobar"></asp:RequiredFieldValidator>
			</td>
			<td>
				<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlAprobar" ErrorMessage="Requerido" Font-Bold="True" ForeColor="Maroon" ValidationGroup="btnAprobar" InitialValue="-1"></asp:RequiredFieldValidator>
			</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
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
	</table>
	<table class="auto-style8">
		<tr>
			<td>
				<asp:SqlDataSource ID="SdsAsignacionRecursos" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_AsignacionRecursosBuscarTodas]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
			</td>
			<td>
				<asp:HiddenField ID="hfTransaccion" runat="server" Visible="False" />
			</td>
			<td>
				<asp:ScriptManager ID="ScriptManager1" runat="server">
				</asp:ScriptManager>
			</td>
			<td>
				<asp:HiddenField ID="hfIdAsignacionRecursos" runat="server" Visible="False" />
			</td>
			<td>&nbsp;</td>
			<td>
				<asp:SqlDataSource ID="SdsEstadoAsignacionRecursos" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_EstadoAsignacionRecursosBuscar]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
			</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
</asp:Content>
