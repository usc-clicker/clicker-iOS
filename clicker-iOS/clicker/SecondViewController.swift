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
    var coursesArray2: NSMutableArray! = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
            
        self.coursesArray.addObject("BUAD 301: Technology Entrepreneurship")
        self.coursesArray.addObject("CSCI 350: Introduction to Operating Systems")
        self.coursesArray.addObject("EE 364: Introduction to Probability and Statistics")
        self.coursesArray.addObject("GEOL 240: Earthquakes")
        
        self.coursesArray2.addObject("Miller                                                                                       14640")
        self.coursesArray2.addObject("Crowley                                                                                   30061")
        self.coursesArray2.addObject("Mendel                                                                                    30778")
        self.coursesArray2.addObject("Dolan                                                                                       24950")
        
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
        cell.detailTextLabel?.text = self.coursesArray2.objectAtIndex(indexPath.row) as? String
        cell.detailTextLabel?.textColor = UIColor.grayColor()
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

