//
//  Stations.swift
//  Tournament Manager 2
//
//  Created by Macbook on 11/15/15.
//  Copyright © 2015 Arturo Bustamante. All rights reserved.
//

import Foundation

class Station {
    // A station includes the name of the station as well as whether it is filled or not and what match it is filled with
    
    var _name: String = ""
    
    var name:  String {
        get {
            return _name
        }
        set (name){
            _name = name
        }
    }
    
    //using a boolean to define whether it is filled or not with a match
    var _fill: Bool = false
    
    var fill: Bool {
        get {
            return _fill
        }
        set (fill){
            _fill = fill
        }
    }
    
    var _CurrentMatch: Match?
    
    init(){
        _fill = false
        _name = ""
    }
    
}