## Traverse All Certificates On Your Mac

1. At the command line, I think you could do security find-certificate -a -p 
2. split up the returned PEM-encoded certificates to feed them to openssl x509 -inform PEM .... one by one.
3. openssl x509 -in certificate.crt -text -noout
4. In code, you can enumerate certificates using SecItemCopyMatching with kSecClass=kSecClassCertificate and kSecMatchLimit=kSecMatchLimitAll. You might be able to get the certificate's expiration date using SecCertificateCopyValues(), but if not, you could get the certificate itself (as a DER-encoded blob) using SecCertificateCopyData() and pipe it to openssl x509 -inform DER .....

## Always Trust the Specific Certificates

sudo security add-trusted-cert -d -r trustAsRoot -p [option] -k /Library/Keychains/System.keychain <certificate>

The -p option may be what you need. It can be specified more than once for each of the settings. I wish I knew how to deny one specific item while trusting another all in the same line. **-p** options are *ssl, smime, codeSign, IPSec, iChat, basic, swUpdate, pkgSign, pkinitClient, pkinitServer, timestamping, eap*

**Example:** sudo security add-trusted-cert -d -r trustAsRoot -k /Library/Keychains/System.keychain <certfile>

## Listing Root Certificates

sudo security dump-keychain /System/Library/Keychains/SystemRootCertificates.keychain

## Delete Certificates

Look in the dump for names or SHA-1 hash values of certificates that you want to get rid of:

Usage: delete-certificate [-c name] [-Z hash] [-t] [keychain...]

-c  Specify certificate to delete by its common name
-Z  Specify certificate to delete by its SHA-1 hash value
-t  Also delete user trust settings for this certificate The certificate to be deleted 

must be uniquely specified either by a string found in its common name, or by its SHA-1 hash. If no keychains are specified to search, the default search list is used.

**Example:** sudo security delete-certificate -Z 8BAF4C9B1DF02A92F7DA128EB91BACF498604B6F /System/Library/Keychains/SystemRootCertificates.keychain
