<%@ Page Title="Consulta" Language="C#" MasterPageFile="~/SiteCf.Master" AutoEventWireup="true" CodeBehind="Consulta.aspx.cs" Inherits="WebLiquidador.Paginas.ProduccionCentros.GerentePublico.Consulta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style8 {
            width: 48%;
        }
        .auto-style9 {
            font-size: large;
        }
    .auto-style10 {
        width: 174px;
    }
    .auto-style11 {
        width: 64%;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table class="auto-style11">
        <tr>
            <td><h2>Consulta Gerente Público</h2></td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SdsGerentePublico" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderWidth="1px" CellPadding="3" DataKeyNames="IdControlGerentePublico" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="1239px" BorderStyle="None" GridLines="Vertical">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="IdControlGerentePublico" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdControlGerentePublico" />
                        <asp:BoundField DataField="NombreArchivo" HeaderText="NombreArchivo" SortExpression="NombreArchivo" >
                        <ControlStyle Font-Bold="False" Font-Italic="False" />
                        <ItemStyle Font-Bold="True" ForeColor="Maroon" />
                        </asp:BoundField>
                        <asp:BoundField DataField="UsuarioCrea" HeaderText="UsuarioCrea" SortExpression="UsuarioCrea" />
                        <asp:BoundField DataField="FechaUsuarioCrea" HeaderText="Creado el" SortExpression="FechaUsuarioCrea" />
                        <asp:BoundField DataField="UsuarioModifica" HeaderText="UsuarioModifica" SortExpression="UsuarioModifica" />
                        <asp:BoundField DataField="FechaUsuarioModifica" HeaderText="Modificado el" SortExpression="FechaUsuarioModifica" />
                        <asp:BoundField DataField="EsActivo" HeaderText="EsActivo" ReadOnly="True" SortExpression="EsActivo">
                        <ItemStyle HorizontalAlign="Center" Font-Bold="True" ForeColor="Maroon" />
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
        </tr>
        </table>
<table class="auto-style11">
        <tr>
            <td class="auto-style10">
                <asp:Button ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click" Text="Limpiar" Width="170px" />
            </td>
            <td>
                <asp:HyperLink ID="HyperLink1" runat="server" CssClass="auto-style9" target="_blank" Visible="False">[HyperLink1]</asp:HyperLink>
            </td>
        </tr>
        </table>
<table class="auto-style8">
        <tr>
            <td>
                <asp:SqlDataSource ID="SdsGerentePublico" runat="server" ConnectionString="<%$ ConnectionStrings:LiquidadorConnectionString %>" SelectCommand="[CentroFormacion].[Usp_ControlGerentePublicoBuscar]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
            <td>
                <asp:TextBox ID="txtNombreArchivo" runat="server" Visible="False"></asp:TextBox>
            </td>
            <td>
                <asp:HiddenField ID="hId" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
