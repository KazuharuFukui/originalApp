//
//  HistoryViewController.swift
//  お薬のじかん for iPhone
//
//  Created by 福井一玄 on 2016/04/18.
//  Copyright © 2016年 kazuharu.fukui. All rights reserved.
//

import UIKit
class HistoryViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
               //ここから
        // 長押しを認識.
        let myLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(HistoryViewController.button1(_:)))
        
        // 長押し-最低2秒間は長押しする.
        myLongPressGesture.minimumPressDuration = 0.5
        
        // 長押し-指のズレは15pxまで.
        myLongPressGesture.allowableMovement = 150        // Do any additional setup after loading the view.
         button1.addGestureRecognizer(myLongPressGesture)
        //ここまで！！！！！！！！
        
        let myLongPressGesture2 = UILongPressGestureRecognizer(target: self, action: #selector(HistoryViewController.button2(_:)))
        
        // 長押し-最低2秒間は長押しする.
        myLongPressGesture2.minimumPressDuration = 0.5
        
        // 長押し-指のズレは15pxまで.
        myLongPressGesture2.allowableMovement = 150        // Do any additional setup after loading the view
        
        
        button2.addGestureRecognizer(myLongPressGesture2)
        
        
        let myLongPressGesture3 = UILongPressGestureRecognizer(target: self, action: #selector(HistoryViewController.button3(_:)))
        
        // 長押し-最低2秒間は長押しする.
        myLongPressGesture3.minimumPressDuration = 0.5
        
        // 長押し-指のズレは15pxまで.
        myLongPressGesture3.allowableMovement = 150        // Do any additional setup after loading the view.
        
        
        button3.addGestureRecognizer(myLongPressGesture3)
        
        
        
        let myLongPressGesture4 = UILongPressGestureRecognizer(target: self, action: #selector(HistoryViewController.button4(_:)))
        
        // 長押し-最低2秒間は長押しする.
        myLongPressGesture4.minimumPressDuration = 0.5
        
        // 長押し-指のズレは15pxまで.
        myLongPressGesture4.allowableMovement = 150        // Do any additional setup after loading the view.
        button4.addGestureRecognizer(myLongPressGesture4)
        
        
        let myLongPressGesture5 = UILongPressGestureRecognizer(target: self, action: #selector(HistoryViewController.button5(_:)))
        
        // 長押し-最低2秒間は長押しする.
        myLongPressGesture5.minimumPressDuration = 0.5
        
        // 長押し-指のズレは15pxまで.
        myLongPressGesture5.allowableMovement = 150        // Do any additional setup after loading the view.
        button5.addGestureRecognizer(myLongPressGesture5)
    }
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.check(1, button: button1,key: "Decision1",key2:"timers1")
        self.check(2, button: button2,key: "Decision2",key2:"timers2")
        self.check(3, button: button3,key: "Decision3",key2:"timers3")
        self.check(4, button: button4,key: "Decision4",key2:"timers4")
        self.check(5, button: button5,key: "Decision5",key2:"timers5")
    }
    func check(_ suuji:NSInteger,button:UIButton,key:String,key2:String){

                if defaults.bool(forKey: "hantei\(suuji)") == false {
                    button.isHidden = true
                }else{
                    button.isHidden = false
                    if defaults.bool(forKey: key) == true{
                        button.setBackgroundImage(UIImage(named: "batu.png"), for: UIControlState())
                        
                    }else{
                        button.setBackgroundImage(UIImage(named: "maru.png"), for: UIControlState())
                    }
    

        }
        print(defaults.bool(forKey: key))

        
    }
    func alert(_ button:UIButton,key:String){
//        let aa = UIAlertView
        let alertCtrl = UIAlertController(title: "履歴を変更します。", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        //謎〜　defaultsが変換されない　boolがあればうまくいく
        var i = true
        let Yesaction:UIAlertAction = UIAlertAction(title: "飲んだ",
                                                    style: UIAlertActionStyle.default,
                                                    handler:{
                                                        (action:UIAlertAction!) -> Void in
                                                        button.setBackgroundImage(UIImage(named: "maru.png"), for: UIControlState())
//                                                        self.defaults.setBool(false, forKey: key)
                                                       

                                                        i=false
        })
        let NOaction:UIAlertAction = UIAlertAction(title: "飲んでいない",
                                                   style: UIAlertActionStyle.default,
                                                   handler:{
                                                    (action:UIAlertAction!) -> Void in
                                                    button.setBackgroundImage(UIImage(named: "batu.png"), for: UIControlState())
                                                    //                                                    self.defaults.setBool(true, forKey: key) self.tamesi=4
                                                    i=true
        })
        
        alertCtrl.addAction(Yesaction)
        alertCtrl.addAction(NOaction)
        
        self.present(alertCtrl, animated: true, completion: nil)
        if i==true{
            defaults.set(true, forKey: key)
        }else{
            defaults.set(false, forKey: key)
        }
        defaults.synchronize()
        print("hantei\(defaults.bool(forKey: key))")

        
    }
    @IBAction func back(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc internal func button1(_ sender: UITapGestureRecognizer) {
        self.alert(button1, key: "Decision1")
    }
    @objc internal func button2(_ sender: UITapGestureRecognizer) {
        self.alert(button2, key: "Decision2")
    }
    @objc internal func button3(_ sender: UITapGestureRecognizer) {
        self.alert(button3, key: "Decision3")
    }
    @objc internal func button4(_ sender: UITapGestureRecognizer) {
        self.alert(button4, key: "Decision4")
    }
    @objc internal func button5(_ sender: UITapGestureRecognizer) {
        self.alert(button5, key: "Decision5")
    }
}

