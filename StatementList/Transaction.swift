//
//  Transaction.swift
//  StatementList
//
//  Created by Shelton Han on 20/12/16.
//  Copyright © 2016 Shelton Han. All rights reserved.
//

import Foundation

enum TransactionState: Int {
    case Pending = 1
    case Settled
}

class Transaction {
    static var dateFormatter = DateFormatter()
    
    let effectiveDate: Date
    let desc: String
    let amount: NSNumber
    let atmId: String?
    let state: TransactionState
    
    init(withDictionary dict: [String: AnyObject], state: TransactionState = .Settled) {
        Transaction.dateFormatter.dateFormat = "dd/MM/yyyy"
        if let dateString = dict["effectiveDate"] as? String, let date = Transaction.dateFormatter.date(from: dateString) {
            self.effectiveDate = date
        } else {
            self.effectiveDate = Date()
        }
        self.desc = dict["description"] as? String ?? ""
        self.amount = dict["amount"] as? NSNumber ?? 0
        self.atmId = dict["atmId"] as? String
        self.state = state
    }
    
}
















