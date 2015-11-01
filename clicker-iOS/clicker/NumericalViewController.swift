//
//  NumericalViewController.swift
//  clicker
//
//  Created by Wayne Chi on 9/17/15.
//  Copyright (c) 2015 Univeristy of Southern California. All rights reserved.
//

import UIKit

class NumericalViewController: UIViewController {

    @IBOutlet var Time: UILabel!
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    var timeRemaining : Int = 15;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Time.text = "00:15";

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
//            self.navigationController?.popViewControllerAnimated(true);
            self.dismissViewControllerAnimated(true, completion: nil)

        }
        if timeRemaining < 10 {
            Time.text = "00:0" + String(timeRemaining);
        }
        else {
            Time.text = "00:" + String(timeRemaining);
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
