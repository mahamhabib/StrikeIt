//
//  Category.swift
//  StrikeIt
//
//  Created by Maha Habib on 08/01/2020.
//  Copyright © 2020 Maha Habib. All rights reserved.
//

import Foundation
import RealmSwift

//we are able to save data to Realm by subclassing it to Object which is a Realm Object
class Category: Object {
    
    // the following syntax is used beacause it is dynamiclly updating the properties
    @objc dynamic var name : String = ""
    //List comes from Realm's framework
    let items = List<RealmItem>()
    
    
}
