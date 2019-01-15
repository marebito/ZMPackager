//
//  ZMTaskManager.h
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/7.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMObject.h"
#import "ZMOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZMTaskManager : ZMObject
+ (ZMTaskManager *)defaultManager;
- (void)addTask:(ZMTask *)task;
@end

NS_ASSUME_NONNULL_END
