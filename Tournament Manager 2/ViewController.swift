//
//  ViewController.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 11/8/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//


import UIKit
import CoreData

var brackets = [NSManagedObject]()

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let fetchRequest = NSFetchRequest(entityName: "Person")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        //Retreive brackets from databse
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Bracket")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            brackets = results as! [NSManagedObject]
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
        let cell =
        tableView.dequeueReusableCellWithIdentifier("Cell")
        
        var activeOrNot: String?
        if(brackets[indexPath.row].valueForKey("active") as? Bool == true){
            activeOrNot = "Active"
        }
        else
        {
            activeOrNot = "Inactive"
        }
        
        let currentBracket = brackets[indexPath.row]
        
        let bracketName = currentBracket.valueForKey("name") as? String
        let bracketCreationDate = currentBracket.valueForKey("creationDate") as? String
        
        cell!.textLabel!.text = bracketName! + " " + bracketCreationDate! + " " + activeOrNot!
        
        return cell!
    }
    
    
    
}

