//
//  AlarmCell.swift
//  MedicineTime
//
//  Created by 伊藤慶 on 2018/10/28.
//  Copyright © 2018年 伊藤慶. All rights reserved.
//

import UIKit
protocol AlarmCellDelegate {
    func alarmcell(cell:AlarmCell,onoff:Bool,tag:Int)
}
class AlarmCell: UITableViewCell {

    @IBOutlet weak var checkButtom: UIButton!
    @IBOutlet weak var titleView: UIImageView!
    @IBOutlet weak var timeButtom: UIButton!
    var delegate:AlarmCellDelegate?
    
    var check:Bool = true {
        didSet{
            if check {
                checkButtom.setBackgroundImage(UIImage(named: "maru.png"), for: UIControlState())
            }else{
                checkButtom.setBackgroundImage(UIImage(named: "maru.png"), for: UIControlState())
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    @IBAction func check(_ sender: UIButton) {
        if checkButtom.backgroundImage(for:  UIControlState()) == UIImage(named: "maru.png") {
            checkButtom.setBackgroundImage(UIImage(named: "maru.png"), for: UIControlState())
            delegate?.alarmcell(cell: self, onoff: true, tag: sender.tag)
        }else{
            checkButtom.setBackgroundImage(UIImage(named: "maru.png"), for: UIControlState())
            delegate?.alarmcell(cell: self, onoff: true, tag: sender.tag)
        }
    }
}
