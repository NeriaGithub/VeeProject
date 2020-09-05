//
//  Constants.swift
//  VeeProject
//
//  Created by Neria Jerafi on 04/09/2020.
//  Copyright © 2020 Neria Jerafi. All rights reserved.
//

import Foundation

struct Constants {
    // MARK: - CoreData Entity
    enum Entity:String {
        case notes = "Notes"
        case archive = "Archive"
    }
    
    // MARK: - CoreData attribute keys
    static let title = "title"
    static let content = "content"
    static let date = "date"    
}
