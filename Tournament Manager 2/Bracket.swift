//
//  Bracket.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 11/28/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Bracket: NSManagedObject {

    //at bracket creation, create the match objects that will be associated with the bracket
    //This is for a bracket type 0 - 4 players
    //Next winner/loser will be set in a different function
    func generateMatchesType0(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        //single elimination tree only
        if singleElim == true {
            for index in 0...3
            {
                let entity = NSEntityDescription.entityForName("Match", inManagedObjectContext: managedContext)
                let createdMatch = Match(entity: entity!, insertIntoManagedObjectContext: managedContext)
                
                createdMatch.score_player1 = 0
                createdMatch.score_player2 = 0
                createdMatch.parent_bracket = currentBracket
                createdMatch.inProgress = false
                createdMatch.player1 = nil
                createdMatch.player2 = nil
                if index == 3 {
                    createdMatch.lastMatch = true
                }
                else{
                    createdMatch.lastMatch = false
                }
            }
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save \(error)")
            }
        }
        //double elimination
        else {
            
        }

    }
    
    
    

    
}
