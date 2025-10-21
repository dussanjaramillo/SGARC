using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Threading;
using System.Security.Cryptography;
using System.Configuration;
using System.IO;

namespace WebLiquidador.App_Code
{
    public class EnviarCorreo
    {
        public MailMessage oEnviarCorreo(string correoA, string conCopia, string mensaje, string asunto, bool importante, string attachmentFilename)
        {
            MailMessage mail = new MailMessage();
            try
            {
                SmtpClient SmtpServer = new SmtpClient(ConfigurationManager.AppSettings["SmtpServer"].ToString());
                SmtpServer.UseDefaultCredentials = false;
                mail.From = new MailAddress(ConfigurationManager.AppSettings["CorreoAdministrador"].ToString());
                mail.To.Add(correoA);
                mail.Subject = asunto;
                string[] copias = conCopia.Split(Convert.ToChar(";"));

                foreach (string copia in copias)
                    mail.CC.Add(copia);

                mail.Body = mensaje;
                mail.IsBodyHtml = true;
                mail.Priority = importante ? MailPriority.High : MailPriority.Normal;

                if (attachmentFilename != null)
                    mail.Attachments.Add(new Attachment(attachmentFilename));

                SmtpServer.Port = Convert.ToInt32(ConfigurationManager.AppSettings["PuertoCorreo"].ToString());
                SmtpServer.DeliveryMethod = SmtpDeliveryMethod.Network;
                SmtpServer.EnableSsl = false;
                SmtpServer.Send(mail);

            }
            catch (Exception ex)
            {
                string cad = ex.ToString();
                return null;
            }
            return mail;

        }
    }
}