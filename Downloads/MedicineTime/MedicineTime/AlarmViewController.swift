//
//  AlarmViewController.swift
//  お薬のじかん for iPhone
//
//  Created by 福井一玄 on 2016/04/18.
//  Copyright © 2016年 kazuharu.fukui. All rights reserved.
//

import UIKit
import Answers

import UserNotifications

class AlarmViewController: UIViewController,UIPickerViewDelegate {
    
    @IBOutlet weak var check1: UIImageView!
    @IBOutlet weak var check2: UIImageView!
    @IBOutlet weak var check3: UIImageView!
    @IBOutlet weak var check4: UIImageView!
    @IBOutlet weak var check5: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    
    @IBOutlet weak var indexView: UITableView!
    let defaults = UserDefaults.standard
    var savename = ""
    var checkname = ""
    var chrck = ""
    var count:Int=0
    var snooze:Int!
    @IBAction func back(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        myDatePicker.addTarget(self, action: #selector(AlarmViewController.onDidChangeDate(sender:)), for: .valueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        time()
    }
    func time(){
        self.timellabel(label1, key: "alarm1", time: "6:00")
        self.timellabel(label2, key: "alarm2", time: "7:30")
        self.timellabel(label3, key: "alarm3", time: "12:00")
        self.timellabel(label4, key: "alarm4", time: "18:00")
        self.timellabel(label5, key: "alarm5", time: "22:00")
        self.imagecheck(check1, key: "hantei1",key2: "Decision1")
        self.imagecheck(check2, key: "hantei2",key2: "Decision2")
        self.imagecheck(check3, key: "hantei3",key2: "Decision3")
        self.imagecheck(check4, key: "hantei4",key2: "Decision4")
        self.imagecheck(check5, key: "hantei5",key2: "Decision5")
        self.schedule()
    }
    func imagecheck(_ image: UIImageView, key:String,key2:String){
        if defaults.bool(forKey: key) == true{
            image.image = UIImage(named:"toggle_on.png")
            if defaults.bool(forKey: key2) == false{
                defaults.set(false, forKey: key2)
            }else{
                defaults.set(true, forKey: key2)
            }
            defaults.synchronize()
        }else{
            image.image = UIImage(named:"toggle_off.png")
        }
        
    }
    
    func check(_ image: UIImageView, key1:String,key2:String,hantei:Bool){
        if image.image == UIImage(named:"toggle_off.png"){
            image.image = UIImage(named:"toggle_on.png")
            defaults.set(true, forKey: key1)
            defaults.set(true, forKey: key2)
            defaults.synchronize()
            
        }else {
            if hantei == true {
                image.image = UIImage(named:"toggle_off.png")
                defaults.set(false, forKey: key1)
                defaults.set(false, forKey: key2)
            }
        }
        defaults.synchronize()
    }
    func anImportantUserAction(i:Int) {
        
        // TODO: Move this method and customize the name and parameters to track your key metrics
        //       Use your own string attributes to track common values over time
        //       Use your own number attributes to track median value over time
        var a:String!
        switch i {
        case 1:a = "起床"
        case 2:a = "朝食"
        case 3:a = "昼食"
        case 4:a = "夕食"
        case 5:a = "就寝"

        default:break
        }
        let dateFormater = DateFormatter()
//        dateFormater.locale = Locale(identifier: "ja_JP")
        dateFormater.dateFormat = "HH:mm"
        let date = dateFormater.string(from: defaults.object(forKey: "alarm\(i)") as! Date)
        print(date)     // 2017/04/04 10:44:31
//        print(defaults.object(forKey: "alarm\(i)") as! String)
        print(defaults.object(forKey: "alarm\(i)") as! Date)
        Answers.logCustomEvent(withName:a, customAttributes:["time":date])
    }
    
    func schedule()
    {
        UIApplication.shared.cancelAllLocalNotifications()
        
        for i in 1  ... 5  {
            if defaults.object(forKey: "alarm\(i)") != nil{
                if defaults.bool(forKey: "hantei\(i)") == true {
                    print(defaults.bool(forKey: "hantei\(i)"))
                    defaults.set(false,forKey: "lock")
                    defaults.synchronize()
                    let notification = UILocalNotification()
                    anImportantUserAction(i: i)
                    notification.fireDate = fixNotificationDate(defaults.object(forKey: "alarm\(i)") as! Date)
                    print(notification.fireDate)
                    //
                    notification.timeZone = TimeZone.current
                    notification.alertBody = "お薬を飲む時間になりました"
                    
                    notification.soundName = "bellbell.mp3"
                    notification.userInfo =  ["alarms":"Decision\(i)"]
                    let unit: NSCalendar.Unit = [.day]
                    notification.repeatInterval = unit
                    notification.alertAction = "飲んだ"
                    
                    
                    UIApplication.shared.scheduleLocalNotification(notification)
                    
                }
            }
        }
    }
    func fixNotificationDate(_ dateToFix: Date) -> Date {
        //        let aaa = [.Year, .Month, .Day]
        var dateComponets: DateComponents = (Calendar.current as NSCalendar).components([.year,.day,.month,.hour,.minute], from: dateToFix)
        //５分
        dateComponets.second = 0
        
        let fixedDate: Date! = Calendar.current.date(from: dateComponets)
        
        
        return fixedDate
    }
    
    
    
    @IBAction func Check1(_ sender: AnyObject) {
        if !defaults .bool(forKey: "welcometime"){
            savename = "alarm1"
            picker()
            defaults.set(true, forKey: "welcometime")
            defaults.synchronize()
            
        }
        self.check(check1, key1: "hantei1",key2: "Decision1",hantei: true)
        
        self.schedule()
    }
    @IBAction func Check2(_ sender: AnyObject) {
        self.check(check2, key1: "hantei2",key2: "Decision2",hantei: true)
        self.schedule()
    }
    @IBAction func Check3(_ sender: AnyObject) {
        self.check(check3, key1: "hantei3",key2: "Decision3",hantei: true)
        self.schedule()
    }
    @IBAction func Check4(_ sender: AnyObject) {
        self.check(check4, key1: "hantei4",key2: "Decision4",hantei: true)
        self.schedule()    }
    @IBAction func Check5(_ sender: AnyObject) {
        self.check(check5, key1: "hantei5",key2: "Decision5",hantei: true)
        self.schedule()
    }
    
    @IBAction func tap1(_ sender: AnyObject) {
        savename = "alarm1"
        picker()
    }
    @IBAction func tap2(_ sender: AnyObject) {
        savename = "alarm2"
        picker()
    }
    @IBAction func tap3(_ sender: AnyObject) {
        savename = "alarm3"
        picker()
    }
    @IBAction func tap4(_ sender: AnyObject) {
        savename = "alarm4"
        picker()
    }
    @IBAction func tap5(_ sender: AnyObject) {
        savename = "alarm5"
        picker()
    }
    
    func timellabel(_ label:UILabel, key:String, time: String){
        
        if defaults.object(forKey: key) == nil{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let date = formatter.date(from: "2016-05-01 \(time):49")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let timeStr = dateFormatter.string(from: date!)
            print("asdfas",timeStr)
            label.text = timeStr
            defaults.set(date, forKey: key)
            
        }else{
            let date = defaults.object(forKey: key)as! Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let timeStr = dateFormatter.string(from: date)
            print("asdfas",timeStr)
            label.text = timeStr
        }
    }
    
    
    var alert: UIAlertController = UIAlertController()
    let myDatePicker: UIDatePicker = UIDatePicker()
    let drugsbutton: UIButton = UIButton()
    func picker() {
        alert = UIAlertController(title:"時間設定\n\n\n\n\n\n\n\n",
                                  message: nil,
                                  preferredStyle: .alert)
        
        let defaultAction:UIAlertAction = UIAlertAction(title: "OK",
                                                        style: .default,
                                                        handler:{
                                                            (action:UIAlertAction!) -> Void in
                                                            print("OK")
        })
        if defaults.object(forKey: savename) == nil{
            print("データが入ってないです")
        }else{
            myDatePicker.date = defaults.object(forKey: savename)as! Date
            
        }
        myDatePicker.frame = CGRect(x:15, y:50, width:240, height:200)
        myDatePicker.timeZone = NSTimeZone.local
        myDatePicker.datePickerMode = UIDatePickerMode.time
        alert.view.addSubview(myDatePicker)
        
        alert.addAction(defaultAction)
        
        self.present(alert, animated: true, completion: nil)
        switch savename {
        case "alarm1":
            self.check(check1, key1: "hantei1",key2: "Decision1",hantei: false)
            self.schedule()
            break
        case "alarm2":
            self.check(check2, key1: "hantei2",key2: "Decision2",hantei: false)
            self.schedule()
            break
            
        case "alarm3":
            self.check(check3, key1: "hantei3",key2: "Decision3",hantei: false)
            self.schedule()
            break
            
        case "alarm4":
            self.check(check4, key1: "hantei4",key2: "Decision4",hantei: false)
            self.schedule()
            break
            
        case "alarm5":
            self.check(check5, key1: "hantei5",key2: "Decision5",hantei: false)
            self.schedule()
            break
            
        default:
            break
        }
    }
    /*
     DatePickerが選ばれた際に呼ばれる.
     */
    @objc internal func onDidChangeDate(sender: UIDatePicker){
        // フォーマットを生成.
        let myDateFormatter: DateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
        // 日付をフォーマットに則って取得.
        defaults.set(sender.date, forKey: savename)
        defaults.synchronize()
        switch savename {
        case "alarm1":
            self.check(check1, key1: "hantei1",key2: "Decision1",hantei: false)
            self.schedule()
            break
        case "alarm2":
            self.check(check2, key1: "hantei2",key2: "Decision2",hantei: false)
            self.schedule()
            break
            
        case "alarm3":
            self.check(check3, key1: "hantei3",key2: "Decision3",hantei: false)
            self.schedule()
            break
            
        case "alarm4":
            self.check(check4, key1: "hantei4",key2: "Decision4",hantei: false)
            self.schedule()
            break
            
        case "alarm5":
            self.check(check5, key1: "hantei5",key2: "Decision5",hantei: false)
            self.schedule()
            break
            
        default:
            break
        }
        time()
    }
}
//extension AlarmViewController:UITableViewDelegate,UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return 1
//    }
//    
//    
//}
extension AlarmViewController:AlarmCellDelegate{
    func alarmcell(cell: AlarmCell, onoff: Bool, tag: Int) {
//        応急措置
        switch tag {
        case 1:savename = "alarm1"
        case 2:savename = "alarm2"
        case 3:savename = "alarm3"
        case 4:savename = "alarm4"
        case 5:savename = "alarm5"
        default:break
        }
        picker()
    }
}
