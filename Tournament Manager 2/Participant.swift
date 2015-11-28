//
//  Participant.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 11/28/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//

import Foundation
import CoreData


class Participant: NSManagedObject {

    //This adds the wins/losses to get the total amount of matches and uses
    //that to get the percent of wins as a double
    func getWinPer() -> Double {
        let win: Double = Double(wins!)
        let loss: Double = Double(losses!)
        
        let total: Double = win + loss
        
        var winPercent: Double
        
        winPercent = (win/total)*100
        return winPercent
    }
}
