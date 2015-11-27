//
//  AddViewController.swift
//  Tournament Manager
//
//  Created by Ishin Iwasaki on 10/6/15.
//  Copyright © 2015 ABIITJ. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    //elimination type boolean 
    var singleElim = false
    
    var mainViewController: UIViewController!

    @IBOutlet weak var bracketName: UITextField!
    @IBOutlet weak var numParticipants: UITextField!
    
    @IBOutlet weak var elimType: UISegmentedControl!
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch elimType.selectedSegmentIndex {
        case 0:
            singleElim = true
        case 1:
            singleElim = false
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.title = "Add Bracket"
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButton")
        navigationItem.leftBarButtonItem = cancelButton
        bracketName.text = ""
        numParticipants.text = ""
    }
    
    
    func cancelButton(){
        let mainViewController = storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        self.mainViewController = UINavigationController(rootViewController: mainViewController)
        self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createButton(sender: AnyObject) {
        let name = bracketName.text
        let numParts = Int(numParticipants.text!)
        
        let createdBracket = Bracket(bracketName: name!, elim: singleElim, numPart: numParts!)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Bracket", inManagedObjectContext: managedContext)
        let savedBracket = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        savedBracket.setValue(createdBracket.name, forKey: "name")
        savedBracket.setValue(createdBracket.active, forKey: "active")
        savedBracket.setValue(createdBracket.bracketType, forKey: "bracketType")
        savedBracket.setValue(createdBracket.creationDate, forKey: "creationDate")
        savedBracket.setValue(createdBracket.numParticipants, forKey: "numParts")
        savedBracket.setValue(createdBracket.singleElim, forKey: "singleElim")
        
        do {
            try managedContext.save()
            brackets.append(savedBracket)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        currentBracket = createdBracket
        
        var bracketViewController: UIViewController!

        bracketViewController = storyboard!.instantiateViewControllerWithIdentifier("BracketViewController") as! BracketViewController
        bracketViewController = UINavigationController(rootViewController: bracketViewController)
        self.slideMenuController()?.changeMainViewController(bracketViewController, close: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
