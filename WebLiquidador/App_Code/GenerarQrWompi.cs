using System.IO;
using System.Drawing;
using MessagingToolkit.QRCode.Codec;


namespace WebLiquidador.App_Code
{
    public class GenerarQrWompi
    {
        public string Qr(string CodigoCentroFormacion, string Datos, string Path)
        {
            QRCodeEncoder encoder = new QRCodeEncoder();
            Bitmap img = encoder.Encode(Datos);
            System.Drawing.Image QR = (System.Drawing.Image)img;

            using (MemoryStream ms = new MemoryStream())
            {
                QR.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                byte[] imageBytes = ms.ToArray();
                ms.Position = 0;
                System.IO.File.WriteAllBytes(@Path + CodigoCentroFormacion.ToString() + ".jpg", ms.ToArray());
            }

            return "1";
        }
    }
}