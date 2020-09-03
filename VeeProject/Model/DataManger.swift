//
//  DataManger.swift
//  VeeProject
//
//  Created by Neria Jerafi on 03/09/2020.
//  Copyright © 2020 Neria Jerafi. All rights reserved.
//

import Foundation

class DataManager{
    private static  var sharedInstance:DataManager?
    static func getSharedInstance()->DataManager{
        if DataManager.sharedInstance == nil {
            DataManager.sharedInstance = DataManager()
        }
        return DataManager.sharedInstance!
    }
    private init(){}
}
