//
//  Station+CoreDataProperties.swift
//  Tournament Manager 2
//
//  Created by Ishin Iwasaki on 11/29/15.
//  Copyright © 2015 Ishin Iwasaki. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Station {

    @NSManaged var name: String?
    @NSManaged var filled: NSNumber?
    @NSManaged var time: NSNumber?
    @NSManaged var current_match: Match?

}
