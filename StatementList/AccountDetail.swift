//
//  AccountDetail.swift
//  StatementList
//
//  Created by Shelton Han on 20/12/16.
//  Copyright © 2016 Shelton Han. All rights reserved.
//

import Foundation

class AccountDetail {
    let accountName: String
    let accountNumber: String
    let availableFunds: NSNumber
    let balance: NSNumber
    
    init(withDictionary dict: [String: AnyObject]) {
        self.accountName = dict["accountName"] as? String ?? ""
        self.accountNumber = dict["accountNumber"] as? String ?? ""
        self.availableFunds = dict["availableFunds"] as? NSNumber ?? 0
        // Not sure the default value of balance as it might be nagative value
        self.balance = dict["balance"] as? NSNumber ?? 0
    }
    
}
