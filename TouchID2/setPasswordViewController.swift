//
//  setPasswordViewController.swift
//  TouchID2
//
//  Created by Marco F.A. Corzani on 31.12.14.
//  Copyright (c) 2014 Alphaweb. All rights reserved.
//

import UIKit

class setPasswordViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var passwordTextField1: UITextField!
    
    @IBOutlet weak var passwordTextField2: UITextField!
    
    
    override func viewDidAppear(animated: Bool) {
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("password")?) != nil {
            
            warningLabel.text = "You already set a password"
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
       }

    
    @IBAction func setPasswordButtonPressed(sender: AnyObject) {
    
         if passwordTextField1.text.isEmpty  || passwordTextField2.text.isEmpty  {
            
          println("One or more Fields are empty")
            
            warningLabel.text = "Please enter your password two times"
        }
        
        else if passwordTextField1.text != passwordTextField2.text {
        
            warningLabel.text = "Your passwords dont match"
        
        } 
         else  {
        
            warningLabel.text = "Password saved, please dont forget"
            

        
                NSUserDefaults.standardUserDefaults().setObject(passwordTextField2.text, forKey: "password")
            
                NSUserDefaults.standardUserDefaults().synchronize()
            
            
                println(NSUserDefaults.standardUserDefaults().objectForKey("password"))
           
            }
    
       
    
    }
    
    
    @IBAction func resetButtonPressed(sender: AnyObject) {
    
    
        NSUserDefaults.standardUserDefaults().removeObjectForKey("password")
        NSUserDefaults.standardUserDefaults().synchronize()
        warningLabel.text = "Warning! No password is set for your app!"
        println(NSUserDefaults.standardUserDefaults().objectForKey("password"))
    }
}






