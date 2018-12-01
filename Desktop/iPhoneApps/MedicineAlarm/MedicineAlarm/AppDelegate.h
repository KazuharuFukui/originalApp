//
//  AppDelegate.h
//  MedicineAlarm
//
//  Created by 福井一玄 on 2015/04/11.
//  Copyright (c) 2015年 kazuharu.fukui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

#pragma mark property prototype
@property (strong, nonatomic) UIWindow *window;

#pragma mark method prototype
- (void)setIdleTimer:(BOOL)isDisabled;


@end

