//
//  BracketViewController.swift
//  Tournament Manager
//
//  Created by Ishin Iwasaki on 10/6/15.
//  Copyright © 2015 ABIITJ. All rights reserved.
//

import UIKit

class BracketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //the matches that are not BYEs
    var nonByeMatches = [Match]()
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var startBut: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print (matches.count)
        assignInitialByes()
        findNonByes()
        print (nonByeMatches.count)
        tableView.reloadData()
        errorLabel.text = ""
        self.setNavigationBarItem()
        navigationItem.title = "Your Brackets"
        if (currentBracket == nil){
            navigationItem.title = "No Bracket Selected"
        }
        else
        {
            if currentBracket?.singleElim == true {
                navigationItem.title = "\(currentBracket!.name!)-(S)"
            }
            else{
                navigationItem.title = "\(currentBracket!.name!)-(D)"
            }
            if currentBracket?.started == true{
                //Don't add the "Add players" button
                startBut.setTitle("Stations List", forState: .Normal)
            }
            else {
                let addParticipantButton = UIBarButtonItem(title: "Add Players", style: UIBarButtonItemStyle.Plain, target: self, action: "addParticipantButton")
                navigationItem.rightBarButtonItem = addParticipantButton
                startBut.setTitle("Start Bracket", forState: .Normal)
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
            //Show the station view
        }
        else if (currentBracket?.numParts != nil && Int((currentBracket?.numParts)!) > 1){
            //Start bracket
            //Code filled in later
            
            currentBracket?.started = true
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            do {
                try managedContext.save()
                startBut.setTitle("Stations List", forState: .Normal)
            } catch let error as NSError {
                print("Could not save \(error)")
            }
        }
        else{
            //Number of participants not set
            errorLabel.text = "More than one participant must be active!"
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (nonByeMatches.count == 0){
            return 1
        }
        else{
            return nonByeMatches.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if currentBracket?.bracketType == nil {
            return 1 //no bracket type yet
        }
        else if currentBracket?.bracketType == 0 {
            return 2 //4-person, SE
        }
        else if currentBracket?.bracketType == 1{
            return 3 //4-person, DE
        }
        else if currentBracket?.bracketType == 2{
            return 3 //8-person, SE
        }
        else if currentBracket?.bracketType == 3{
            return 5 //8-person, DE
        }
        else if currentBracket?.bracketType == 4{
            return 4 //16-person, SE
        }
        else if currentBracket?.bracketType == 5{
            return 7 //16-person, DE
        }
        else if currentBracket?.bracketType == 6{
            return 5 //32-person, SE
        }
        else if currentBracket?.bracketType == 7{
            return 9 //32-person, DE
        }
        else if currentBracket?.bracketType == 8{
            return 6 //64-person, SE
        }
        else {
            return 11 //64-person, DE
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        if(nonByeMatches.count == 0){
            cell.textLabel!.text = "Please add some players."
        }
        else {
            let thisMatch = nonByeMatches[indexPath.row]
            var p1name: String?
            var p2name: String?
            var p1seed: Int?
            var p2seed: Int?
            if thisMatch.hasBye == 1{
                p1name = "TBD"
                p2name = thisMatch.player2!.name!
                p2seed = Int(thisMatch.player2!.seed!)
                cell.textLabel!.text = "\(p1name!) vs \(p2seed!): \(p2name!)"
            }
            else if thisMatch.hasBye == 2{
                p2name = "TBD"
                p1name = thisMatch.player1!.name!
                p1seed = Int(thisMatch.player1!.seed!)
                cell.textLabel!.text = "\(p1seed!): \(p1name!) vs \(p2name!)"
            }
            else if thisMatch.hasBye == 0{
                p1name = thisMatch.player1!.name!
                p2name = thisMatch.player2!.name!
                p1seed = Int(thisMatch.player1!.seed!)
                p2seed = Int(thisMatch.player2!.seed!)
                cell.textLabel!.text = "\(p1seed!): \(p1name!) vs \(p2seed!): \(p2name!)"
            }
            else{
                cell.textLabel!.text = "Error"
            }
        }
        return cell

    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(currentBracket?.bracketType == nil){
            return ""
        }
        else if (currentBracket?.bracketType == 0){
            switch section {
            case 0:
                return "Semi-Finals"
            case 1:
                return "Finals"
            default:
                return "Error"
            }
        }
        else if (currentBracket?.bracketType == 1){
            switch section {
            case 0:
                return "Semi-Finals"
            case 1:
                return "Finals"
            case 2:
                return "Loser Finals"
            default:
                return "Error"
            }
        }
        else if (currentBracket?.bracketType == 2){
            switch section {
            case 0:
                return "Quarter-Finals"
            case 1:
                return "Semi-Finals"
            case 2:
                return "Finals"
            default:
                return "Error"
            }
        }
        else if (currentBracket?.bracketType == 3){
            switch section{
            case 0:
                return "Quarter-Finals"
            case 1:
                return "Semi-Finals"
            case 2:
                return "Finals"
            case 3:
                return "Loser Semi-Finals"
            case 4:
                return "Loser Finals"
            default:
                return "Error"
            }
        }
        else if(currentBracket?.bracketType == 4){
            switch section{
            case 0:
                return "Round of 16"
            case 1:
                return "Quarter-Finals"
            case 2:
                return "Semi-Finals"
            case 3:
                return "Finals"
            default:
                return "Error"
            }
        }
        else if(currentBracket?.bracketType == 5){
            switch section{
            case 0:
                return "Round of 16"
            case 1:
                return "Quarter-Finals"
            case 2:
                return "Semi-Finals"
            case 3:
                return "Finals"
            case 4:
                return "Loser Quarter-Finals"
            case 5:
                return "Loser Semi-Finals"
            case 6:
                return "Loser Finals"
            default:
                return "Error"
            }
        }
        else if(currentBracket?.bracketType == 6){
            switch section {
            case 0:
                return "Round of 32"
            case 1:
                return "Round of 16"
            case 2:
                return "Quarter-Finals"
            case 3:
                return "Semi-Finals"
            case 4:
                return "Finals"
            default:
                return "Error"
            }
        }
        else if(currentBracket?.bracketType == 7){
            switch section{
            case 0:
                return "Round of 32"
            case 1:
                return "Round of 16"
            case 2:
                return "Quarter-Finals"
            case 3:
                return "Semi-Finals"
            case 4:
                return "Finals"
            case 5:
                return "Loser Round of 16"
            case 6:
                return "Loser Quarter-Finals"
            case 7:
                return "Loser Semi-Finals"
            case 8:
                return "Loser Finals"
            default:
                return "Error"
            }
        }
        else if(currentBracket?.bracketType == 8){
            switch section {
            case 0:
                return "Round of 64"
            case 1:
                return "Round of 32"
            case 2:
                return "Round of 16"
            case 3:
                return "Quarter-Finals"
            case 4:
                return "Semi-Finals"
            case 5:
                return "Finals"
            default:
                return "Error"
            }
        }
        else {
            switch section{
            case 0:
                return "Round of 64"
            case 1:
                return "Round of 32"
            case 2:
                return "Round of 16"
            case 3:
                return "Quarter-Finals"
            case 4:
                return "Semi-Finals"
            case 5:
                return "Finals"
            case 6:
                return "Loser Round of 32"
            case 7:
                return "Loser Round of 16"
            case 8:
                return "Loser Quarter-Finals"
            case 9:
                return "Loser Semi-Finals"
            case 10:
                return "Loser Finals"
            default:
                return "Error"
            }
        }
    }
    
    func findNonByes(){
        for eachMatch in matches {
            if eachMatch.hasBye==3{
                // do not add to the non-bye list
            }
            else {
                nonByeMatches.append(eachMatch)
            }
        }
    }
    
    //set up the Byes for the first round of 64
    func assignInitialByes(){
        for index in 0...31 {
            if matches[index].player1 == nil && matches[index].player2 == nil{
                //both are BYES
                matches[index].hasBye = 3
            }
            else if matches[index].player1 == nil && matches[index].player2 != nil {
                //Player 1 is a BYE
                matches[index].hasBye = 1
            }
            else if matches[index].player2 == nil && matches[index].player1 != nil{
                //Player 2 is a BYE
                matches[index].hasBye = 2
            }
            else {
                //No byes
                matches[index].hasBye = 0
            }
        }
    }
    
    //resolve the matches that have Byes in them
    func resolveByesSingle() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        for index in 0...62{
            
        }
        
        
        do {
            try managedContext.save()
            startBut.setTitle("Stations List", forState: .Normal)
        } catch let error as NSError {
            print("Could not save \(error)")
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
