//
//  ZMProvisioning.m
//  ZMPackager
//
//  Created by Yuri Boyka on 2019/1/24.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMProvisioning.h"
#import "ZMSigningIdentity.h"

@implementation ZMProvisioning
- (instancetype)initWithPath:(NSString *)path
{
    self = [super init];
    if (self)
    {
        self.path = path;
        [self _readProvisioningData];
    }
    return self;
}
- (void)_readProvisioningData
{
    NSData *fileData = [NSData dataWithContentsOfFile:self.path];
    if (!fileData) return;

    NSDictionary *propertyList = nil;
    CMSDecoderRef decoder = NULL;
    @try
    {
        CMSDecoderCreate(&decoder);
        CMSDecoderUpdateMessage(decoder, fileData.bytes, fileData.length);
        CMSDecoderFinalizeMessage(decoder);

        CFDataRef dataRef = NULL;
        CMSDecoderCopyContent(decoder, &dataRef);
        NSData *data = (NSData *)CFBridgingRelease(dataRef);
        propertyList = [NSPropertyListSerialization propertyListWithData:data
                                                                 options:NSPropertyListImmutable
                                                                  format:NULL
                                                                   error:NULL];
    }
    @catch (NSException *exception)
    {
        NSLog(@"Could not decode file.\n");
    }
    @finally
    {
        if (decoder) CFRelease(decoder);
    }

    self.name = propertyList[@"Name"];
    self.teamName = propertyList[@"TeamName"];
    self.expirationDate = propertyList[@"ExpirationDate"];
    self.valid = ([[NSDate date] timeIntervalSinceDate:self.expirationDate] > 0) ? @"NO" : @"YES";
    self.creationDate = propertyList[@"CreationDate"];
    self.debug = [propertyList[@"Entitlements"][@"get-task-allow"] isEqualToNumber:@(1)] ? @"YES" : @"NO";
    self.creationDate = propertyList[@"CreationDate"];
    self.UUID = propertyList[@"UUID"];
    self.timeToLive = [propertyList[@"TimeToLive"] integerValue];

    NSDictionary *Entitlements = propertyList[@"Entitlements"];
    if (Entitlements[@"application-identifier"])
        self.applicationIdentifier = Entitlements[@"application-identifier"];
    else
        self.applicationIdentifier = Entitlements[@"com.apple.application-identifier"];
    self.bundleIdentifier = self.applicationIdentifier;
    self.prefixes = propertyList[@"ApplicationIdentifierPrefix"];
    for (NSString *prefix in self.prefixes)
    {
        NSRange range = [self.bundleIdentifier rangeOfString:prefix];
        if (range.location != NSNotFound)
        {
            self.bundleIdentifier =
                [self.bundleIdentifier stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@.", prefix]
                                                                 withString:@""];
        }
    }
    self.provisionedDevices = propertyList[@"ProvisionedDevices"];
    NSString *appIDPrefix = [propertyList[@"ApplicationIdentifierPrefix"] firstObject];
    if ([self.applicationIdentifier hasPrefix:appIDPrefix])
    {
        self.applicationIdentifier = [self.applicationIdentifier substringFromIndex:appIDPrefix.length + 1];
    }
    self.developerCertificates = propertyList[@"DeveloperCertificates"];
    self.version = [propertyList[@"Version"] integerValue];
    self.appIdName = propertyList[@"AppIDName"];
    self.teamIdentifier = Entitlements[@"com.apple.developer.team-identifier"];
    NSMutableString *platforms = @"".mutableCopy;
    for (NSString *string in propertyList[@"Platform"])
    {
        [platforms appendFormat:@"%@  ", string];
    }
    self.platform = platforms;

    [self _loadSigningIdentities];
}
- (void)_loadSigningIdentities
{
    NSMutableArray *result = [NSMutableArray array];
    for (NSData *certData in self.developerCertificates)
    {
        ZMSigningIdentity *identity = [[ZMSigningIdentity alloc] initWithProvision:self certificateData:certData];
        [result addObject:identity];
    }
    self.signingIdentities = result;
}
- (BOOL)isExpired { return [[NSDate date] compare:self.expirationDate] == NSOrderedDescending; }
@end
