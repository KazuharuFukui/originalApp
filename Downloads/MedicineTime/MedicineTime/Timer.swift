////
////  Timer.swift
////  お薬の時間
////
////  Created by 伊藤慶 on 2016/10/20.
////  Copyright © 2016年 伊藤慶. All rights reserved.
////
//
//import UIKit
//import AVFoundation
//let defaults = UserDefaults.standard
//let date = Date()
////履歴管理
//class History: NSObject {
//    override init(){
//        //        note = ""
//    }
//    class }
////時間管理
//
//class Time:NSObject,AVAudioPlayerDelegate {
//    var audioPlayer:AVAudioPlayer!
//    
//    override init(){
//        
//    }
//    class func time() {
//        //        let date = Date()
//        let hour = Calendar.current.component(.hour, from: date)
//        Timer.scheduledTimer(timeInterval: TimeInterval(hour), target: self, selector: #selector(alarm), userInfo: nil, repeats: true)
//    }
//    func alarm(){
//        
//        for i in 1...5 {
//            if defaults.bool(forKey: "hantei\(i)") == true && defaults.bool(forKey: "Decision\(i)") == true{
//                if date == defaults.object(forKey: "alarm1") as! Date {
//                    auido()
//                    audioPlayer.play()
//                }
//            }
//        }
//        
//    }
//    func auido(){
//        // 再生する audio ファイルのパスを取得
//        let audioPath = Bundle.main.path(forResource: "bell", ofType:"mp3")!
//        let audioUrl = URL(fileURLWithPath: audioPath)
//        // auido を再生するプレイヤーを作成する
//        var audioError:NSError?
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
//        } catch let error as NSError {
//            audioError = error
//            audioPlayer = nil
//        }
//        
//        // エラーが起きたとき
//        if let error = audioError {
//            print("Error \(error.localizedDescription)")
//        }
//        audioPlayer.numberOfLoops = 1800
//        audioPlayer.delegate = self
//        audioPlayer.prepareToPlay()
//        
//    }
//}
//
//
//
//
//
