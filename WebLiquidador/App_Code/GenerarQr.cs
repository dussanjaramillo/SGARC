using System.IO;
using System.Drawing;
using MessagingToolkit.QRCode.Codec;


namespace WebLiquidador.App_Code
{
    public class GenerarQr
    {
        public string Qr(string Numerofactura, string Datos)
        {
            foreach (var item in Directory.GetFiles("C:/inetpub/wwwroot/WebLiquidador/Paginas/ProduccionCentros/PagosPorCorreo/Qr/", "*.*"))
            {
                File.SetAttributes(item, FileAttributes.Normal);
                File.Delete(item);
            }

            QRCodeEncoder encoder = new QRCodeEncoder();
            Bitmap img = encoder.Encode(Datos);
            System.Drawing.Image QR = (System.Drawing.Image)img;

            using (MemoryStream ms = new MemoryStream())
            {
                QR.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                byte[] imageBytes = ms.ToArray();
                //imgCtrl.Src = "data:image/gif;base64," + Convert.ToBase64String(imageBytes);
                //imgCtrl.Height = 200;
                //imgCtrl.Width = 200;
                ms.Position = 0;
                System.IO.File.WriteAllBytes(@"C:/inetpub/wwwroot/WebLiquidador/Paginas/ProduccionCentros/PagosPorCorreo/Qr/" + Numerofactura.ToString() + ".jpg", ms.ToArray());
            }

            return "1";
        }
    }
}