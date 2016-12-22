//
//  AccountDetailHeaderCell.swift
//  StatementList
//
//  Created by Shelton Han on 21/12/16.
//  Copyright © 2016 Shelton Han. All rights reserved.
//

import Foundation
import UIKit

class AccountDetailHeaderCell: UITableViewCell {
    static var currencyFormatter = NumberFormatter()
    
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var availableFunds: UILabel!
    @IBOutlet weak var balance: UILabel!
    
    // Refresh cell with data, sicnce this method updates all subviews that can change, it doesn't need to explicitly "return to clear" state 
    func refreshView(accountDetail: AccountDetail) {
        // AccountName & AccountNumber Labels
        accountName!.text = accountDetail.accountName
        accountNumber!.text = accountDetail.accountNumber
        
        // AvailableFunds and balance Labels
        AccountDetailHeaderCell.currencyFormatter.numberStyle = .currency
        availableFunds!.text = AccountDetailHeaderCell.currencyFormatter.string(from: accountDetail.availableFunds)
        balance!.text = AccountDetailHeaderCell.currencyFormatter.string(from: accountDetail.balance)
    }
    
}
