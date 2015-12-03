//
//  ViewController.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 11/8/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//


import UIKit
import CoreData

//global variables
var brackets = [Bracket]()
var currentBracket: Bracket? //the current bracket in use
var competitors = [Participant]() //current participants
var stations = [Station]() //current stations
var matches = [Match]()
var defaultTimer = Int?()
var globalMatch: Match? 


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        //Retreive brackets from databse
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Bracket")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            brackets = results as! [Bracket]
            brackets.sortInPlace{$0.name!.lowercaseString < $1.name!.lowercaseString}
            print("Fetched\n")
        } catch let error as NSError {
            print ("Could not fetch \(error), \(error.userInfo)")
        }
        
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.title = "Your Brackets"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brackets.count
    }
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        var activeOrNot: String?
        if(brackets[indexPath.row].active == 0){
            activeOrNot = "Not Started"
        }
        else if (brackets[indexPath.row].active == 1)
        {
            activeOrNot = "Active"
        }
        else {
            activeOrNot = "Finished"
        }
        
        brackets.sortInPlace{$0.name!.lowercaseString < $1.name!.lowercaseString}
        let selectedBracket = brackets[indexPath.row]
        
        let bracketName = selectedBracket.name
        let bracketCreationDate = selectedBracket.creationDate
        cell.textLabel!.text = bracketName! + " " + bracketCreationDate! + " " + activeOrNot!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentBracket = brackets[indexPath.row]
        competitors = currentBracket!.players?.allObjects as! [Participant]
        matches = currentBracket!.matches?.allObjects as! [Match]
        competitors.sortInPlace{Int($0.seed!) < Int($1.seed!)}
        matches.sortInPlace{Int($0.matchNumber!) < Int($1.matchNumber!)}
        
        var bracketViewController: UIViewController!
        
        bracketViewController = storyboard!.instantiateViewControllerWithIdentifier("BracketViewController") as! BracketViewController
        bracketViewController = UINavigationController(rootViewController: bracketViewController)
        self.slideMenuController()?.changeMainViewController(bracketViewController, close: true)
    }
    
    
}

