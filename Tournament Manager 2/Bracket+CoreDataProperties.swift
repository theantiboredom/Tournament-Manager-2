//
//  Bracket+CoreDataProperties.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 11/28/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Bracket {

    @NSManaged var active: NSNumber?
    @NSManaged var bracketType: NSNumber?
    @NSManaged var creationDate: String?
    @NSManaged var name: String?
    @NSManaged var numParts: NSNumber?
    @NSManaged var singleElim: NSNumber?
    @NSManaged var players: NSSet?
    @NSManaged var started: NSNumber? //started bracket or not, for editing participants

}
