//
//  DateExtension.swift
//  VeeProject
//
//  Created by Neria Jerafi on 04/09/2020.
//  Copyright © 2020 Neria Jerafi. All rights reserved.
//

import Foundation

extension Date{
    func getDateString(dateFormat:String = "EEEE. dd.MM.yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
