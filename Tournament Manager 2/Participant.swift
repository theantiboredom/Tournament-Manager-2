//
//  Participant.swift
//  Tournament Manager
//
//  Created by Travis Johnson on 10/26/15.
//  Copyright © 2015 ABIITJ. All rights reserved.
//

import Foundation
//class for the Participant data type
class Participant {
    var _name: String = ""
    //these get/set methods allow access through participant.name etc
    var name:  String {
        get {
            return _name
        }
        set (name){
            _name = name
        }
    }
    
    var _wins : Int = 0
    var wins: Int {
        get{
            return _wins
        }
        set (wins){
            _wins = wins
        }
    }
    
    var _losses: Int = 0
    var losses: Int {
        get{
            return _losses
        }
        set(losses){
            _losses = losses
        }
    }
    
    
    var _seed: Int = 0
    var seed: Int {
        get{
            return _seed
        }
        set(seed){
            _seed = seed
        }
    }
    
    var _cBrackets: Int = 0
    var cBrackets: Int {
        get{
            return _cBrackets
        }
        set (cBrackets) {
            _cBrackets = cBrackets
        }
    }
    //Using UnsafePointer as a place holder since I don't have the matches pointer yet
    var matches: UnsafePointer<String>
    var cMatch: UnsafePointer<String>
    //setting all the values to default 0/nil/etc for init
    init(){
        _name = ""
        _wins = 0
        _losses = 0
        _seed = 0
        _cBrackets = 0
        matches = nil
        cMatch = nil
    }
    //I made explicit get/set methods as well for more flexability
    func getName(participant: Participant) -> String {
        return participant.name
    }
    
    func getWins(participant: Participant) -> Int {
        return participant.wins
    }
    
    func getLosses(participant: Participant) -> Int {
        return participant.losses
    }
    
    func getSeed(participant: Participant) -> Int {
        return participant.seed
    }
    
    func getCurBrackets(participant: Participant) -> Int {
        return participant.cBrackets
    }
    
    func setName(name: String){
        self.name = name
    }
    
    func setWins(win: Int){
        self.wins = win
    }
    
    func setLosses(loss: Int){
        self.losses = loss
    }
    
    func setSeed(seed: Int){
        self.seed = seed
    }
    
    func setCurBrackets(curBracket: Int){
        self.cBrackets = curBracket
    }
    //This adds the wins/losses to get the total amount of matches and uses
    //that to get the percent of wins as a double
    func getWinPer(participant: Participant) -> Double {
        let win: Double = Double(getWins(participant))
        let loss: Double = Double(getLosses(participant))
        
        let total: Double = win + loss
        
        var winPercent: Double
        
        winPercent = (win/total)*100
        return winPercent
    }
    
}

