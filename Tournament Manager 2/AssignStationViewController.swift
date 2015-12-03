//
//  AssignStationViewController.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 12/2/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//

import UIKit

class AssignStationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    //Table of Station to pick from
    @IBOutlet weak var AssignStationTable: UITableView!
    
    //Assign Status label
    @IBOutlet weak var AssignStationLabel: UILabel!
    
    //buttons to clear the station and assign the station
    
    @IBAction func ClearStation(sender: UIButton) {
        
        //stations[indexPath.row].current_match = Match?
        
        
        //insert code for timer
    }
    
    @IBAction func AssignStation(sender: UIButton) {
        //stations[indexPath.row].current_match = globalMatch
        
        //insert code for timer
        
        // This function schedules the local notification to go off at a later point dependent on the timer
        
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 5)
        notification.alertBody = "Swipe to make this go away"
        notification.alertAction = "give up"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["CustomField1": "d00t"]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.title = "Assign Match to a Station"
        let backButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton")
        navigationItem.leftBarButtonItem = backButton
        AssignStationLabel.text = "Select Station to Assign"
    }
    
    func backButton(){
        var matchViewController: UIViewController!
        
        matchViewController = storyboard!.instantiateViewControllerWithIdentifier("MatchViewController") as! MatchViewController
        matchViewController = UINavigationController(rootViewController: matchViewController)
        self.slideMenuController()?.changeMainViewController(matchViewController, close: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    } //one section
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }//enough rows for everything in te stations array
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        let stationNameRow = stations[indexPath.row].name
        let stationCMatch = stations[indexPath.row].current_match
        
        
        if (stations[indexPath.row].filled == false){
            cell.textLabel?.text = "\(stationNameRow!) - Station is Open."
            return cell
        }
            
        else{
            cell.textLabel?.text = "\(stationNameRow!) - \(stationCMatch?.player1?.name!) vs \(stationCMatch?.player2?.name!) "
            return cell
        }
        
    } //what goes in each cell
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
