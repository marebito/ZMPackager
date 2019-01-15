//
//  ZMTaskManager.m
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/7.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMTaskManager.h"

@interface ZMTaskManager ()
@property(nonatomic, strong) NSOperationQueue *taskQueue;
@end

@implementation ZMTaskManager

+ (ZMTaskManager *)defaultManager
{
    static dispatch_once_t onceToken;
    static ZMTaskManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[ZMTaskManager alloc] init];
    });
    return manager;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _taskQueue = [[NSOperationQueue alloc] init];
        _taskQueue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (void)addTask:(ZMTask *)task
{
    ZMOperation *operation = [[ZMOperation alloc] initWithTask:task];
    [_taskQueue addOperation:operation];
}

- (void)setMaxConcurrentOperationCount:(int)max { _taskQueue.maxConcurrentOperationCount = max; }
- (void)dealloc { _taskQueue = nil; }
@end
