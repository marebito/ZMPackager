//
//  ZMShellCmd.h
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/4.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#ifndef ZMShellCmd_h
#define ZMShellCmd_h

/**********************************************************************************************************************/
/*                                                  CSR Decoder                                                       */
/*                                                                                                                    */
/*Use this CSR Decoder to decode your Certificate Signing Request and and verify that it contains the correct         */
/*information. A Certificate Signing Request is a block of encoded text that contains information about the company   */
/*that an SSL certificate will be issued to and the SSL public key.Once a CSR is created it is difficult to verify what
/*information is contained in it because it is encoded. Since certificate authorities use the information in CSRs to
/*create the certificate, you need to decode CSRs to make sure the information is accurate. To check CSRs and view the
/*information inside of them, simply paste your CSR into the box below and the AJAX CSR Decoder will do the
/*rest.
/*Your CSR should start with "-----BEGIN CERTIFICATE REQUEST----- " and end with "-----END CERTIFICATE REQUEST----- ".*/
/**********************************************************************************************************************/
//openssl req - in mycsr.csr - noout - text

//Paste Certificate Signing Request (CSR)

#endif /* ZMShellCmd_h */
