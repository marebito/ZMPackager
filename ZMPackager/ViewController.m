//
//  ViewController.m
//  ZMPackager
//
//  Created by Yuri Boyka on 2018/12/27.
//  Copyright © 2018 Yuri Boyka. All rights reserved.
//

#import "ViewController.h"
#import "ZMProvisionReader.h"

#define WWDRCA @"https://developer.apple.com/certificationauthority/AppleWWDRCA.cer"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 跳转Finder [[NSWorkspace sharedWorkspace] activateFileViewerSelectingURLs:urls];
    [ZMProvisionReader listMobileProvisionProfiles:^(NSArray * _Nonnull provisions) {
        NSLog(@"provisions-->%@", provisions);
    }];
}

- (void)setRepresentedObject:(id)representedObject { [super setRepresentedObject:representedObject]; }
@end
