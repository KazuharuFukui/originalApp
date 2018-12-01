#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DCUtil : NSObject

#pragma mark public method

+ (void)setIdleTimerDisabled:(BOOL)isDisabled;
+ (void)socialShare:(id)delegate shareText:(NSString *)shareText shareImage:(UIImage *)shareImage;
+ (void)copyToPasteBoard:(NSString *)copyText;
+ (void)openUrl:(NSString *)url;
+ (void)showAlert:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;
+ (NSString *)getStrFromPlist:(NSString *)key;

@end
