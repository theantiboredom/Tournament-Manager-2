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
    
    //error label
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    //elimination type boolean 
    var singleElim = false
    
    var mainViewController: UIViewController!

    //text fields
    @IBOutlet weak var bracketName: UITextField!
    @IBOutlet weak var numParticipants: UITextField!
    
    //Single or Double Elimination
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
        errorLabel.text = ""
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
        if (name == "" || numParticipants.text == ""){
            errorLabel.text = "Name/Participants cannot be blank"
        }
        else if numParts != nil{
            
            if numParts <= 0 {
                errorLabel.text = "You must have more than 0 participants!"
            }
            else if numParts > 64 {
                errorLabel.text = "Number of participants must be 64 or fewer." 
            }
            else {

                // Use Core Data functionality to add the brackets! 
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                
                let entity = NSEntityDescription.entityForName("Bracket", inManagedObjectContext: managedContext)
                let savedBracket = Bracket(entity: entity!, insertIntoManagedObjectContext: managedContext)
                
                savedBracket.name = bracketName.text
                savedBracket.active = true
                if(numParts < 5){
                    savedBracket.bracketType = 0
                }
                else if (numParts >= 5 && numParts < 8){
                    savedBracket.bracketType = 1
                }
                else if (numParts >= 8 && numParts < 16){
                    savedBracket.bracketType = 2
                }
                else if (numParts >= 16 && numParts < 32){
                    savedBracket.bracketType = 3
                }
                else{
                    savedBracket.bracketType = 4
                }
                
                let date = NSDate()
                let formatter = NSDateFormatter()
                formatter.dateFormat = "MM/dd/yyyy"
                let creationDate = formatter.stringFromDate(date)
                
                savedBracket.creationDate = creationDate
                
                savedBracket.numParts = numParts
                savedBracket.singleElim = singleElim
                savedBracket.started = false
                savedBracket.winner = nil 
                
                do {
                    try managedContext.save()
                    brackets.append(savedBracket)
                } catch let error as NSError {
                    print("Could not save \(error)")
                }
                
                currentBracket = savedBracket
                competitors = currentBracket!.players?.allObjects as! [Participant]
                
                var bracketViewController: UIViewController!
                
                bracketViewController = storyboard!.instantiateViewControllerWithIdentifier("BracketViewController") as! BracketViewController
                bracketViewController = UINavigationController(rootViewController: bracketViewController)
                self.slideMenuController()?.changeMainViewController(bracketViewController, close: true)
            } //end else
            
        } //end elseif 
        else {
            errorLabel.text = "Participants must be a number"
        }
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
