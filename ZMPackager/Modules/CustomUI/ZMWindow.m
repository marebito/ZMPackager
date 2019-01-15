//
//  ZMWindow.m
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/15.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMWindow.h"

@implementation ZMWindow

- (instancetype)initWithContentRect:(NSRect)contentRect
                          styleMask:(NSWindowStyleMask)style
                            backing:(NSBackingStoreType)backingStoreType
                              defer:(BOOL)flag
{
    if (self = [super initWithContentRect:contentRect styleMask:style backing:backingStoreType defer:flag])
    {
        self.movableByWindowBackground = YES;
        //        self.styleMask = NSWindowStyleMaskFullSizeContentView|NSWindowStyleMaskTitled| NSPopUpMenuWindowLevel;
        self.styleMask = NSPopUpMenuWindowLevel;
//        self.titlebarAppearsTransparent = YES;
    }
    return self;
}

@end
