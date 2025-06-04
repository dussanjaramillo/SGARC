using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Security;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace WebLiquidador.App_Code
{
    public class Hash_Csharp
    {
        public string EncodePasswordToBase64(string Texto)
        {
            //byte[] bytes = Encoding.Unicode.GetBytes(Texto);
            //byte[] dst = new byte[bytes.Length];
            //byte[] inArray = HashAlgorithm.Create("SHA1").ComputeHash(dst);
            //return Convert.ToBase64String(inArray);

            SHA1 sha1 = new SHA1CryptoServiceProvider();
            byte[] inputBytes = (new UnicodeEncoding()).GetBytes(Texto);
            byte[] hash = sha1.ComputeHash(inputBytes);
            return Convert.ToBase64String(hash);

            //byte[] encData_byte = new byte[Texto.Length];
            //encData_byte = System.Text.Encoding.UTF8.GetBytes(Texto);
            //string encodedData = Convert.ToBase64String(encData_byte);
            //return encodedData;
        }  
    }
}