//
//  ZMOperationQueue.m
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/7.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMOperation.h"
#import "ZMShellCommander.h"

@implementation ZMTask

@end

@implementation ZMOperation

- (void)main
{
    NSString *result = [ZMShellCommander runCommand:self.task.shellCmd];
    if (self.task) {
        self.task.taskComplete(nil != result, result);
    }
}

- (id)initWithTask:(ZMTask *)task_
{
    self = [super init];
    if (self)
    {
        self.task = task_;
    }
    return self;
}

@end
