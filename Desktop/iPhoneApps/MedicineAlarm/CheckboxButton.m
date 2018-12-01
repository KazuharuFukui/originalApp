//
//  CheckboxButton.m
//  MedicineAlarm
//
//  Created by 福井一玄 on 2015/04/12.
//  Copyright (c) 2015年 kazuharu.fukui. All rights reserved.
//

#import "CheckboxButton.h"



@implementation CheckboxButton

@synthesize checkBoxSelected = _checkBoxSelected;

- (void)awakeFromNib
{
    [super awakeFromNib];
    UIImage* nocheck = [UIImage imageNamed:@"toggle_off.png"];
    UIImage* checked = [UIImage imageNamed:@"toggle_on.png"];
    //UIImage* disable = [UIImage imageNamed:@"disable_check.png"];
    [self setBackgroundImage:nocheck forState:UIControlStateNormal];
    [self setBackgroundImage:checked forState:UIControlStateSelected];
    [self setBackgroundImage:checked forState:UIControlStateHighlighted];
    //[self setBackgroundImage:disable forState:UIControlStateDisabled];
    [self addTarget:self action:@selector(checkboxPush:) forControlEvents:UIControlEventTouchUpInside];
    [self setState:self];
}

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage* nocheck = [UIImage imageNamed:@"nocheck.png"];
        UIImage* checked = [UIImage imageNamed:@"check.png"];
        UIImage* disable = [UIImage imageNamed:@"disable_check.png"];
        [self setBackgroundImage:nocheck forState:UIControlStateNormal];
        [self setBackgroundImage:checked forState:UIControlStateSelected];
        [self setBackgroundImage:checked forState:UIControlStateHighlighted];
        [self setBackgroundImage:disable forState:UIControlStateDisabled];
        [self addTarget:self action:@selector(checkboxPush:) forControlEvents:UIControlEventTouchUpInside];
        [self setState:self];
    }
    return self;
}

- (void)checkboxPush:(CheckboxButton*) button {
    button.checkBoxSelected = !button.checkBoxSelected;
    [button setState:button];
}

- (void)setState:(CheckboxButton*) button
{
    if (button.checkBoxSelected) {
        [button setSelected:YES];
    } else {
        [button setSelected:NO];
    }
}

@end
