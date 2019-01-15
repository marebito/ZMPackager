//
//  ZMCertificateReader.m
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/4.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMCertificateReader.h"

#define ZMStatusLog(STATUS, FUNCNAME)                                              \
    do                                                                             \
    {                                                                              \
        CFStringRef errorMessage;                                                  \
        errorMessage = SecCopyErrorMessageString(STATUS, NULL);                    \
        NSLog(@"error after %@: %@", FUNCNAME, (__bridge NSString *)errorMessage); \
        CFRelease(errorMessage);                                                   \
    } while (0)

@implementation ZMCertificateValue
+ (ZMCertificateValue *)certValueWithCertDic:(NSDictionary *)dic
{
    ZMCertificateValue *certVal = [ZMCertificateValue new];
    certVal.label = dic[@"label"];
    certVal.localized_label = dic[@"localized label"];
    certVal.type = dic[@"type"];
    if ([certVal.type isEqualToString:@"section"])
    {
        NSMutableArray *array = [NSMutableArray new];
        [dic[@"value"] enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            [array addObject:[ZMCertificateValue certValueWithCertDic:obj]];
        }];
        certVal.value = array;
    }
    else
    {
        certVal.value = dic[@"value"];
    }
    return certVal;
}

- (NSString *)description { return [super description]; }
- (NSString *)debugDescription { return [super debugDescription]; }
@end

@implementation ZMCertificateObject

+ (NSArray *)certObjectWithCertVal:(NSDictionary *)val;
{
    NSMutableArray *certArray = [NSMutableArray new];
    [val enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL *_Nonnull stop) {
        ZMCertificateObject *certObj = [ZMCertificateObject new];
        certObj.key = key;
        certObj.value = [ZMCertificateValue certValueWithCertDic:obj];
        [certArray addObject:certObj];
    }];
    return [NSArray arrayWithArray:certArray];
}

- (NSString *)debugDescription { return [super debugDescription]; }
@end

@implementation ZMCertificateDescriptor

