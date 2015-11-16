//
//  Match.swift
//  Tournament Manager 2
//
//  Created by Macbook on 11/15/15.
//  Copyright © 2015 Arturo Bustamante. All rights reserved.
//

import Foundation

//class for a match data type that will be used in a bracket tree

class Match {
    //variables in a Match include its two players, a winner, a loser and the scores
    var _PlayerOne = Participant()
    
    var PlayerOne: Participant {
        get{
            return _PlayerOne
        }
        set (PlayerOne){
            _PlayerOne = PlayerOne
        }
    }
    
    var _PlayerTwo = Participant()
    
    var PlayerTwo: Participant {
        get{
            return _PlayerTwo
        }
        set (PlayerTwo){
            _PlayerTwo = PlayerTwo
        }
    }
    
    var _Winner = Participant()
    
    var Winner: Participant {
        get{
            return _Winner
        }
        set (Winner){
            _Winner = Winner
        }
    }
    
    var _Loser = Participant()
    
    var Loser: Participant {
        get{
            return _Loser
        }
        set (Loser){
            _Loser = Loser
        }
    }
    
    var _POScore = 0
    
    var POScore: Int {
        get{
            return _POScore
        }
        set(POScore){
            _POScore = POScore
        }
    }
    
    var _PTScore = 0
    
    var PTScore: Int {
        get{
            return _PTScore
        }
        set(PTScore){
            _PTScore = PTScore
        }
    }
    
    //initialization of a Match object
    init(PlayerO: Participant, PlayerT: Participant){
        _PlayerOne = PlayerO
        _PlayerTwo = PlayerT
        _POScore = 0
        _PTScore = 0
        
        
    }
    
    
    
    
    
}