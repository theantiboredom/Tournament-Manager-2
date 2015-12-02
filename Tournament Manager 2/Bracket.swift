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

    func generateMatches(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        //single elimination tree only
        if singleElim == true {
            for index in 0...62
            {
                let entity = NSEntityDescription.entityForName("Match", inManagedObjectContext: managedContext)
                let createdMatch = Match(entity: entity!, insertIntoManagedObjectContext: managedContext)
                
                createdMatch.score_player1 = 0
                createdMatch.score_player2 = 0
                createdMatch.parent_bracket = currentBracket
                createdMatch.inProgress = false
                createdMatch.player1 = nil
                createdMatch.player2 = nil
                createdMatch.hasBye = 3 //assume all are byes at this point
                
                if (index < 62){
                    let div = index/2
                    createdMatch.next_winner = div + 32
                }
                createdMatch.next_loser = nil
                
                if index == 62 {
                    createdMatch.lastMatch = true
                }
                else{
                    createdMatch.lastMatch = false
                }
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save \(error)")
                }
            }
        }
            //double elimination
        else {
            for index in 0...126
            {
                let entity = NSEntityDescription.entityForName("Match", inManagedObjectContext: managedContext)
                let createdMatch = Match(entity: entity!, insertIntoManagedObjectContext: managedContext)
                
                createdMatch.score_player1 = 0
                createdMatch.score_player2 = 0
                createdMatch.parent_bracket = currentBracket
                createdMatch.inProgress = false
                createdMatch.player1 = nil
                createdMatch.player2 = nil
                createdMatch.hasBye = 3
                
                if (index < 62){
                    let div = index/2
                    createdMatch.next_winner = div + 32
                    
                }
                else if (index >= 63 && index <= 78){
                    createdMatch.next_winner = index + 16
                }
                else if (index >= 79 && index <= 94){
                    if(index%2 == 0){
                        let temp = (Double(index)-0.5)/2
                        createdMatch.next_winner = Int(temp) + 56
                    }
                    else{
                        createdMatch.next_winner = (index/2) + 56
                    }
                    
                }
                else if (index >= 95 && index <= 102){
                    createdMatch.next_winner = index + 8
                }
                else if (index >= 103 && index <= 110){
                    if(index%2 == 0){
                        let temp = (Double(index)-0.5)/2
                        createdMatch.next_winner = Int(temp) + 60
                    }
                    else{
                        createdMatch.next_winner = (index/2) + 60
                    }
                }
                else if (index >= 111 && index <= 114){
                    createdMatch.next_winner = index + 4
                }
                else if (index >= 115 && index <= 118){
                    if(index%2 == 0){
                        let temp = (Double(index)-0.5)/2
                        createdMatch.next_winner = Int(temp) + 62
                    }
                    else{
                        createdMatch.next_winner = (index/2) + 62
                    }
                }
                else if (index >= 119 && index <= 120) {
                    createdMatch.next_winner = index + 2
                }
                else if (index >= 121 && index <= 122){
                    createdMatch.next_winner = 123
                }
                else {
                    //123 and above 
                    createdMatch.next_winner = index + 1
                }
                
                
                //program in the next loser bracket number
                if (index >= 0 && index <= 31){
                    let div = index/2
                    createdMatch.next_loser = div + 63
                }
                
                
                if index == 126 {
                    createdMatch.lastMatch = true
                }
                else{
                    createdMatch.lastMatch = false
                }
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save \(error)")
                }
            }
            
        }
        
    }
    
    
}
