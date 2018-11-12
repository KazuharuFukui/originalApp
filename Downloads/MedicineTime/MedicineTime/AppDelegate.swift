//
//  AppDelegate.swift
//  MedicineTime
//
//  Created by 伊藤慶 on 2018/09/11.
//  Copyright © 2018年 伊藤慶. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import AVFoundation
import MessageUI
import Firebase
import Fabric
import Answers
//import Answers
import TwitterKit
import TwitterCore
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,AVAudioPlayerDelegate,MFMailComposeViewControllerDelegate {
   
    
    var window: UIWindow?
    //    let date = Date()
    let defaults = UserDefaults.standard
    var viewController: ViewController!
    var launchOption:NSDictionary!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        Fabric.with([Crashlytics.self])
        Fabric.with([Answers.self])
        FirebaseApp.configure()
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(time)" as NSObject,
            //            AnalyticsParameterItemName: time as NSObject,
            AnalyticsParameterContentType: "cont" as NSObject
            ])
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextView = storyboard.instantiateInitialViewController() as! ViewController
            self.window?.rootViewController = nextView
            self.window?.makeKeyAndVisible();
            
        } else {
            let storyboard3 = UIStoryboard(name: "Storyboard3", bundle: nil)
            let nextView = storyboard3.instantiateInitialViewController() as! ViewController
            self.window?.rootViewController = nextView
            self.window?.makeKeyAndVisible();
        }
        
        let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(settings)
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        if !defaults .bool(forKey: "welcome"){
            defaults.set(day,forKey: "days")
            defaults.set(true, forKey: "welcome")
            defaults.set(true, forKey: "tutorial")
            
            defaults.synchronize()
            print(defaults.integer(forKey: "days"))
        }else{
            if day > defaults.integer(forKey: "days")||day == 1{
                print("変わった")
                defaults.set(true,forKey: "lock")
                defaults.set(day,forKey: "days")
                defaults.synchronize()
                check(name: "hantei1", name2: "Decision1")
                check(name: "hantei2", name2: "Decision2")
                check(name: "hantei3", name2: "Decision3")
                check(name: "hantei4", name2: "Decision4")
                check(name: "hantei5", name2: "Decision5")
                defaults.set(true, forKey: "timers1")
                defaults.set(true, forKey: "timers2")
                defaults.set(true, forKey: "timers3")
                defaults.set(true, forKey: "timers4")
                defaults.set(true, forKey: "timers5")
                
                defaults.synchronize()
                
            }else{
                print("1まだまだだよーーーん")
            }
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }
        catch {
            // report for an error
        }
        //        assert
        //        (title: "時間がっっjされていません")
        //        viewController.alert(title: "jikannga");
   TWTRTwitter.sharedInstance().start(withConsumerKey:"VUo3g9pT9vML8fTIn0DgRNlC0", consumerSecret:"8PiJ53Y2IV5l7njO63JeNNV2oDlaz2H4QxaQSCS30eS9pctemn")
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
    func check(name:String,name2:String) {
        if defaults.bool(forKey: name) == true {
            defaults.set(true, forKey: name2)
        }
        defaults.synchronize()
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        //        print(dates)
        print(date)
        print(defaults.integer(forKey: "days"))
        print(day)
        if day > defaults.integer(forKey: "days")||day == 1{
            print("変わった")
            defaults.set(day,forKey: "days")
            defaults.synchronize()
            defaults.set(true,forKey: "lock")
            defaults.set(day,forKey: "days")
            defaults.synchronize()
            check(name: "hantei1", name2: "Decision1")
            check(name: "hantei2", name2: "Decision2")
            check(name: "hantei3", name2: "Decision3")
            check(name: "hantei4", name2: "Decision4")
            check(name: "hantei5", name2: "Decision5")
            defaults.set(true, forKey: "timers1")
            defaults.set(true, forKey: "timers2")
            defaults.set(true, forKey: "timers3")
            defaults.set(true, forKey: "timers4")
            defaults.set(true, forKey: "timers5")
            
            defaults.synchronize()
            
        }else{
            print("1まだまだ")
        }
    }
    //     func application(_ application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
    //
    //        var alert = UIAlertView();
    //        alert.title = "受け取りました";
    //        alert.message = notification.alertBody;
    //        alert.addButton(withTitle: notification.alertAction!);
    //        alert.show();
    //
    //    }
    func mail() {
        //メールのコード
        if !MFMailComposeViewController.canSendMail(){
            print("ダメです。")
            return
        }
        let composeVC = MFMailComposeViewController()
        let defaults = UserDefaults.standard
        var mailadate:[String] = []
        
        if((defaults.object(forKey: "Address")) != nil){
            //objectsを配列として確定させ、前回の保存内容を格納
            let objects = defaults.object(forKey: "Address") as? NSArray
            //各名前を格納するための変数を宣言
            
            for nameString in objects!{
                //配列に追加していく
                mailadate.append(nameString as! String)
            }
        }
        composeVC.setToRecipients(mailadate)
        //メールアドレスを表示
        //件名
        composeVC.setSubject((defaults.object(forKey: "MailTitle") as? String)!)
        //メール本文
        composeVC.setMessageBody((defaults.object(forKey: "MailText") as? String)!, isHTML: false)
        
        //Present the view controller modally
        self.window?.rootViewController?.present(composeVC, animated: true, completion: nil)
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        //アプリがactive時に通知を発生させた時にも呼ばれる
        if UIDevice.current.userInterfaceIdiom == .phone {
            if 1.0 < UIScreen.main.scale {
                let size = UIScreen.main.bounds.size
                let scale = UIScreen.main.scale
                let result = CGSize(width: size.width * scale, height: size.height * scale)
                switch result.height {
                    
                case 1136:
                    let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
                    let nextView = storyboard.instantiateInitialViewController() as! ViewController
                    self.window?.rootViewController = nextView
                    self.window?.makeKeyAndVisible();
                    break
                default:
                    let storyboard2 = UIStoryboard(name: "Main", bundle: nil)
                    let nextView = storyboard2.instantiateInitialViewController() as! ViewController
                    self.window?.rootViewController = nextView
                    self.window?.makeKeyAndVisible();
                    break
                }
            } else {
                //                return "iPhone3"
            }
        } else {
            let storyboard3 = UIStoryboard(name: "Storyboard3", bundle: nil)
            let nextView = storyboard3.instantiateInitialViewController() as! ViewController
            self.window?.rootViewController = nextView
            self.window?.makeKeyAndVisible();
        }
        
        if application.applicationState != .active{
            print("やあああああああああああ")
            application.applicationIconBadgeNumber = 0
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            localPushRecieve(application: application, notification: notification)
            if self.defaults.bool(forKey: "hantei") == true {
                self.mail()
            }
            if self.defaults.bool(forKey: "sns") == true{
                viewController.getTwitterAccount()
                //                self.getTwitterAccount()
                
            }
            
        }else{
            print("mumu")
            if application.applicationIconBadgeNumber != 0{
                application.applicationIconBadgeNumber = 0
                application.cancelLocalNotification(notification)
            }
            var myAudioPlayer : AVAudioPlayer!
            let soundFilePath : String = Bundle.main.path(forResource: "bellbell", ofType: "mp3")!
            let fileURL = URL(fileURLWithPath: soundFilePath)
            
            
            //AVAudioPlayerのインスタンス化.
            myAudioPlayer = try! AVAudioPlayer(contentsOf: fileURL)
            
            //AVAudioPlayerのデリゲートをセット.
            myAudioPlayer.delegate = self
            myAudioPlayer.play()
            
            // UIAlertControllerを作成する.
            let myAlert: UIAlertController = UIAlertController(title: "お薬の時間になりました", message:nil, preferredStyle: .alert)
            
            // OKのアクションを作成する.
            let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
                print("Action OK!!")
                myAudioPlayer.stop()
                localPushRecieve(application: application, notification: notification)
                if self.defaults.bool(forKey: "hantei") == true {
                    self.mail()
                }
                if self.defaults.bool(forKey: "sns") == true {
                    self.viewController.getTwitterAccount()
                }
            }
            
            
            // OKのActionを追加する.
            myAlert.addAction(myOkAction)
            
            self.window?.rootViewController?.present(myAlert, animated: true, completion: nil)
        }}}

