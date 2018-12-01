//
//  ViewController.m
//  MedicineAlarm
//
//  Created by 福井一玄 on 2015/04/11.
//  Copyright (c) 2015年 kazuharu.fukui. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

@synthesize lb, tf;

- (void)dealloc {
    //[lb release];
    //[tf release];
    //[super dealloc];
}

- (IBAction)TextSet:(id)sender{
    
    //テキスト編集が完了し、フォーカスが外れたらラベルに表示する
    lb.text = tf.text;
    
}

//UITextFieldのデリゲートメソッドを追加
//イベントが発生した場合に呼ばれます

//テキストフィールドを編集する直前に呼び出されます
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    return YES;  //これをNOにすると、キーボードが出ません
}


//テキストフィールドを編集する直後に呼び出されます
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
}


//Returnボタンがタップされた時に呼び出されます
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *retStr;
    retStr=tf.text;  //テキストを受け取って
    NSLog(retStr);  //コンソールに表示
    
    //「resignFirstResponder」はユーザーのアクションに対して
    //最初に応答するオブジェクトを放棄するという命令なので
    //「tf」が放棄されて、キーボードも消えます
    [tf resignFirstResponder];
    return YES;
}


//テキストフィールドの編集が終了する直前に呼び出されます
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldEndEditing");
    return YES;  //これをNOにすると、キーボードが消えません
}


//テキストフィールドの編集が終了する直後に呼び出されます
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");
}




@end
