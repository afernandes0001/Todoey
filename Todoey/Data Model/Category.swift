//
//  Category.swift
//  Todoey
//
//  Created by Andre Fernandes on 09/07/18.
//  Copyright © 2018 Andre Fernandes. All rights reserved.
//

import Foundation
// STEP 57 - creation of Item.swift and Category.swift

// STEP 60 - coding
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
