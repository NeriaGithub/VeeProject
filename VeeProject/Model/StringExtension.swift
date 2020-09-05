//
//  StringExtension.swift
//  VeeProject
//
//  Created by Neria Jerafi on 04/09/2020.
//  Copyright © 2020 Neria Jerafi. All rights reserved.
//

import Foundation

extension String {
    
    func toDate()-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        let date = dateFormatter.date(from: self)
        return date
    }
}
