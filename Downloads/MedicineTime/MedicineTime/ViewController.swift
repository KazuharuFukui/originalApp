//
//  ViewController.swift
//  MedicineTime
//
//  Created by 伊藤慶 on 2018/09/11.
//  Copyright © 2018年 伊藤慶. All rights reserved.
//


import UIKit
import MessageUI
import AVFoundation
import Accounts     //Twitterアカウント認証する場合にインポートします
import Social       //Twitterの各機能を利用する場合にインポートします
import Answers
class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    var Array:[String] = ["起\n床","朝\n食","昼\n食","夕\n食","就\n寝"]
    var Array2:[String] = ["起床","朝食","昼食","夕食","就寝"]
    
    let defaults = UserDefaults.standard
    var count:Int!
    var store = ACAccountStore() //Twitter、Facebookなどの認証を行うクラス
    var twitterAccount: ACAccount?      //Twitterのアカウントデータを格納する
    var snooze:Int=0
    var a:Int=0
    var key:String!
    var date:Date!
    var tamesi:Int=1
    var Screen: UIScreen {
        return UIScreen.main
    }
    
    @IBOutlet weak var tutorial1: UIImageView!
    @IBOutlet weak var tutorial2: UIImageView!
    @IBOutlet weak var tutorial3: UIImageView!
    @IBOutlet weak var tutorial4: UIImageView!
    @IBOutlet weak var tutorial5: UIImageView!
    
    @IBOutlet weak var nonda: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController = self
        self.timercheck()
        self.check()

        //        alert(title: "時間がっっjされていません")
        
        //        defaults.set(true, forKey: "tutorial")
        //        if defaults.bool(forKey: "tutorial"){
        //
        //        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.timercheck()
        self.check()
        
    }
    
    @IBAction func Nonda(_ sender: AnyObject) {
        nomimasita(string: "")
    }
    
    func nomimasita(string:String){
        print("aaaaaaa")
        print(defaults.bool(forKey: "lock"))
        self.check()
        if label.text != "な\nし"{
            if defaults.bool(forKey: "lock") == false {
                //                nonda.isEnabled = true
            }else{
                
                //        //保存したデータを呼び出している
                if defaults.bool(forKey: "hantei") == true {
                    mail()
                }
                print("jj");
                print(defaults.bool(forKey: "sns"))
                if defaults.bool(forKey: "sns") == true {
                    getTwitterAccount()
                }
                if string == ""{
                    defaults.set(false,forKey: key)
                    print(defaults.bool(forKey: key))
                }else{
                    defaults.set(false,forKey: string)
                    print(defaults.bool(forKey: string))
                }
                defaults.synchronize()
                self.timercheck()
                self.check()
                
                
            }
        }else{
            alert(title: "時間がセットされていません")
        }
        //        if defaults.bool(forKey: "lock") == false {
        //            nonda.isEnabled = true
        //        }else{
        //            nonda.isEnabled = false
        //        }
    }
    open func getTwitterAccount() {
        
        let accountType = store.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        store.requestAccessToAccounts(with: accountType, options: nil) { [weak self] granted, error in
            guard self != nil else { return }
            
            if !granted {
                print("Not granted.")
                return
            }
            
            if error != nil {
                print("error: \(String(describing: error))")
                return
            }
            
            let accounts = self?.store.accounts(with: accountType)
                as! [ACAccount]
            
            if self?.defaults.object(forKey: "snsaccount") != nil {
                for  account in accounts {
                    if ( account.identifier as String! == self?.defaults.object(forKey: "snsaccount") as! String)
                    {
                        self?.twitterAccount = account
                        break;
                    }
                }
                self?.postTweet()
            }else{
                print("失敗")
            }
        }
    }
    
    private func postTweet() {
        
        let URL = NSURL(string: "https://api.twitter.com/1.1/statuses/update.json")
        
        let now = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        let string = formatter.string(from: now as Date)
        
        print(string)
        let params = ["status" : String(format: "%@のお薬を飲みました。\n%@\n#お薬のじかん",Array2[count-1], string)]
        // リクエストを生成
        // リクエストを生成
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                requestMethod: .POST,
                                url: URL as URL!,
                                parameters: params)
        
        // 取得したアカウントをセット
        request?.account = twitterAccount
        
        // APIコールを実行
        request?.perform { (responseData, urlResponse, error) -> Void in
            
            if error != nil {
                print("error is \(String(describing: error))")
            }
            else {
                // 結果の表示
                do {
                    let result = try JSONSerialization.jsonObject(with: responseData!,
                                                                  options: .allowFragments) as! NSDictionary
                    
                    print("result is \(result)")
                    
                } catch {
                    return
                }
            }
        }
    }
    func mail() {
        //メールのコード
        if !MFMailComposeViewController.canSendMail(){
            print("ダメです。")
            return
        }
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
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
        self.present(composeVC, animated: true, completion: nil)
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
    open func alert(title:String) {
        let Alert: UIAlertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        // OKのアクションを作成する.
        let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
            print("Action OK!!")
        }
        
        // OKのActionを追加する.
        Alert.addAction(myOkAction)
        
        // UIAlertを発動する.
        self.present(Alert, animated: true, completion: nil)
        
    }
    
    func timercheck(){
        
    }
    func checker(key:String,key2:String,key3:String){
        if defaults.bool(forKey: key) == true {
            defaults.set(true, forKey: key2)
            defaults.set(false, forKey: key3)
        }
        self.check()
    }
    func textlabel(keyname:String,count2:Int,datename:String) {
        key = keyname
        count = count2
        print(count)
        label.text=Array[count-1]
        date = defaults.object(forKey: datename)as! Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeStr = dateFormatter.string(from: date)
        label2.text=timeStr
        defaults.set(true, forKey: "lock")
        defaults.synchronize()
    }
    
    func check(){
        //        print(defaults.bool(forKey: "Decision\(count)"))
        let date12 = Date()
        let calendar = Calendar.current
        let hour2 = calendar.component(.hour, from: date12)
        print("時間だよ時間だよ")
        
        print(hour2)
        
        switch true {
            
        case defaults.bool(forKey: "Decision1"):
            
            textlabel(keyname: "Decision1", count2: 1, datename: "alarm1")
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "HH:mm"
            let date = dateFormater.string(from: defaults.object(forKey: "alarm1") as! Date)
            Answers.logCustomEvent(withName:"飲んだ", customAttributes:["time":date])
            
            break
        case defaults.bool(forKey: "Decision2"):
            if calendar.component(.hour, from: defaults.object(forKey: "alarm2")as! Date) >= hour2{
                //                checker(key: "Decision1", key2: "timers1", key3: "Decision1")
            }
            textlabel(keyname: "Decision2", count2: 2, datename: "alarm2")
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "HH:mm"
            let date = dateFormater.string(from: defaults.object(forKey: "alarm2") as! Date)
            Answers.logCustomEvent(withName:"飲んだ", customAttributes:["time":date])
            break
        case defaults.bool(forKey: "Decision3"):
            if calendar.component(.hour, from: defaults.object(forKey: "alarm3")as! Date) >= hour2{
                //                checker(key: "Decision1", key2: "timers1", key3: "Decision1")
                //                checker(key: "Decision2", key2: "timers2", key3: "Decision2")
            }
            textlabel(keyname: "Decision3", count2: 3, datename: "alarm3")
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "HH:mm"
            let date = dateFormater.string(from: defaults.object(forKey: "alarm3") as! Date)
            Answers.logCustomEvent(withName:"飲んだ", customAttributes:["time":date])
            break
        case defaults.bool(forKey: "Decision4"):
            if calendar.component(.hour, from: defaults.object(forKey: "alarm4")as! Date) >= hour2{
                //                checker(key: "Decision1", key2: "timers1", key3: "Decision1")
                //                checker(key: "Decision2", key2: "timers2", key3: "Decision2")
                //                checker(key: "Decision3", key2: "timers3", key3: "Decision3")
                
            }
            textlabel(keyname: "Decision4", count2: 4, datename: "alarm4")
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "HH:mm"
            let date = dateFormater.string(from: defaults.object(forKey: "alarm4") as! Date)
            Answers.logCustomEvent(withName:"飲んだ", customAttributes:["time":date])
            break
        case defaults.bool(forKey: "Decision5"):
            //            if calendar.component(.hour, from: defaults.object(forKey: "alarm5")as! Date) >= hour2{
            //                checker(key: "Decision1", key2: "timers1", key3: "Decision1")
            //                checker(key: "Decision2", key2: "timers2", key3: "Decision2")
            //                checker(key: "Decision3", key2: "timers3", key3: "Decision3")
            //                checker(key: "Decision4", key2: "timers4", key3: "Decision4")
            //            }
            
            textlabel(keyname: "Decision5", count2: 5, datename: "alarm5")
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "HH:mm"
            let date = dateFormater.string(from: defaults.object(forKey: "alarm5") as! Date)
            Answers.logCustomEvent(withName:"飲んだ", customAttributes:["time":date])
            break
        default:
            defaults.set(false, forKey: "lock")
            defaults.synchronize()
            switch true {
            case defaults.bool(forKey: "hantei1"):
                textlabel(keyname: "", count2: 1, datename: "alarm1")
                
                break
            case defaults.bool(forKey: "hantei2"):
                date = defaults.object(forKey: "alarm2")as! Date
                count = 2
                print(count)
                label.text=Array[count-1]
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let timeStr = dateFormatter.string(from: date)
                label2.text=timeStr
                break
            case defaults.bool(forKey: "hantei3"):
                date = defaults.object(forKey: "alarm3")as! Date
                count = 3
                print(count)
                label.text=Array[count-1]
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let timeStr = dateFormatter.string(from: date)
                label2.text=timeStr
                break
            case defaults.bool(forKey: "hantei4"):
                count = 4
                print(count)
                label.text=Array[count-1]
                
                
                date = defaults.object(forKey: "alarm4")as! Date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let timeStr = dateFormatter.string(from: date)
                label2.text=timeStr
                break
            case defaults.bool(forKey: "hantei5"):
                count = 5
                print(count)
                label.text=Array[count-1]
                
                
                date = defaults.object(forKey: "alarm5")as! Date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let timeStr = dateFormatter.string(from: date)
                label2.text=timeStr
                break
            default:
                label.text = "な\nし"
                label2.text="00:00"
                break
            }
            break
        }
    }
}


