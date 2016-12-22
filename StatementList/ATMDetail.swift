//
//  ATMDetail.swift
//  StatementList
//
//  Created by Shelton Han on 20/12/16.
//  Copyright © 2016 Shelton Han. All rights reserved.
//

import Foundation
import MapKit

class ATMDetial {
    let id: String
    let name: String
    let address: String
    let location: CLLocation?
    
    init(withDictionary dict: [String: AnyObject]) {
        self.id = dict["id"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.address = dict["address"] as? String ?? ""
        if let localtionDict = dict["location"] as? [String: AnyObject], let lat = localtionDict["lat"] as? NSNumber, let lng = localtionDict["lng"] as? NSNumber {
            self.location = CLLocation(latitude: lat.doubleValue, longitude: lng.doubleValue)
        } else {
            self.location = nil
        }
    }
    
}
