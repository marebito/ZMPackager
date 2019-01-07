//
//  ZMShellCommander.m
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/7.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMShellCommander.h"

@implementation ZMShellCommander
+ (NSString *)runCommand:(NSString *)commandToRun
{
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/sh"];

    NSArray *arguments = [NSArray arrayWithObjects:@"-c", [NSString stringWithFormat:@"%@", commandToRun], nil];
    NSLog(@"run command:%@", commandToRun);
    [task setArguments:arguments];

    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];

    NSFileHandle *file = [pipe fileHandleForReading];

    [task launch];

    NSData *data = [file readDataToEndOfFile];

    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return output;
}
@end
