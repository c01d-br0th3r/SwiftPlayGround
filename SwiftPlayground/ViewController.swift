//
//  ViewController.swift
//  SwiftPlayground
//
//  Created by 이찬형 on 2020/09/04.
//  Copyright © 2020 이찬형. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 1.0
    var alarmTime: String?
    
    @IBOutlet var lblcurrentTime: UILabel!
    @IBOutlet var lblPickedTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblPickedTime.text = formatter.string(from: datePickerView.date)
        
        formatter.dateFormat = "hh:mm aaa"
        alarmTime = formatter.string(from: datePickerView.date);
    }
    
    @objc func updateTime() {
        let date = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblcurrentTime.text = formatter.string(from: date as Date)
        
        formatter.dateFormat = "hh:mm aaa"
        let currentTime = formatter.string(from: date as Date)
        
        if (alarmTime == currentTime) {
            let timeoutAlert = UIAlertController(title: "알람", message: "시간 종료 !!", preferredStyle: UIAlertController.Style.alert);
            let okAction = UIAlertAction(title: "확인했습니다.", style: UIAlertAction.Style.default, handler: nil);
            
            timeoutAlert.addAction(okAction)
            present(timeoutAlert, animated: true, completion: nil)
        }
    }
}

