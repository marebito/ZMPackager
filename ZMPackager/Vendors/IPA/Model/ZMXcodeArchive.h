//
//  ZMXcodeArchive.h
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/24.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMXcodeArchive : NSObject
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *bundleID;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSArray *iconPaths;
@property (nonatomic, assign) BOOL isValidArchive;
@property (nonatomic, assign) BOOL isIOSArchive;

@property (nonatomic, strong) NSImage *applicationIcon;
@property (nonatomic, strong) NSString *applicationName;
@property (nonatomic, strong) NSString *absoluteApplicationPath;
- (instancetype)initWithPath:(NSString *)path;
@end
