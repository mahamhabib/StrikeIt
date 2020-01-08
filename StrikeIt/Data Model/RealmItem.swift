//
//  RealmItem.swift
//  StrikeIt
//
//  Created by Maha Habib on 08/01/2020.
//  Copyright © 2020 Maha Habib. All rights reserved.
//

import Foundation
import RealmSwift

class RealmItem: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    //inverse relationship
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
