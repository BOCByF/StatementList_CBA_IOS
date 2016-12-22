//
//  TransactionCell.swift
//  StatementList
//
//  Created by Shelton Han on 21/12/16.
//  Copyright © 2016 Shelton Han. All rights reserved.
//

import Foundation
import UIKit

struct TextColors {
    static let black = UIColor(red:35/255, green:31/255, blue:32/255, alpha:1.0)
}

struct TextFonts {
    static let regularText = UIFont(name: "HelveticaNeue", size: 12)
    static let boldText = UIFont(name: "HelveticaNeue-Bold", size: 12)
}

struct LocationIconConstant {
    static let show: CGFloat = 25.0
    static let hide: CGFloat = 0.0
}

// Trun a string to uppercase and replace <BR/> with \n brefore return
extension String {
    public func formattedDesc() -> String{
        return self.uppercased().replacingOccurrences(of: "<BR/>", with: "\n")
    }
}

class TransactionCell: UITableViewCell {
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var descLeadingConstraint: NSLayoutConstraint!
    
    // Refresh cell with data, sicnce this method updates all subviews that can change, it doesn't need to explicitly "return to clear" state 
    func refreshView(transaction: Transaction) {
        // Desc Label
        let descString = NSMutableAttributedString(string: "")
        if transaction.state == .Pending {
            descString.append(NSAttributedString(string: "PENDING: ", attributes: [NSFontAttributeName: TextFonts.boldText!, NSForegroundColorAttributeName: TextColors.black]))
        }
        descString.append(NSAttributedString(string: transaction.desc.formattedDesc(), attributes: [NSFontAttributeName: TextFonts.regularText!, NSForegroundColorAttributeName: TextColors.black]))
        self.desc!.attributedText = descString
        // Amount Label
        AccountDetailHeaderCell.currencyFormatter.numberStyle = .currency
        self.amount!.text = AccountDetailHeaderCell.currencyFormatter.string(from: transaction.amount)
        // hide/show ATM icon by moving the desc label to cover/uncover the icon
        self.descLeadingConstraint!.constant = (transaction.atmId != nil) ? LocationIconConstant.show : LocationIconConstant.hide
    }
    
}
