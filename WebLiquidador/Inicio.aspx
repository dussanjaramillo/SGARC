<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="WebLiquidador.Inicio" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

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


    <link rel="icon" type="image/ico" href="/Imagenes/Sena.ico" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Control de Acceso</title>
    <style type="text/css">
        .auto-style2 {
            height: 23px;
            width: 134px;
        }

        .auto-style3 {
            height: 25px;
            width: 134px;
        }

        .auto-style4 {
            height: 45px;
            text-align: center;
            line-height: 107%;
            font-family: "Trebuchet MS", sans-serif;
            font-size: large;
            color: #556B2F;
        }

        .auto-style5 {
            height: 25px;
            text-align: right;
            line-height: 107%;
            font-family: "Trebuchet MS", sans-serif;
            font-size: small;
            width: 98px;
        }

        .auto-style8 {
            text-align: center;
        }

        .auto-style12 {
            text-align: center;
            height: 8px;
            width: 602px;
        }

        .auto-style17 {
            text-align: center;
            width: 602px;
            height: 23px;
        }

        .auto-style22 {
            height: 25px;
            width: 88px;
        }

        .auto-style23 {
            height: 23px;
            width: 88px;
        }

        .auto-style24 {
            text-align: center;
            height: 7px;
            width: 600px;
        }

        .content-wrapper {
            margin: 0 auto;
            max-width: 960px;
        }

        .content-wrapper {
            padding-right: 10px;
            padding-left: 10px;
        }

        hgroup.title {
            margin-bottom: 10px;
        }

        .title {
            display: block;
            float: left;
            text-align: left;
            width: auto;
        }

        hgroup {
            display: block;
        }

        h1 {
            font-size: 1.6em;
            padding-bottom: 0px;
            margin-bottom: 0px;
        }

        h1, h2, h3, h4, h5, h6 {
            font-size: 1.5em;
            color: #666666;
            font-variant: small-caps;
            text-transform: none;
            font-weight: 200;
            margin-bottom: 0px;
        }

        h2 {
            font-size: 1.5em;
            font-weight: 600;
        }

        p {
            margin-bottom: 10px;
            line-height: 1.6em;
            height: 28px;
        }


        a:link, a:visited {
            color: #034af3;
        }

        mark {
            background-color: #a6dbed;
            padding-left: 5px;
            padding-right: 5px;
        }

        .auto-style25 {
            color: #FF6A00;
            font-size: large;
        }

        .auto-style26 {
            color: #4B6C9E;
        }

        .auto-style4 {
            color: #556B2F;
        }

        .auto-style27 {
            color: #800000;
            font-family: Arial, Helvetica, sans-serif;
        }

        .auto-style28 {
            font-family: Arial, Helvetica, sans-serif;
        }

        .auto-style29 {
            width: 100%;
        }

        .auto-style31 {
            width: 600px;
        }

        .auto-style32 {
            color: #4B6C9E;
            font-size: large;
        }
        .auto-style33 {
            color: #006600;
            font-size: large;
        }
        .auto-style34 {
            width: 622px;
        }
        .auto-style35 {
            height: 45px;
            text-align: left;
            line-height: 107%;
            font-family: "Trebuchet MS", sans-serif;
            font-size: large;
            color: #556B2F;
            width: 70px;
        }
        .auto-style36 {
            height: 25px;
            width: 70px;
        }
        .auto-style37 {
            height: 23px;
            width: 70px;
        }
        .auto-style38 {
            height: 45px;
            text-align: center;
            line-height: 107%;
            font-family: "Trebuchet MS", sans-serif;
            font-size: large;
            color: #556B2F;
            width: 98px;
        }
    </style>
