//
//  FirstViewController.swift
//  Clicker
//
//  Created by Michael on 9/18/15.
//  Copyright © 2015 Bokun Xu. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tabBarController?.tabBar.barStyle = UIBarStyle.Black
        self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

