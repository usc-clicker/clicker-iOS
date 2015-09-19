//
//  SecondViewController.swift
//  Clicker
//
//  Created by Michael on 9/18/15.
//  Copyright © 2015 Bokun Xu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var coursesArray: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.coursesArray.addObject("CSCI401    Capstone: Design and Construction of Large Software Systems")
        self.coursesArray.addObject("ACCT410    Foundations of Accounting")
        self.coursesArray.addObject("ITP344     Advanced Topics in Mobile App Development")
        self.coursesArray.addObject("WRIT340    Advanced Writing")
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coursesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = self.coursesArray.objectAtIndex(indexPath.row) as? String
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

