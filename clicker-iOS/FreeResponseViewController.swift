//
//  FreeResponseViewController.swift
//  clicker
//
//  Created by Michael on 9/20/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

import UIKit

class FreeResponseViewController: UIViewController {

    @IBOutlet weak var TimeLabel: UILabel!
    var timeRemaining : Int = 15;

    override func viewDidLoad() {
        super.viewDidLoad()
    
        TimeLabel.text = "00:15";
    
        // Do any additional setup after loading the view.
        _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timeDown", userInfo: nil, repeats: false);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func timeDown() {
        timeRemaining--;
        if timeRemaining != 0 {
            _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timeDown", userInfo: nil, repeats: false);
        }
        else {
            self.navigationController?.popViewControllerAnimated(true);
        }
        if timeRemaining < 10 {
            TimeLabel.text = "00:0" + String(timeRemaining);
        }
        else {
            TimeLabel.text = "00:" + String(timeRemaining);
        }
    }
}