//
//  ZMProvisionInfo.m
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/4.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMProvisionInfo.h"

@implementation ZMEntitilements
+ (ZMEntitilements *)entitilementsWithDic:(NSDictionary *)dic
{
    ZMEntitilements *entitilements = [ZMEntitilements new];
    entitilements.application_identifier = dic[@"application_identifier"];
    entitilements.aps_environment = dic[@"aps-environment"];
    entitilements.team_identifier = dic[@"com.apple.developer.team-identifier"];
    entitilements.get_task_allow = [dic[@"get-task-allow"] boolValue];
    entitilements.keychain_access_groups = dic[@"keychain-access-groups"];
    return entitilements;
}
- (NSString *)debugDescription { return [super debugDescription]; }
@end

@implementation ZMProvisionedDevice
+ (NSArray *)provisionedDevicesWithIdentifiers:(NSArray *)identifiers
{
    __block NSMutableArray *devices = [NSMutableArray new];
    [identifiers enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        ZMProvisionedDevice *device = [ZMProvisionedDevice new];
        device.identifier = obj;
        [devices addObject:device];
    }];
    return devices;
}
- (NSString *)debugDescription { return [super debugDescription]; }
@end

@implementation ZMProvisionInfo

+ (ZMProvisionInfo *)provisionInfoWithDic:(NSDictionary *)dic
{
    ZMProvisionInfo *provisionInfo = [ZMProvisionInfo new];
    provisionInfo.AppIDName = dic[@"AppIDName"];
    provisionInfo.ApplicationIdentifierPrefix = dic[@"ApplicationIdentifierPrefix"];
    provisionInfo.CreationDate = dic[@"CreationDate"];
    provisionInfo.DeveloperCertificates = dic[@"DeveloperCertificates"];
    provisionInfo.Entitlements = [ZMEntitilements entitilementsWithDic:dic];
    provisionInfo.ExpirationDate = dic[@"ExpirationDate"];
    provisionInfo.IsXcodeManaged = [dic[@"IsXcodeManaged"] boolValue];
    provisionInfo.Name = dic[@"Name"];
    provisionInfo.Platform = dic[@"Platform"];
    provisionInfo.ProvisionedDevices =
        [ZMProvisionedDevice provisionedDevicesWithIdentifiers:dic[@"ProvisionedDevices"]];
    provisionInfo.TeamIdentifier = dic[@"TeamIdentifier"];
    provisionInfo.TeamName = dic[@"TeamName"];
    provisionInfo.TimeToLive = dic[@"TimeToLive"];
    provisionInfo.UUID = dic[@"UUID"];
    provisionInfo.Version = [dic[@"Version"] integerValue];
    return provisionInfo;
}

- (NSString *)description { return [super description]; }
- (NSString *)debugDescription { return [super debugDescription]; }
@end
