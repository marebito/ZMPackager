//
//  ZMCertificateReader.m
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/4.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMCertificateReader.h"
#import <Security/Security.h>

#define ZMStatusLog(STATUS, FUNCNAME)                                              \
    do                                                                             \
    {                                                                              \
        CFStringRef errorMessage;                                                  \
        errorMessage = SecCopyErrorMessageString(STATUS, NULL);                    \
        NSLog(@"error after %@: %@", FUNCNAME, (__bridge NSString *)errorMessage); \
        CFRelease(errorMessage);                                                   \
    } while (0)

@implementation ZMCertificateReader

+ (NSArray *)listCertificate
{
    /*
    SecKeychainRef keychain = NULL;
    NSDictionary *query = [NSDictionary
        dictionaryWithObjectsAndKeys:(__bridge NSString *)kSecClassCertificate, kSecClass,
                                     [NSArray arrayWithObject:(__bridge id)keychain], kSecMatchSearchList,
                                     kCFBooleanTrue, kSecReturnRef, kSecMatchLimitAll, kSecMatchLimit, nil];
    CFTypeRef typeRef = NULL;
    CFGetTypeID(&typeRef);
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)query, &typeRef);
    if (status)
    {
        if (status != errSecItemNotFound) ZMStatusLog(status, @"SecItemCopyMatching");
        return nil;
    }
    return (__bridge NSArray *)(typeRef);
*/
    NSMutableDictionary *query = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  (__bridge NSString *)kSecClassCertificate, kSecClass,
                                  (__bridge id)kCFBooleanTrue, (__bridge id)kSecReturnRef,
                                  (__bridge id)kSecMatchTrustedOnly, (__bridge id)kSecMatchLimit,
                                  nil];
    
    NSArray *secItemClasses = [NSArray arrayWithObjects:
                               (__bridge id)kSecClassGenericPassword,
                               (__bridge id)kSecClassInternetPassword,
                               (__bridge id)kSecClassCertificate,
                               (__bridge id)kSecClassKey,
                               (__bridge id)kSecClassIdentity,
                               nil];
    
    for (id secItemClass in secItemClasses) {
        [query setObject:secItemClass forKey:(__bridge id)kSecClass];
        
        CFTypeRef result = NULL;
        SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
        OSStatus status = SecItemCopyMatching((CFDictionaryRef)query, &result);
        if (status)
        {
            if (status != errSecItemNotFound) ZMStatusLog(status, @"SecItemCopyMatching");
            continue;
        }
        NSLog(@"%@", (__bridge id)result);
        if (result != NULL) CFRelease(result);
    }
    return nil;
}

@end
