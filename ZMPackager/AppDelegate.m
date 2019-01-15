//
//  AppDelegate.m
//  ZMPackager
//
//  Created by Yuri Boyka on 2018/12/27.
//  Copyright © 2018 Yuri Boyka. All rights reserved.
//

#import "AppDelegate.h"
#import "ZMCertificateReader.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSArray *items = [ZMCertificateReader listCertificate];
    NSLog(@"items-->%@", items);
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}

@end
