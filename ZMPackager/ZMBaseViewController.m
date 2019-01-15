//
//  ZMBaseViewController.m
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/4.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMBaseViewController.h"

@implementation ZMBaseViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        NSWindow *window = self.view.window;
        // 设置拖动窗口移动
        window.movableByWindowBackground = YES;
        // 隐藏titlebar
        window.titlebarAppearsTransparent=YES;
        window.titleVisibility = NSWindowTitleHidden;
    }
    return self;
}

- (instancetype)initWithNibName:(NSNibName)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSWindow *window = self.view.window;
        // 设置拖动窗口移动
        window.movableByWindowBackground = YES;
        // 隐藏titlebar
        window.titlebarAppearsTransparent=YES;
        window.titleVisibility = NSWindowTitleHidden;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSWindow *window = self.view.window;
        // 设置拖动窗口移动
        window.movableByWindowBackground = YES;
        // 隐藏titlebar
        window.titlebarAppearsTransparent=YES;
        window.titleVisibility = NSWindowTitleHidden;
    }
    return self;
}

- (void)viewDidLoad
{
    
}

@end
