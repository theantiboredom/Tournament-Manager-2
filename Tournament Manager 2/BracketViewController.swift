//
//  BracketViewController.swift
//  Tournament Manager
//
//  Created by Ishin Iwasaki on 10/6/15.
//  Copyright © 2015 ABIITJ. All rights reserved.
//

import UIKit

class BracketViewController: UIViewController {

    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var startBut: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        errorLabel.text = ""
        self.setNavigationBarItem()
        navigationItem.title = "Your Brackets"
        if (currentBracket == nil){
            navigationItem.title = "No Bracket Selected"
        }
        else
        {
            navigationItem.title = currentBracket?.name
            if currentBracket?.started == true{
                //Don't add the "Add players" button
                startBut.setTitle("Started", forState: .Normal)
            }
            else {
                let addParticipantButton = UIBarButtonItem(title: "Add Players", style: UIBarButtonItemStyle.Plain, target: self, action: "addParticipantButton")
                navigationItem.rightBarButtonItem = addParticipantButton
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addParticipantButton(){
        
        if currentBracket?.started == true{
            //Do nothing if the current Bracket is already started - user cannot change
            errorLabel.text = "Bracket already started"
        }
        else {
            var participantViewController: UIViewController!
            participantViewController = storyboard!.instantiateViewControllerWithIdentifier("ParticipantViewController") as! ParticipantViewController
            participantViewController = UINavigationController(rootViewController: participantViewController)
            self.slideMenuController()?.changeMainViewController(participantViewController, close: true)
        }
        

    }
    
    @IBAction func startBracket(sender: AnyObject) {
        if currentBracket!.started == true {
            //do nothing if the bracket is started
        }
        else if (competitors.count == currentBracket?.numParts){
            //Start bracket 
            //Code filled in later 
            
            currentBracket?.started = true
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            do {
                try managedContext.save()
                startBut.setTitle("Started", forState: .Normal)
            } catch let error as NSError {
                print("Could not save \(error)")
            }
        }
        else{
            //Number of participants not set
            errorLabel.text = "No. of participants is incomplete."
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
