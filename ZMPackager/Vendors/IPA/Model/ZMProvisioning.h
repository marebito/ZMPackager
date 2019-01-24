//
//  ZMProvisioning.h
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/24.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMSigningIdentity.h"

@interface ZMProvisioning : NSObject
- (instancetype)initWithPath:(NSString *)path;

@property(nonatomic, copy) NSString *path;                    // 路径
@property(nonatomic, copy) NSString *name;                    // 授权文件名
@property(nonatomic, copy) NSString *teamName;                // 组织名
@property(nonatomic, copy) NSDate *expirationDate;            // 过期日期
@property(nonatomic, copy) NSString *valid;                   // 有效标识
@property(nonatomic, copy) NSString *debug;                   // 调试标识
@property(nonatomic, copy) NSDate *creationDate;              // 创建日期
@property(nonatomic, copy) NSString *UUID;                    // 授权文件唯一标识
@property(nonatomic, assign) NSInteger timeToLive;            // 剩余时间
@property(nonatomic, copy) NSString *applicationIdentifier;   // 应用标识符
@property(nonatomic, copy) NSString *bundleIdentifier;        // bundle标识
@property(nonatomic, strong) NSArray *prefixes;               // 前缀
@property(nonatomic, strong) NSArray *provisionedDevices;     // 授权设备列表
@property(nonatomic, strong) NSArray *developerCertificates;  // 开发证书
@property(nonatomic, assign) NSInteger version;               // 版本号
@property(nonatomic, copy) NSString *appIdName;               // 应用ID
@property(nonatomic, copy) NSString *teamIdentifier;          // 组织标识
@property(nonatomic, copy) NSString *platform;                // 平台
@property(nonatomic, strong) NSArray *signingIdentities;      // 签名标识

- (BOOL)isExpired;
@end
