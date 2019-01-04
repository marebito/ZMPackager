//
//  ZMCertificateReader.h
//  ZMPackager
//  读取证书
//  Created by Yuri Boyka on 2019/1/4.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMCertificateReader : NSObject

+ (NSArray *)listCertificate;

@end

NS_ASSUME_NONNULL_END