+ (ZMCertificateDescriptor *)descriptorWithCertificate:(SecCertificateRef)cert
{
    ZMCertificateDescriptor *descriptor = [ZMCertificateDescriptor new];
    CFErrorRef error = NULL;
    CFDataRef serialNumber = NULL;
    CFStringRef commonName = NULL;
    CFArrayRef emailAddresses = NULL;
    CFDataRef publicKeyRef = NULL;
    CFStringRef certLongDesc = NULL;
    CFStringRef certShortDesc = NULL;
    descriptor.typeId = SecCertificateGetTypeID();
    // 返回一个简单的字符串，代表人类易于理解的摘要
    CFStringRef subjectSummary = SecCertificateCopySubjectSummary(cert);
    descriptor.subjectSummary = (__bridge NSString * _Nonnull)(subjectSummary);
    // 检索给定证书主题的通用名称
    SecCertificateCopyCommonName(cert, &commonName);
    descriptor.commonName = (__bridge NSString * _Nonnull)(commonName);
    // 给定证书主题的零个或多个电子邮件地址的数组
    SecCertificateCopyEmailAddresses(cert, &emailAddresses);
    descriptor.emailAddresses = (__bridge NSArray * _Nonnull)(emailAddresses);
    // 证书的规范化颁发者
    descriptor.normalizedIssuer = (__bridge NSData * _Nonnull)(SecCertificateCopyNormalizedIssuerSequence(cert));
    // 证书的规范化主题
    descriptor.normalizedSubject = (__bridge NSData * _Nonnull)(SecCertificateCopyNormalizedSubjectSequence(cert));
    // 证书的公钥
#if TARGET_OS_IPHONE
    if (@available(iOS 12.0, *))
    {
        publicKeyRef =
            SecKeyCopyExternalRepresentation(SecCertificateCopyKey(cert), &error);
    }
    else if((@available(iOS 10.3, *))
    {
        publicKeyRef = SecKeyCopyExternalRepresentation(SecCertificateCopyPublicKey(cert), &error);
    }
#else
    publicKeyRef = SecKeyCopyExternalRepresentation(SecCertificateCopyKey(cert), &error);
#endif
    descriptor.publicKey = (__bridge NSData * _Nonnull)(publicKeyRef);

// 证书序列号
#if TARGET_OS_IPHONE
        if (@available(iOS 11.0, *))
        {
        serialNumber = SecCertificateCopySerialNumberData(cert, &error);
        }
        else if((@available(iOS 10.3, *))
        {
        serialNumber = SecCertificateCopySerialNumber(cert, &error);
        }
#else
        serialNumber = SecCertificateCopySerialNumberData(cert, &error);
#endif
            if (!error)
            {
        descriptor.serialNumber = (__bridge NSData * _Nonnull)(serialNumber);
            }
            else
            {
        NSLog(@"[获取证书序列号失败]:%@", error);
            }
            // 证书内容的字典
            CFDictionaryRef dicRef = SecCertificateCopyValues(cert, NULL, &error);
            if (!error)
            {
        NSDictionary *dic = (__bridge_transfer NSDictionary *)dicRef;
        descriptor.certContent = [ZMCertificateObject certObjectWithCertVal:dic];
            }
            else
            {
        NSLog(@"[获取证书内容失败]:%@", error);
            }
#if TARGET_OS_OSX
                    // 证书的长描述
                    certLongDesc = SecCertificateCopyLongDescription(kCFAllocatorDefault, cert, &error);
                    if (!error)
                    {
        descriptor.certLongDesc = (__bridge NSString * _Nonnull)(certLongDesc);
                    }
                    else
                    {
        NSLog(@"[获取证书长描述失败]:%@", error);
                    }
                    // 证书的短描述
                    certShortDesc = SecCertificateCopyShortDescription(kCFAllocatorDefault, cert, &error);
                    if (!error)
                    {
        descriptor.certShortDesc = (__bridge NSString * _Nonnull)(certShortDesc);
                    }
                    else
                    {
        NSLog(@"[获取证书短描述失败]:%@", error);
                    }
#endif
                    return descriptor;
}

- (NSString *)description { return [super description]; }
@end

@implementation ZMCertificateReader

+ (NSArray *)listCertificate
{
    __block NSMutableArray *certDescriptors = [NSMutableArray new];
    NSMutableDictionary *query = [NSMutableDictionary
        dictionaryWithObjectsAndKeys:(__bridge NSString *)kSecClassCertificate, kSecClass, (__bridge id)kCFBooleanTrue,
                                     (__bridge id)kSecReturnRef, (__bridge id)kSecMatchLimitAll,
                                     (__bridge id)kSecMatchLimit, nil];

    NSArray *secItemClasses = [NSArray arrayWithObjects:
                                           //                               (__bridge id)kSecClassGenericPassword,
                                           //                               (__bridge id)kSecClassInternetPassword,
                                           (__bridge id)kSecClassCertificate,
                                           //                               (__bridge id)kSecClassKey,
                                           //                               (__bridge id)kSecClassIdentity,
                                           nil];

    for (id secItemClass in secItemClasses)
    {
        [query setObject:secItemClass forKey:(__bridge id)kSecClass];

        CFTypeRef result = NULL;
        SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
        OSStatus status = SecItemCopyMatching((CFDictionaryRef)query, &result);
        if (status)
        {
            if (status != errSecItemNotFound) ZMStatusLog(status, @"SecItemCopyMatching");
            continue;
        }
        [(__bridge id)result enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            [certDescriptors addObject:[ZMCertificateDescriptor descriptorWithCertificate:(SecCertificateRef)obj]];
        }];
        if (result != NULL) CFRelease(result);
    }
    return [NSArray arrayWithArray:certDescriptors];
}

@end
