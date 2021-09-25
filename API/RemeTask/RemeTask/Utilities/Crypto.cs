using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Security.Cryptography;

namespace RemeTask.Utilities
{
    public class Crypto
    {
        public static string GenerateSalt(int saltLength = 32)
        {
            var salt = new byte[saltLength];
            using (var random = new RNGCryptoServiceProvider())
            {
                random.GetNonZeroBytes(salt);
            }
            
            return Convert.ToBase64String(salt);
        }

        public static string Hash(string password)
        {
            HashAlgorithm hashAlgorithm = new SHA256CryptoServiceProvider();

            byte[] byteValue = System.Text.Encoding.UTF8.GetBytes(password);
            byte[] byteHash = hashAlgorithm.ComputeHash(byteValue);
            string hash = Convert.ToBase64String(byteHash);

            return hash;
        }

        public static bool CompareHash(string givenHash, string originalHash)
        {
            return givenHash.Equals(originalHash);
        }
    }
}
