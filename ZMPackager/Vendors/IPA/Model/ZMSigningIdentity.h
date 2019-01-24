//
//  ZMSigningIdentity.h
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/24.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZMProvisioning;
@interface ZMSigningIdentity : NSObject
@property (nonatomic, strong) NSString *commonName;
@property (nonatomic, weak) ZMProvisioning *provision;
@property (nonatomic, strong, readonly) NSData *certificateData;
- (instancetype)initWithProvision:(ZMProvisioning *)provision certificateData:(NSData *)certificateData;
/* Return only valid keychains certificate from Keychains */
+ (NSArray *)keychainsIdenities;
@end
