//
//  DATA.swift
//  お薬の時間
//
//  Created by 伊藤慶 on 2016/10/03.
//  Copyright © 2016年 伊藤慶. All rights reserved.
//

import UIKit

class DATA: NSObject {
    
}



var mail:[mailaddress] = []

class mailaddress: NSObject {
    var name:String
    var address:String
    
    override init(){
        name = ""
        address = ""
    }
    func dictionary() -> NSDictionary{
        return ["name":name,"address":address]
    }
    
    class func savemail() {
        var aDictionaries:[NSDictionary] = []
        for i:Int in 0 ..< mail.count {
            aDictionaries.append(mail[i].dictionary())
        }
        UserDefaults.standard.set(aDictionaries, forKey: "mail")
    }
    class func loadmail() {
        mail.removeAll()
        let defaults:UserDefaults = UserDefaults.standard
        let saveData:[NSDictionary]? = defaults.object(forKey: "mail") as? [NSDictionary]
        if let date:[NSDictionary] = saveData {
            print("aaa",date.count)
            for i:Int in 0 ..< date.count {
                let n:mailaddress = mailaddress()
                n.setValuesForKeys(date[i] as! [String : AnyObject])
                mail.append(n)
            }
        }
    }
}
