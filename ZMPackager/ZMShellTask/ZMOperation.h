//
//  ZMOperationQueue.h
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/7.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZMTask : ZMObject

@property(nonatomic, copy) NSString *shellCmd;

@property(nonatomic, copy) void (^taskComplete)(BOOL result, id data);

@end

@interface ZMOperation : NSOperation

@property(nonatomic, strong) ZMTask *task;

- (id)initWithTask:(ZMTask *)task_;

@end

NS_ASSUME_NONNULL_END
