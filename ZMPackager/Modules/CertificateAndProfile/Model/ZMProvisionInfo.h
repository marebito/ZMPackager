//
//  ZMProvisionInfo.h
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/4.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZMEntitilements : ZMObject
@property(nonatomic, strong) NSArray<NSString *> *keychain_access_groups;
@property(nonatomic, assign) BOOL get_task_allow;
@property(nonatomic, copy) NSString *application_identifier;
@property(nonatomic, copy) NSString *team_identifier;
@property(nonatomic, copy) NSString *aps_environment;
+ (ZMEntitilements *)entitilementsWithDic:(NSDictionary *)dic;
@end

@interface ZMProvisionedDevice : ZMObject
@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *name;
+ (NSArray *)provisionedDevicesWithIdentifiers:(NSArray *)identifiers;
@end

@interface ZMProvisionInfo : ZMObject
@property(nonatomic, copy) NSString *AppIDName;
@property(nonatomic, strong) NSArray<NSString *> *ApplicationIdentifierPrefix;
@property(nonatomic, strong) NSDate *CreationDate;
@property(nonatomic, strong) NSArray<NSString *> *Platform;
@property(nonatomic, assign) BOOL IsXcodeManaged;
@property(nonatomic, strong) NSArray<NSData *> *DeveloperCertificates;
@property(nonatomic, strong) ZMEntitilements *Entitlements;
@property(nonatomic, copy) NSString *ExpirationDate;
@property(nonatomic, copy) NSString *Name;
@property(nonatomic, strong) NSArray<ZMProvisionedDevice *> *ProvisionedDevices;
@property(nonatomic, strong) NSArray<NSString *> *TeamIdentifier;
@property(nonatomic, copy) NSString *TeamName;
@property(nonatomic, copy) NSString *TimeToLive;
@property(nonatomic, copy) NSString *UUID;
@property(nonatomic, assign) NSInteger Version;
+ (ZMProvisionInfo *)provisionInfoWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
