//
//  AppValues.swift
//  On The Map
//
//  Created by Lyn Almasri on 11/16/18.
//  Copyright © 2018 lynmasri. All rights reserved.
//

import Foundation

class AppValues {
    static var delegate : AppValuesDelegate?
    static var currentUser = User()
    private static var locations = [StudentLocation]()
    
    static func setLocations(locations:[StudentLocation]) {
        self.locations = locations
        if let delegate = delegate{
            delegate.appValuesDidChange()
        }
    }
    
    static func getLocations()->[StudentLocation]{
        return locations
    }
}

protocol AppValuesDelegate : class{
    func appValuesDidChange()
}
