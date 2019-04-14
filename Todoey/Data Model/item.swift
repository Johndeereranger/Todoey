//
//  item.swift
//  Todoey
//
//  Created by Amie Smith on 4/11/19.
//  Copyright © 2019 Amie Smith. All rights reserved.
// created lec 229 5:50  creating a custom class

import Foundation

class Item: Codable{
    //added encodable on 233 7:34.    added decodeable lec 234 
    
    
    // added lec 229 7:36
    var title : String = ""
    var done : Bool = false
}
