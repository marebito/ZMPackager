//
//  ZMCertificateReader.h
//  ZMPackager
//  读取证书
//  Created by Yuri Boyka on 2019/1/4.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import "ZMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZMCertificateValue : ZMObject
@property(nonatomic, copy) NSString *label;
@property(nonatomic, copy) NSString *localized_label;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) id value;
+ (ZMCertificateValue *)certValueWithCertDic:(NSDictionary *)dic;
@end

@interface ZMCertificateObject : ZMObject
@property(nonatomic, copy) NSString *key;
@property(nonatomic, strong) ZMCertificateValue *value;
+ (NSMutableArray *)certObjectWithCertVal:(NSDictionary *)val;
@end

@interface ZMCertificateDescriptor : ZMObject
@property(nonatomic, assign) unsigned long typeId;                         // 证书类型标识符
@property(nonatomic, copy) NSString *subjectSummary;                       // 证书摘要
@property(nonatomic, copy) NSString *commonName;                           // 证书主题的通用名称
@property(nonatomic, strong) NSArray *emailAddresses;                      // 证书的电子邮件地址
@property(nonatomic, strong) NSData *normalizedIssuer;                     // 规范化颁发者
@property(nonatomic, strong) NSData *normalizedSubject;                    // 规范化主题
@property(nonatomic, assign) NSData *publicKey;                            // 证书公钥
@property(nonatomic, strong) NSData *serialNumber;                         // 证书序列号
@property(nonatomic, copy) NSString *certLongDesc;                         // 证书长描述
@property(nonatomic, copy) NSString *certShortDesc;                        // 证书短描述
@property(nonatomic, strong) NSArray<ZMCertificateObject *> *certContent;  // 证书详细内容
+ (ZMCertificateDescriptor *)descriptorWithCertificate:(SecCertificateRef)cert;
@end

@interface ZMCertificateReader : ZMObject
+ (NSArray *)listCertificate;
@end

NS_ASSUME_NONNULL_END
