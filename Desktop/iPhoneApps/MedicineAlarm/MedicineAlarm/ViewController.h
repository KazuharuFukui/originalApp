//
//  ViewController.h
//  MedicineAlarm
//
//  Created by 福井一玄 on 2015/04/11.
//  Copyright (c) 2015年 kazuharu.fukui. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController
{
    UILabel *lb;
    UITextField *tf;
}

@property (nonatomic, retain) IBOutlet UILabel *lb;
@property (nonatomic, retain) IBOutlet UITextField *tf;

- (IBAction)TextSet:(id)sender;


#define ALARM_NAME                   @"bell"
#define ALARM_FILE_EXT               @"mp3"

@end

