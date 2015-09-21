//
//  MultipleChoiceViewController.swift
//  clicker
//
//  Created by Wayne Chi on 9/17/15.
//  Copyright (c) 2015 Univeristy of Southern California. All rights reserved.
//

import UIKit

class MultipleChoiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var Time: UILabel!
    
    var timeRemaining : Int = 15;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Time.text = "00:15";
        
        // Do any additional setup after loading the view.
        _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timeDown", userInfo: nil, repeats: false);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            Time.text = "00:0" + String(timeRemaining);
        }
        else {
            Time.text = "00:" + String(timeRemaining);
        }
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : MultipleChoiceTableViewCell = tableView.dequeueReusableCellWithIdentifier("multipleChoiceAnswer", forIndexPath: indexPath) as! MultipleChoiceTableViewCell;
        
        switch indexPath.row {
        case 0:
            cell.Answer.text = "1980";
            cell.Number.image = UIImage(named: "Circled 1 Filled-50.png");
        case 1:
            cell.Answer.text = "1830";
            cell.Number.image = UIImage(named: "Circled 2 Filled-50.png");
        case 2:
            cell.Answer.text = "1880";
            cell.Number.image = UIImage(named: "Circled 3 Filled-50.png");
        case 3:
            cell.Answer.text = "1930";
            cell.Number.image = UIImage(named: "Circled 4 Filled-50.png");
        case 4:
            cell.Answer.text = "1870";
            cell.Number.image = UIImage(named: "Circled 5 Filled-50.png");
        default:
            cell.Answer.text = "Default";
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        
        return cell;
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
