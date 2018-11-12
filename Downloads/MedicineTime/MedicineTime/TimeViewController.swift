//
//  TimeViewController.swift
//  お薬のじかん for iPhone
//
//  Created by 福井一玄 on 2016/04/22.
//  Copyright © 2016年 kazuharu.fukui. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableView: UIDatePicker!
    let defaults = UserDefaults.standard
    var snozetime: NSArray = ["しない","5分","10分","15分","20分"]
    var snooze:Bool!
    var savename:String = ""
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        print(savename)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if defaults.object(forKey: savename) == nil{
            print("データが入ってないです")
        }else{
            datePicker.date = defaults.object(forKey: savename)as! Date
        }
    }
            

    
    @IBAction func save(_ sender: AnyObject) {
        defaults.set(datePicker.date, forKey: savename)
        //一つ前に戻る
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancel(_ sender: AnyObject) {
        //一つ前に戻る
        self.dismiss(animated: true, completion: nil)
    }
}
