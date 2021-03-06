//
//  ZMProvisionReader.m
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/4.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMProvisionReader.h"
#import "ZMShellCommander.h"
#import "ZMProvisionInfo.h"
#import "ZMTaskManager.h"

@implementation ZMProvisionReader

+ (void)listMobileProvisionProfiles:(void (^)(NSArray *provisions))callback
{
    NSMutableArray *array = [NSMutableArray new];
    NSString *homeDir =
        [[ZMShellCommander runCommand:@"echo $HOME"] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *mobileProvisionDir =
        [homeDir stringByAppendingPathComponent:@"/Library/MobileDevice/Provisioning Profiles"];
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:homeDir];
    NSArray *provisionFiles = nil;
    if (isExist)
    {
        provisionFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:mobileProvisionDir error:nil];
    }
    [provisionFiles enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj isEqual:@".DS_Store"]) return;
        NSString *provisionPath =
            [[NSString stringWithFormat:@"%@/%@", mobileProvisionDir, obj] stringByReplacingOccurrencesOfString:@" "
                                                                                                     withString:@"\\ "];
        NSString *provisionCmd = [NSString stringWithFormat:@"%@%@", PROVISION_READ_CMD, provisionPath];
        ZMTask *task = [[ZMTask alloc] init];
        task.shellCmd = provisionCmd;
        task.taskComplete = ^(BOOL result, id  _Nonnull data) {
            if (!result) return;
            NSData *plistData = [data dataUsingEncoding:NSUTF8StringEncoding];
            NSString *error;
            NSPropertyListFormat format;
            NSDictionary *provisionDic = [NSPropertyListSerialization propertyListWithData:plistData
                                                                                   options:NSPropertyListImmutable
                                                                                    format:&format
                                                                                     error:nil];
            if (provisionDic)
            {
                ZMProvisionInfo *info = [ZMProvisionInfo provisionInfoWithDic:provisionDic];
                [array addObject:info];
                if (callback && array.count == provisionFiles.count) {
                    callback(array);
                }
            }
            else
            {
                NSLog(@"Error: %@", error);
            }
        };
        [[ZMTaskManager defaultManager] addTask:task];
    }];
}

@end
