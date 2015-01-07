//
//  ViewController.swift
//  TouchID2
//
//  Created by Marco F.A. Corzani on 28.12.14.
//  Copyright (c) 2014 Alphaweb. All rights reserved.
//

import UIKit
import LocalAuthentication
var error: NSError?

let password: (AnyObject) = (NSUserDefaults.standardUserDefaults().objectForKey("password"))!


class touchIDViewController: UIViewController, UIAlertViewDelegate {

//    NSUserDefaults.standardUserDefaults().synchronize()
//    println(NSUserDefaults.standardUserDefaults().objectForKey("password")!)
    
    @IBOutlet weak var gesperrtLabel: UILabel!
    
    
    
    func authenticateUser() {
        // Get the local authentication context from the framework
        let context : LAContext = LAContext()
        
        // Set the reason string that will appear on the authentication alert
        var reasonString = "Authentication is needed to access your account."
        
        // Check if the device supports Touch ID
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            [context .evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics,localizedReason: reasonString, reply: {
                (success: Bool, evalPolicyError: NSError?) -> Void in
                if success {
                    self.performSegueWithIdentifier("validUser", sender: self)  // send to logged in view controller
                } else {
                    // If authentication failed then show a message to the console with a short description
                    // In case that the error is a user fallback, then show a password alert view
                    println(evalPolicyError?.localizedDescription)
                    
                    switch evalPolicyError!.code {
                    case LAError.SystemCancel.rawValue:
                        println("Authentication was cancelled by the system")
                        self.gesperrtLabel.hidden = false
                    case LAError.UserCancel.rawValue:
                        println("Authentication was cancelled by the user")
                        self.gesperrtLabel.hidden = false
                    case LAError.UserFallback.rawValue:
                        println("User selected to enter custom password")
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.showPasswordAlert()
                        })
                    default:
                        println("Authentication failed")
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            self.showPasswordAlert()
                        })
                    }
                }
            })]
        } else {
            println("Device not supported.")
            self.showPasswordAlert()
        }
    }
    
    
    
    func showPasswordAlert() {
        var passwordAlert : UIAlertView = UIAlertView(
            title: "My App",
            message: "Please type your password",
            delegate: self,
            cancelButtonTitle: "Cancel",
            otherButtonTitles: "Okay")
        passwordAlert.alertViewStyle = UIAlertViewStyle.SecureTextInput
        passwordAlert.show()
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            if !alertView.textFieldAtIndex(0)!.text.isEmpty {
                if alertView.textFieldAtIndex(0)!.text == password as NSString {  // as NSSTring ist ein Test
                    self.performSegueWithIdentifier("validUser", sender: self)
                } else {
                    showPasswordAlert()
                }
            } else {
                showPasswordAlert()
            }
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        println(NSUserDefaults.standardUserDefaults().objectForKey("password")?)
        
        gesperrtLabel.hidden = true
        authenticateUser()
    
    }

    
}

