//
//  Data.swift
//  StrikeIt
//
//  Created by Maha Habib on 07/01/2020.
//  Copyright © 2020 Maha Habib. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
}