</head>
<body>




    <form id="form1" runat="server">
        <div aria-atomic="False">
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />

            <table align="center">
                <tr>
                    <td class="auto-style24" style="background-color: #ff6a00">
                        <br />
                    </td>
                </tr>

                <tr>
                    <td class="auto-style24" style="background-color: #4b6c9e">
                        <br />
                    </td>
                </tr>

                <tr>
                    <td class="auto-style24" style="background-color: #006600">
                        &nbsp;</td>
                </tr>

            </table>
            <table align="center">

                <tr>
                    <td class="auto-style8" colspan="4">
                        <asp:Image ID="Image1" runat="server" Height="110px" ImageUrl="~/Imagenes/LogoSena1.png" Width="126px" Style="margin-left: 0px" />
                        <asp:Image ID="Image4" runat="server" Height="47px" ImageUrl="~/Imagenes/logo-minTrabajo.png" Width="212px" />
                        <strong>&nbsp;&nbsp; </strong>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4" colspan="4" style="mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-bidi-font-family: Arial; mso-ansi-language: ES-CO; mso-fareast-language: ES-CO; mso-bidi-language: AR-SA">
                        <h1 class="auto-style34">
                            <span class="auto-style32"><strong>Producción de Centros</strong></span><span class="auto-style25"> - <strong>Atención al Ciudadano</strong></span> <span class="auto-style33"><strong>- Costas Procesales</strong></span>
                            </h1>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4" style="mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-bidi-font-family: Arial; mso-ansi-language: ES-CO; mso-fareast-language: ES-CO; mso-bidi-language: AR-SA">
                        &nbsp;</td>
                    <td class="auto-style38" style="mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-bidi-font-family: Arial; mso-ansi-language: ES-CO; mso-fareast-language: ES-CO; mso-bidi-language: AR-SA">
                        &nbsp;</td>
                    <td class="auto-style35" style="mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-bidi-font-family: Arial; mso-ansi-language: ES-CO; mso-fareast-language: ES-CO; mso-bidi-language: AR-SA">
                        <asp:Image ID="Image5" runat="server" BorderColor="Maroon" BorderStyle="Solid" Visible="False" Height="30px" Width="118px" />
                    </td>
                    <td class="auto-style4" style="mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-bidi-font-family: Arial; mso-ansi-language: ES-CO; mso-fareast-language: ES-CO; mso-bidi-language: AR-SA">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style22">&nbsp;</td>
                    <td class="auto-style5" style="mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-bidi-font-family: Arial; mso-ansi-language: ES-CO; mso-fareast-language: ES-CO; mso-bidi-language: AR-SA">&nbsp;</td>
                    <td class="auto-style36">
                        <strong>
                            <span class="auto-style26">
                                <asp:TextBox ID="txtCaptcha" runat="server" alt="Escriba el Código de la Imagen y luego haga Click en Aceptar" autocomplete="off" Font-Bold="True" Font-Italic="False" MaxLength="5" name="Captcha" PlaceHolder="        Captcha" Width="120px"></asp:TextBox>
                                <ajaxToolkit:BalloonPopupExtender ID="txtCaptcha_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel3" DisplayOnFocus="True" DisplayOnMouseOver="True" TargetControlID="txtCaptcha">
                                </ajaxToolkit:BalloonPopupExtender>
                            </span>
                        </strong>
                    </td>
                    <td class="auto-style3">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style22">&nbsp;</td>
                    <td class="auto-style5" style="mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-bidi-font-family: Arial; mso-ansi-language: ES-CO; mso-fareast-language: ES-CO; mso-bidi-language: AR-SA">&nbsp;</td>
                    <td class="auto-style36">
                        <strong>
                            <span class="auto-style26">
                                <asp:Button ID="btnAceptar" runat="server" OnClick="btnAceptar_Click" Text="Aceptar" ValidationGroup="btnAceptar" Width="125px" />
                            </span>
                        </strong>
                    </td>
                    <td class="auto-style3">
                        <strong>
                            <span class="auto-style26">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtCaptcha" Display="None" ErrorMessage="El Captcha es Requerido" Font-Bold="True" ForeColor="Maroon" Font-Size="Larger" ValidationGroup="btnAceptar"></asp:RequiredFieldValidator>
                                <ajaxToolkit:ValidatorCalloutExtender ID="RequiredFieldValidator6_ValidatorCalloutExtender" runat="server" TargetControlID="RequiredFieldValidator6">
                                </ajaxToolkit:ValidatorCalloutExtender>
                            </span>
                        </strong>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style22">&nbsp;</td>
                    <td class="auto-style5" style="mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-bidi-font-family: Arial; mso-ansi-language: ES-CO; mso-fareast-language: ES-CO; mso-bidi-language: AR-SA">&nbsp;</td>
                    <td class="auto-style36">
                        <asp:TextBox ID="txtUsuario" runat="server" Width="120px" MaxLength="20" PlaceHolder="        Usuario" AutoCompleteType="Disabled" Enabled="False" Visible="False"></asp:TextBox>
                        <Ajax:BalloonPopupExtender ID="txtUsuario_BalloonPopupExtender" runat="server" BalloonPopupControlID="Panel1" BehaviorID="txtUsuario_BalloonPopupExtender" CustomCssUrl="" DisplayOnFocus="True" DisplayOnMouseOver="True" DynamicServicePath="" ExtenderControlID="" TargetControlID="txtUsuario">
                        </Ajax:BalloonPopupExtender>
                    </td>
                    <td class="auto-style3">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUsuario" ErrorMessage="El Usuario es Requerido" Display="None" Font-Bold="True" ForeColor="Maroon" ValidationGroup="BtnIniciar" Font-Size="Larger"></asp:RequiredFieldValidator>
                        <Ajax:ValidatorCalloutExtender ID="RequiredFieldValidator1_ValidatorCalloutExtender" runat="server" TargetControlID="RequiredFieldValidator1">
                        </Ajax:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style23">&nbsp;</td>
                    <td class="auto-style5" style="mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-bidi-font-family: Arial; mso-ansi-language: ES-CO; mso-fareast-language: ES-CO; mso-bidi-language: AR-SA">&nbsp;</td>
                    <td class="auto-style37">
                        <asp:TextBox ID="txtClave" runat="server" TextMode="Password" Width="120px" PlaceHolder="      Contraseña" AutoCompleteType="Disabled" Enabled="False" Visible="False"></asp:TextBox>
                    </td>
                    <td class="auto-style2">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtClave" Display="None" ErrorMessage="La Clave es Requerida" Font-Bold="True" ForeColor="Maroon" ValidationGroup="BtnIniciar" Font-Size="Larger"></asp:RequiredFieldValidator>
                        <Ajax:ValidatorCalloutExtender ID="RequiredFieldValidator2_ValidatorCalloutExtender" runat="server" BehaviorID="RequiredFieldValidator2_ValidatorCalloutExtender" TargetControlID="RequiredFieldValidator2">
                        </Ajax:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style23">&nbsp;</td>
                    <td class="auto-style5" style="mso-fareast-font-family: Calibri; mso-fareast-theme-font: minor-latin; mso-bidi-font-family: Arial; mso-ansi-language: ES-CO; mso-fareast-language: ES-CO; mso-bidi-language: AR-SA">&nbsp;</td>
                    <td class="auto-style37">
                        <asp:Button ID="BtnIniciar" runat="server" OnClick="BtnIniciar_Click" Text="Iniciar" Width="125px" ValidationGroup="BtnIniciar" Font-Bold="True" Enabled="False" Visible="False" />
                    </td>
                    <td class="auto-style2">&nbsp;</td>
                </tr>
            </table>
            <table align="center" class="auto-style31">
                <tr>
                    <td class="auto-style17">
                        <asp:Label ID="LblError" runat="server" ForeColor="Maroon"></asp:Label>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style12" style="background-color: #3A6600"></td>
                </tr>
                <tr>
                    <td class="auto-style12" style="background-color: #4b6c9e"></td>
                </tr>
                <tr>
                    <td class="auto-style12" style="background-color: #ff6a00"></td>
                </tr>
            </table>

        </div>
        <asp:Panel ID="Panel1" runat="server" Font-Bold="True" Visible="False">
            <span class="auto-style28">Escriba el usuario del </span><span class="auto-style27"><strong>correo, </strong></span><span class="auto-style28">la clave y luego haga click en el botón Iniciar </span>
        </asp:Panel>
        <table class="auto-style29">
            <tr>
                <td colspan="6">
                    <asp:Panel ID="Panel3" runat="server" Font-Names="Arial" Font-Size="11">
                        Escriba el Código de la Imagen y luego haga Click en Aceptar
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="True">
                    </asp:ScriptManager>
                </td>
                <td>
                    <asp:HiddenField ID="hfSgarc" runat="server" />
                </td>
                <td>
                    <asp:HiddenField ID="hfSgPc" runat="server" />
                </td>
                <td>
                    <asp:HiddenField ID="hfSgIn" runat="server" />
                </td>
                <td>
                    <asp:HiddenField ID="hdEsActivo" runat="server" />
                </td>
                <td>
                    <asp:HiddenField ID="hfErrorValidacion" runat="server" Visible="False" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:HiddenField ID="hfNoRespuesta" runat="server" />
                </td>
                <td>
                    <asp:HiddenField ID="hfIpTelefono" runat="server" />
                </td>
                <td>
                    <asp:HiddenField ID="hfCaptcha" runat="server" />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </form>
</body>
</html>
