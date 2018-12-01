#import <UIKit/UIKit.h>

@interface DCButton : UIButton

+ (UIButton *)planeButton:(CGRect)frame text:(NSString *)text delegate:(id)delegate action:(SEL)action tag:(NSInteger)tag;
+ (UIButton *)imageButton:(CGRect)frame img:(UIImage *)img isHighlighte:(BOOL)isHighlighte on_img:(UIImage *)on_img delegate:(id)delegate action:(SEL)action tag:(NSInteger)tag;

@end