func localPushRecieve(application: UIApplication, notification: UILocalNotification) {
    if let userInfo = notification.userInfo {
        switch userInfo["alarms"] as? String {
        case .some("Decision1"):
            print("まずは一枚")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.viewController.nomimasita(string:"Decision1")
            break
        case .some("Decision2"):
            print("まずは2枚")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.viewController.nomimasita(string:"Decision2")
            break
        case .some("Decision3"):
            print("まずは3枚")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.viewController.nomimasita(string:"Decision3")
            break
        case .some("Decision4"):
            print("まずは4枚")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.viewController.nomimasita(string:"Decision4")
            break
        case .some("Decision5"):
            print("まずは5枚")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.viewController.nomimasita(string:"Decision5")
            break
        default:
            print("これは完全に...")
            break
        }
        //        // バッジをリセット
        //        application.applicationIconBadgeNumber = 0
        //        // 通知領域からこの通知を削除
        //        application.cancelLocalNotification(notification)
    }
}
/*
 application.applicationIconBadgeNumber = 0
 let appDelegate = UIApplication.shared.delegate as! AppDelegate
 appDelegate.viewController.nomimasita()
 */



//    func application(_ application: UIAp
//        // Override point for customization after application launch.
//        //復帰したかどうか
//        if let notification = launchOptions?[UIApplicationLaunchOptionsLocalNotificationKey] as? UILocalNotification,let userInfo = notification.userInfo{
//            application.applicationIconBadgeNumber = 0
//            application.cancelLocalNotification(notification)
//        }
//        ////////以下略(通知許可の)
//        return true
//}
private func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    // Override point for customization after application launch. Here you can out the code you want.
    print("aaa")
    return true
}

//アプリがバックグラウンドにある状態からフォアグラウンドになったとき
private func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    print("バックグラウンドからフォアグラウウンド")
    if application.applicationIconBadgeNumber != 0{
        application.applicationIconBadgeNumber = 0
        print("application\(application.applicationIconBadgeNumber)")
        
    }
}

