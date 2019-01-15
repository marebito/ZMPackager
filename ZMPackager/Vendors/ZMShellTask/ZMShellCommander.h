//
//  ZMShellCommander.h
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/7.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMShellCommander : NSObject
+ (NSString *)runCommand:(NSString *)commandToRun;
@end

NS_ASSUME_NONNULL_END
