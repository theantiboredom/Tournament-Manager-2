//
//  BracketViewController.swift
//  Tournament Manager
//
//  Created by Ishin Iwasaki on 10/6/15.
//  Copyright © 2015 ABIITJ. All rights reserved.
//

import UIKit

class BracketViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        let addParticipantButton = UIBarButtonItem(title: "Add Players", style: UIBarButtonItemStyle.Plain, target: self, action: "addParticipantButton")
        navigationItem.rightBarButtonItem = addParticipantButton
        navigationItem.title = "Your Brackets"
        if (currentBracket == nil){
            navigationItem.title = "No Bracket Selected"
        }
        else
        {
            navigationItem.title = currentBracket?.name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addParticipantButton(){
        var participantViewController: UIViewController!
        participantViewController = storyboard!.instantiateViewControllerWithIdentifier("ParticipantViewController") as! ParticipantViewController
        participantViewController = UINavigationController(rootViewController: participantViewController)
        self.slideMenuController()?.changeMainViewController(participantViewController, close: true)
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
