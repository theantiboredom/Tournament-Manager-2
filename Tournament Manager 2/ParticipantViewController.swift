//
//  ParticipantViewController.swift
//  Tournament Manager
//
//  Created by Ishin Iwasaki on 10/6/15.
//  Copyright © 2015 ABIITJ. All rights reserved.
//

import UIKit
import CoreData

class ParticipantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Table views
    @IBOutlet weak var tableView1: UITableView!
    
    //Labels 
    @IBOutlet weak var topLabel: UILabel!
    
    //TextFields
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var seedField: UITextField!
    
    
    //selected participant index in this view
    var selectedParticipant: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.title = "Add Participants"
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton")
        navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backButton(){
        var bracketViewController: UIViewController!
        
        bracketViewController = storyboard!.instantiateViewControllerWithIdentifier("BracketViewController") as! BracketViewController
        bracketViewController = UINavigationController(rootViewController: bracketViewController)
        self.slideMenuController()?.changeMainViewController(bracketViewController, close: true)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitors.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        let competitorName = competitors[indexPath.row].name
        let competitorSeed = competitors[indexPath.row].seed
        cell.textLabel?.text = "\(competitorName!) Seed: \(competitorSeed!)"
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Participants in Bracket: \(competitors.count) Max: \(Int((currentBracket?.numParts)!))"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedParticipant = indexPath.row
    }
    
    @IBAction func addNewButton(sender: AnyObject) {
        if(nameField.text == "" || seedField.text == ""){
            topLabel.text = "Name/Seed cannot be blank"
        }
        else if ((Int(seedField.text!)) != nil){
            let chosenName = nameField.text
            let chosenSeed = Int(seedField.text!)
            
            
            if(chosenSeed! > Int(currentBracket!.numParts!)){
                //case where the seed is higher than the number of participants
                topLabel.text = "Seed cannot exceed # participants"
            }
            else if(seedExists(chosenSeed!) == true){
                //case where the seed is doubled up
                topLabel.text = "This seed already exists"
            }
            else if(chosenSeed! <= 0){
                //case where the seed is 0 or lower 
                topLabel.text = "Seed cannot be lower than 1"
            }
            else {
                //success case
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let managedContext = appDelegate.managedObjectContext
                
                let entity = NSEntityDescription.entityForName("Participant", inManagedObjectContext: managedContext)
                let newParticipant = Participant(entity: entity!, insertIntoManagedObjectContext: managedContext)
                newParticipant.name = chosenName
                newParticipant.seed = chosenSeed
                newParticipant.wins = 0
                newParticipant.losses = 0
                newParticipant.parent_bracket = currentBracket
                
                do {
                    try managedContext.save()
                    competitors.append(newParticipant)
                    tableView1.reloadData()
                } catch let error as NSError {
                    print("Could not save \(error)")
                }
                nameField.text = ""
                seedField.text = ""
            }

            
        }
        else {
            topLabel.text = "Seed must be a number"
        }
    }
    
    
    @IBAction func deleteButton(sender: AnyObject) {
        if (selectedParticipant == nil){
            topLabel.text = "Select player to delete"
        }
        else {
            //player is selected, delete it 
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            managedContext.deleteObject(competitors[selectedParticipant!])
            competitors.removeAtIndex(selectedParticipant!)
            do {
                try managedContext.save()
                tableView1.reloadData()
            } catch let error as NSError {
                print("Could not delete \(error)")
            }
        }
    }
    
    
    
    //makes sure that seeds do not double up
    func seedExists(checkSeed: Int) -> Bool {
        for player in competitors {
            if player.seed == checkSeed {
                return true
            }
        }
        return false
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
