//
//  ZMRenewal.h
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/4.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/****************************************************/
/* 续  订(https://support.apple.com/zh-cn/HT204446) */
/****************************************************/
// 续 订
#define ZMRenewalCMD(profileIdentifier) [NSString stringWithFormat:@"profiles -W -p %@", profileIdentifier]

/**
 设置更新天数

 @param day 天数
 @return >14或小于证书有效期的天数
 */
#define ZMRenewalIntervalCMD(day)                                                                                   \
    [NSString                                                                                                       \
        stringWithFormat:                                                                                           \
            @"sudo defaults write /Library/Preferences/com.apple.mdmclient CertificateRenewalTimeInterval -int %d", \
            day]

/**
 设置更新百分比

 @param percent 天数
 @return 1~50之间整数
 */
#define ZMRenewalPercentCMD(day)                                                                                   \
    [NSString                                                                                                      \
        stringWithFormat:                                                                                          \
            @"sudo defaults write /Library/Preferences/com.apple.mdmclient CertificateRenewalTimePercent -int %d", \
            day]

@interface ZMRenewal : NSObject

@end

NS_ASSUME_NONNULL_END
