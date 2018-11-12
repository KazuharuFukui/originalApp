//
//  MailandSNS.swift
//  MedicineTime
//
//  Created by 伊藤慶 on 2018/11/11.
//  Copyright © 2018年 伊藤慶. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI
import TwitterKit
import TwitterCore
class MailandSNS: UIViewController, UITextFieldDelegate,CNContactPickerDelegate,UITableViewDelegate, UITableViewDataSource  {
    var nameString:AnyObject!
    @IBOutlet weak var checkbutton: UIButton!
    @IBOutlet weak var checkbutton2: UIButton!
    let defaults = UserDefaults.standard
    
    //    バックボタン
    @IBAction func Back(_ sender: AnyObject){
        //"NAME"というキーで配列namesを保存
        if defaults.bool(forKey: "hantei") == true{
            if Mailaddress.text != "" && MailTitle.text != "" && MailText.text != "" {
                defaults.set(mailadate, forKey:"Address")
                defaults.set(Namedate, forKey:"NAME")
                defaults.set(MailTitle.text, forKey:"MailTitle")
                defaults.set(MailText.text, forKey:"MailText")
                // シンクロを入れないとうまく動作しないときがあります
                defaults.synchronize()
                
                self.dismiss(animated: true, completion: nil)
            }else{
                let myAlert: UIAlertController = UIAlertController(title: "宛先、件名、本文のいずれかが入力されていません", message:nil, preferredStyle: .alert)
                
                // OKのアクションを作成する.
                let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
                    //                    print("Action OK!!")
                    self.mail()
                    
                }
                myAlert.addAction(myOkAction)                // UIAlertを発動する.
                present(myAlert, animated: true, completion: nil)
            }
        }else{
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    //チェックボタン
    @IBAction func Check(_ sender: AnyObject) {
        if defaults.bool(forKey: "hantei") == true{
            checkbutton.setBackgroundImage(UIImage(named: "toggle_off.png"), for: UIControlState())
            defaults.set(false, forKey: "hantei")
        }else{
            checkbutton.setBackgroundImage(UIImage(named: "toggle_on.png"), for: UIControlState())
            defaults.set(true, forKey: "hantei")
        }
        defaults.synchronize()
    }
    
    var Address: String!
    var Name: String!
    var Namedate : [String] = []
    var mailadate : [String] = []
    var hantei:Bool = false
    //    var Maildata:[[String]] = [[],[]]
    
    var row = 0
    //メールアドレス取得
    @IBAction func showContactPickerController() {
        let myAlert: UIAlertController = UIAlertController(title: "メールアドレス取得方法", message:nil, preferredStyle: .alert)
        
        // OKのアクションを作成する.
        let myOkAction = UIAlertAction(title: "連絡帳から選択", style: .default) { action in
            print("Action OK!!")
            self.mail()
            
        }
        // OKのアクションを作成する.
        let myOkAction2 = UIAlertAction(title: "自分で入力", style: .default) { action in
            print("Action OK!!")
            self.selfmail()
        }
        
        let myOkAction3 = UIAlertAction(title: "戻る", style: .default) { action in
            //            print("Action OK!!")
            //            self.selfmail()
        }
        
        // OKのActionを追加する.
        myAlert.addAction(myOkAction)
        myAlert.addAction(myOkAction2)
        myAlert.addAction(myOkAction3)
        
        // UIAlertを発動する.
        present(myAlert, animated: true, completion: nil)
        
    }
    func mail(){
        let pickerViewController = CNContactPickerViewController()
        pickerViewController.delegate = self
        
        // Display only a person's phone, email, and postal address
        let displayedItems = [ CNContactEmailAddressesKey]
        pickerViewController.displayedPropertyKeys = displayedItems
        
        // Show the picker
        self.present(pickerViewController, animated: true, completion: nil)
    }
    func selfmail(){
        let alert:UIAlertController = UIAlertController(title:"自分で入力",
                                                        message: "",
                                                        preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel",
                                                       style: UIAlertActionStyle.cancel,
                                                       handler:{
                                                        (action:UIAlertAction!) -> Void in
                                                        //                                                        println("Cancel")
        })
        let defaultAction:UIAlertAction = UIAlertAction(title: "OK",
                                                        style: UIAlertActionStyle.default,
                                                        handler:{
                                                            (action:UIAlertAction!) -> Void in
                                                            
                                                            if alert.textFields![0] .text == ""||alert.textFields![1] .text == ""{
                                                                let alert:UIAlertController = UIAlertController(title:"未入力があります",
                                                                                                                message: nil,
                                                                                                                preferredStyle: UIAlertControllerStyle.alert)
                                                                
                                                                let defaultAction:UIAlertAction = UIAlertAction(title: "OK",
                                                                                                                style: UIAlertActionStyle.default,
                                                                                                                handler:{
                                                                                                                    (action:UIAlertAction!) -> Void in
                                                                })
                                                                alert.addAction(defaultAction)
                                                                self.present(alert, animated: true, completion: nil)
                                                            }else{
                                                                self.Name = alert.textFields![0] .text
                                                                self.Address = alert.textFields![1] .text
                                                                self.mailcheck()
                                                            }
                                                            
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        //textfiledの追加
        alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
            text.placeholder = "名前"
        })
        //実行した分textfiledを追加される。
        alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
            text.placeholder = "メールアドレス"
        })
        present(alert, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        let contact = contactProperty.contact
        let contactName = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
        DispatchQueue.main.async {
            print((contactProperty.value as AnyObject)as! String)
            print(contactName)
            self.Address = (contactProperty.value as AnyObject)as! String
            self.Name = contactName
            self.mailcheck()
        }}
    func mailcheck(){
        for nameString in self.mailadate{
            if self.Address == nameString {
                self.hantei = true
                break
            }
        }
        if self.hantei == false {
            self.mailout(self.Address)
            
        }else{
            let Alert: UIAlertController = UIAlertController(title: "すでに追加されています。", message: nil, preferredStyle: .alert)
            
            // OKのアクションを作成する.
            let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
                print("Action OK!!")
                self.hantei = false
            }
            
            // OKのActionを追加する.
            Alert.addAction(myOkAction)
            
            // UIAlertを発動する.
            self.present(Alert, animated: true, completion: nil)
        }
    }
    
    // Called when the user taps Cancel.
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
    }
    func mailout(_ title:String){
        let mail = title
        //メールアドレスが合っているかどうかの確認
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = mail.range(of: emailRegEx,options:.regularExpression)
        let result = range != nil ? true : false
        if !result{
            //メールの形式が正しくない時の処理
            print("有効なメールアドレスをご記入ください")
            // UIAlertControllerを作成する.
            let myAlert: UIAlertController = UIAlertController(title: "有効なメールアドレスをご記入ください", message: nil, preferredStyle: .alert)
            
            // OKのアクションを作成する.
            let myOkAction = UIAlertAction(title: "OK", style: .default) { action in
                print("Action OK!!")
            }
            
            // OKのActionを追加する.
            myAlert.addAction(myOkAction)
            
            // UIAlertを発動する.
            present(myAlert, animated: true, completion: nil)
            
        }else{
            
            if mailadate.count == 0 {
                self.row = 0
            }else{
                self.row = mailadate.count + 1
            }
            mailadate.append(Address)
            Namedate.append(Name)
            //"NAME"というキーで配列namesを保存
            defaults.set(mailadate, forKey:"Address")
            defaults.set(Namedate, forKey:"NAME")
            self.Mailaddress.text = Namedate[0]
            // シンクロを入れないとうまく動作しないときがあります
            defaults.synchronize()
        }
    }
    //アドレスTable表示
    var alert: UIAlertController = UIAlertController()
    var myTableView: UITableView!
    @IBAction func picker(_ sender: AnyObject) {
        
        alert = UIAlertController(title:"連絡先\n\n\n\n\n\n\n\n",
                                  message: nil,
                                  preferredStyle: .alert)
        
        
        let defaultAction:UIAlertAction = UIAlertAction(title: "OK",
                                                        style: .default,
                                                        handler:{
                                                            (action:UIAlertAction!) -> Void in
                                                            print("OK")
        })
        myTableView = UITableView(frame: CGRect(x: 0, y: 50, width: 270, height: 180))
        // Cellの登録.
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定.
        myTableView.dataSource = self
        
        // Delegateを設定.
        myTableView.delegate = self
        // 編集中のセル選択を許可.
        myTableView.allowsSelectionDuringEditing = true
        
        
        alert.view.addSubview(myTableView)
        
        //        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    /*
     Cellが選択された際に呼び出される.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 選択中のセルが何番目か.
        print("Num: \(indexPath.row)")
        
        // 選択中のセルのvalue.
        //        print("Value: \(myItems[indexPath.row])")
        
        // 選択中のセルを編集できるか.
        print("Edeintg: \(tableView.isEditing)")
    }
    
    
    /*
     Cellの総数を返す
     (実装必須)
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mailadate.count
    }
    
    /*
     Cellに値を設定する
     (実装必須)
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        // Cellに値を設定.
        cell.textLabel?.text = mailadate[(indexPath as NSIndexPath).row]
        
        return cell
    }
    /*
     Cellを挿入または削除しようとした際に呼び出される
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // 削除のとき.
        if editingStyle == UITableViewCellEditingStyle.delete {
            print("削除")
            mailadate.remove(at: (indexPath as NSIndexPath).row)
            Namedate.remove(at: (indexPath as NSIndexPath).row)
            // TableViewを再読み込み.
            myTableView.reloadData()
            if !Namedate.isEmpty{
                if Namedate.count > 1 {
                    self.Mailaddress.text = NSString(format:"%@.他%d人",Namedate[0],Namedate.count - 1) as String
                }else{
                    self.Mailaddress.text = Namedate[0]
                }
            }else{
                self.Mailaddress.text = ""
                
            }
        }
    }
    
    
    ///*
    //   アップデート１
    // 　　全部UIalertにする！！
    // */
    @IBOutlet weak var Mailaddress: UITextField!
    @IBOutlet weak var MailTitle: UITextField!
    @IBOutlet weak var MailText: UITextField!
    //    //データを保存するやつ
    //    let defaults = UserDefaults.standard
    ////初期
    func text(textf:UITextField,name:String,text:String){
        if defaults.object(forKey: name) == nil {
            textf.text = text
        }else{
            textf.text = defaults.object(forKey: name) as! String?
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Mailaddress.delegate = self
        MailTitle.delegate = self
        MailText.delegate = self
        text(textf: MailTitle, name: "MailTitle", text: "お薬を飲みました")
        text(textf: MailText, name: "MailText", text: "今お薬を飲みました!")
        Namedate = []
        mailadate = []
        if((defaults.object(forKey: "NAME")) != nil){
            //objectsを配列として確定させ、前回の保存内容を格納
            let objects = defaults.object(forKey: "NAME") as? NSArray
            //各名前を格納するための変数を宣言
            //                var nameString:AnyObject
            for nameString in objects!{
                //配列に追加していく
                Namedate.append(nameString as! String)
            }
            if !Namedate.isEmpty{
                
                if Namedate.count > 1 {
                    self.Mailaddress.text = NSString(format:"%@.他%d人",Namedate[0],Namedate.count - 1) as String
                }else{
                    self.Mailaddress.text = Namedate[0]
                }
            }else{
                self.Mailaddress.text = ""
            }
        }
        if((defaults.object(forKey: "Address")) != nil){
            //objectsを配列として確定させ、前回の保存内容を格納
            let objects = defaults.object(forKey: "Address") as? NSArray
            //各名前を格納するための変数を宣言
            
            for nameString in objects!{
                //配列に追加していく
                mailadate.append(nameString as! String)
            }
        }
        if defaults.bool(forKey: "hantei") == true{
            checkbutton.setBackgroundImage(UIImage(named: "toggle_on.png"), for: UIControlState())
        }else{
            checkbutton.setBackgroundImage(UIImage(named: "toggle_off.png"), for: UIControlState())
        }
        //            if defaults.bool(forKey: "sns") == true{
        //            check2.setBackgroundImage(UIImage(named: "toggle_on.png"), for: UIControlState())
        //            }else{
        //                check2.setBackgroundImage(UIImage(named: "toggle_off.png"), for: UIControlState())
        //            }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    //テキストフィールド編集する直前に呼び出される
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //Viewの大きさを取得している
        let frame = self.view.frame
        if textField == self.MailText{
            if frame.origin != CGPoint(x: 0, y: -200){
                //0.3は時間(0.3秒)
                UIView.animate(withDuration: 0.3, delay: 0, options:UIViewAnimationOptions(), animations: { () -> Void in
                    let size = self.view.frame.size
                    self.view.frame = CGRect(x: 0, y: -200, width: size.width, height: size.height)
                    self.view.layoutIfNeeded()
                }, completion: { (finished:Bool) -> Void in
                })
            }
        }else if textField == self.MailTitle {
            if frame.origin != CGPoint(x: 0, y: -100){
                UIView.animate(withDuration: 0.2, delay: 0, options:UIViewAnimationOptions(), animations: { () -> Void in
                    let size = self.view.frame.size
                    self.view.frame = CGRect(x: 0, y: -100, width: size.width, height: size.height)
                    self.view.layoutIfNeeded()
                }, completion: { (finished:Bool) -> Void in
                })
            }
        }else{
            pulldownView()
        }
        return true
    }
    
    //元に戻すコード
    func pulldownView(){
        if self.view.frame.origin != CGPoint(x: 0 , y:0){
            let size = self.view.frame.size
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
                self.view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                self.view.layoutIfNeeded()
            }) { (finished:Bool) -> Void in
            }
        }
    }
    
    //タッチした時
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pulldownView()
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var mailview: UIImageView!
    @IBOutlet weak var snsview: UIImageView!
    @IBOutlet weak var text1: UIImageView!
    @IBOutlet weak var text2: UIImageView!
    @IBOutlet weak var text3: UIImageView!
    @IBOutlet weak var backbutton: UIButton!
    var tamesi:Int=1
    var Screen: UIScreen {
        return UIScreen.main
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //        TutorialManager.sharedManager().shouldShowTutorial = true
        //        setup()
        //        TutorialManager.sharedManager().showTutorialWithIdentifier("1");
        
    }
    @IBOutlet weak var mailbutton: UIButton!
    
    @IBOutlet weak var check2: UIButton!
    @IBAction func check2(_ sender: Any) {
        //okok
        if defaults.bool(forKey: "sns") == true{
            check2.setBackgroundImage(UIImage(named: "toggle_off.png"), for: UIControlState())
            defaults.set(false, forKey: "sns")
        }else{
            
            getTwitterAccount()
            
        }
        defaults.synchronize()
    }
    
    
    var store = ACAccountStore() //Twitter、Facebookなどの認証を行うクラス
    var twitterAccount: ACAccount?      //Twitterのアカウントデータを格納する
    var moji:String!
    
    //Twitterのアカウント認証を行う
    func getTwitterAccount() {
        TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                print("signed in as \(session?.userName)");
            } else {
                print("error: \(error?.localizedDescription)");
            }
        })
    }
    
    private func selectTwitterAccount(accounts: [ACAccount]) {
        
        let alert = UIAlertController(title: "Twitter",
                                      message: "アカウントを選択してください",
                                      preferredStyle: .actionSheet)
        
        
        for account in accounts {
            alert.addAction(UIAlertAction(title: account.username, style: .default,
                                          handler: { (action) -> Void in
                                            self.twitterAccount = account
                                            self.defaults.set(account.identifier, forKey:"snsaccount")
                                            self.check2.setBackgroundImage(UIImage(named: "toggle_on.png"), for: UIControlState())
                                            
                                            self.defaults.set(true, forKey: "sns")
                                            self.defaults.synchronize()
                                            
            }))
        }
        let mynoAction = UIAlertAction(title: "選択しない", style: .default) { action in
            print("Action OK!!")
        }
        alert.addAction(mynoAction)
        
        // 表示する
        self.present(alert, animated: true, completion: nil)
    }
}
