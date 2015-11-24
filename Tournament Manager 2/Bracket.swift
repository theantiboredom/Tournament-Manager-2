//
//  Bracket.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 11/15/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//

import Foundation
import CoreData

class Bracket{
    var name: String?
    var singleElim: Bool?
    var numParticipants: Int? //number of participants 
    var bracketType: Int? //Bracket type. 0 = 4 person bracket. 1 = 8 person. 2 = 16 person. 3 = 32 person. 4 = 64 person.
    var active: Bool? //active tournament? True = active
    var creationDate: String?
    
    var competitors = [Participant]()
    
    //var matches = [Match]()
    //to be uncommented once we have Matches class 
    
    init(bracketName: String, elim: Bool, numPart: Int){
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        creationDate = formatter.stringFromDate(date)
        name = bracketName
        singleElim = elim
        numParticipants = numPart
        if(numPart < 5){
            bracketType = 0
        }
        else if (numPart >= 5 && numPart < 8){
            bracketType = 1
        }
        else if (numPart >= 8 && numPart < 16){
            bracketType = 2
        }
        else if (numPart >= 16 && numPart < 32){
            bracketType = 3
        }
        else{
            bracketType = 4
        }
        active = true
        
    }
    
    
    
}