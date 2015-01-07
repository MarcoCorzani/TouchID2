//
//  CheckViewController.swift
//  TouchID2
//
//  Created by Marco F.A. Corzani on 31.12.14.
//  Copyright (c) 2014 Alphaweb. All rights reserved.
//

import UIKit


class CheckViewController: UIViewController {

    
    
    override func viewDidAppear(animated: Bool) {

//                Zum Löschen des Passworts und deaktivierung von TouchID unkommentieren und laufen lassen!
//                NSUserDefaults.standardUserDefaults().removeObjectForKey("password")
//                NSUserDefaults.standardUserDefaults().synchronize()
        
                println((NSUserDefaults.standardUserDefaults().objectForKey("password")))
        
                if (NSUserDefaults.standardUserDefaults().objectForKey("password")?) != nil {
        
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    var viewController = mainStoryboard.instantiateViewControllerWithIdentifier("TouchID") as UIViewController
                    UIApplication.sharedApplication().keyWindow?.rootViewController = viewController
        
                } else {
        
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    var viewController = mainStoryboard.instantiateViewControllerWithIdentifier("StoryBoardIDDrin") as UIViewController
                    UIApplication.sharedApplication().keyWindow?.rootViewController = viewController
                }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    

}
