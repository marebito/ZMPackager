#import <Foundation/Foundation.h>

@interface NSDate(Relative)
- (NSString *)relativeTime;
+ (NSString *)relativeTime:(NSDate *)aDate;
@end
