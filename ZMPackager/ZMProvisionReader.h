//
//  ZMProvisionReader.h
//  ZMPackager
//  读取ProvisionProfile
//  Created by Yuri Boyka on 2019/1/4.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PROVISION_PROFILE_PATH @"~/Library/MobileDevice/Provisioning\ Profiles"

#define PROVISION_READ_CMD @"security cms -D -i ";

NS_ASSUME_NONNULL_BEGIN

@interface ZMProvisionReader : NSObject

@end

NS_ASSUME_NONNULL_END
