//
//  HomeViewController.swift
//  santasWorkshop
//
//  Created by Philip Deisinger on 1/23/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    var users:[NSManagedObject]? // MODEL?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var incorrectUPLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "User")
        var error:NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            users = results
        }
        
        passwordTextField.secureTextEntry = true
    }
    
    override func viewDidAppear(animated: Bool) {
        /*
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "User")
        var error:NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            users = results
        }
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginTapped(sender: AnyObject) {
        //Check for username/Password
        var foundUser = false
        for user in users! {
            if user.valueForKey("username") as NSString == usernameTextField.text && user.valueForKey("password") as NSString == passwordTextField.text {
                    foundUser = true
                    let accountViewController = storyboard?.instantiateViewControllerWithIdentifier("AccountViewController") as AccountViewController
                    accountViewController.user = user
                    
                    let navController = UINavigationController(rootViewController: accountViewController)
                    presentViewController(navController, animated: true, completion: nil)
                    break
            }
        }
        if !foundUser {
            incorrectUPLabel.text = "Sorry, incorrect Username/Password"
        }
        
    }
    
    @IBAction func createAccountTapped(sender: AnyObject) {
        let createAccountViewController = storyboard?.instantiateViewControllerWithIdentifier("CreateAccountViewController") as CreateAccountViewController
        
        createAccountViewController.users = users!
        createAccountViewController.parentVC = self
        presentViewController(createAccountViewController, animated: true, completion: nil)
    }
   
    override func viewDidDisappear(animated: Bool) {
        usernameTextField.text = ""
        passwordTextField.text = ""
        incorrectUPLabel.text  = ""
    }
    
    @IBAction func close(segue:UIStoryboardSegue) {
        println("Close")
    }
    
    
    
}